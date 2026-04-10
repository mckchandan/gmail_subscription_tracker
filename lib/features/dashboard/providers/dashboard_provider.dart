import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/app_database.dart';
import '../../scanner/providers/scanner_provider.dart';
import '../../../core/extensions.dart';

/// Dashboard data model
class DashboardData {
  final double totalMonthlySpend;
  final double totalAllTimeSpend;
  final int activeSubscriptionCount;
  final List<Subscription> topSubscriptions;
  final List<Payment> recentPayments;
  final Map<DateTime, double> monthlyTrend; // month -> total
  final Map<String, double> categorySpend; // category -> total monthly
  final bool isLoading;
  final String? error;

  const DashboardData({
    this.totalMonthlySpend = 0,
    this.totalAllTimeSpend = 0,
    this.activeSubscriptionCount = 0,
    this.topSubscriptions = const [],
    this.recentPayments = const [],
    this.monthlyTrend = const {},
    this.categorySpend = const {},
    this.isLoading = true,
    this.error,
  });
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardData>((ref) {
  final db = ref.watch(databaseProvider);
  return DashboardNotifier(db);
});

class DashboardNotifier extends StateNotifier<DashboardData> {
  final AppDatabase _db;

  DashboardNotifier(this._db) : super(const DashboardData()) {
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    state = const DashboardData(isLoading: true);
    try {
      // Get all active subscriptions
      final activeSubs = await _db.subscriptionDao.getActiveSubscriptions();
      final allSubs = await _db.subscriptionDao.getAllSubscriptions();

      // Calculate total monthly spend from active subs
      double totalMonthly = 0;
      for (final sub in activeSubs) {
        totalMonthly += sub.typicalAmount.toMonthly(sub.billingCycle);
      }

      // Total all-time spend from all payments
      final totalAllTime = await _db.paymentDao.totalSpentAllTime();

      // Top 5 most expensive (sorted by monthly cost)
      final sortedSubs = List<Subscription>.from(allSubs)
        ..sort((a, b) {
          final aCost = a.typicalAmount.toMonthly(a.billingCycle);
          final bCost = b.typicalAmount.toMonthly(b.billingCycle);
          return bCost.compareTo(aCost);
        });
      final topSubs = sortedSubs.take(5).toList();

      // Recent payments
      final recentPayments = await _db.paymentDao.getRecentPayments(limit: 5);

      // Monthly trend (last 12 months)
      final monthlyTrend = await _db.paymentDao.monthlySpending(12);

      // Spending by category
      final categorySpend = <String, double>{};
      for (final sub in activeSubs) {
        final cat = sub.serviceCategory ?? 'Other';
        final monthly = sub.typicalAmount.toMonthly(sub.billingCycle);
        categorySpend[cat] = (categorySpend[cat] ?? 0) + monthly;
      }

      state = DashboardData(
        totalMonthlySpend: totalMonthly,
        totalAllTimeSpend: totalAllTime,
        activeSubscriptionCount: activeSubs.length,
        topSubscriptions: topSubs,
        recentPayments: recentPayments,
        monthlyTrend: monthlyTrend,
        categorySpend: categorySpend,
        isLoading: false,
      );
    } catch (e) {
      state = DashboardData(
        isLoading: false,
        error: 'Failed to load dashboard: $e',
      );
    }
  }
}
