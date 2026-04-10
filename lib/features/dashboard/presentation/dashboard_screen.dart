import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/dashboard_provider.dart';
import '../../scanner/providers/scanner_provider.dart';
import 'widgets/spending_summary_card.dart';
import 'widgets/monthly_trend_chart.dart';
import 'widgets/category_donut_chart.dart';
import 'widgets/top_subscriptions_chart.dart';
import 'widgets/recent_payments_list.dart';
import '../../../database/app_database.dart';
import '../../../shared/widgets/empty_state.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboard = ref.watch(dashboardProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SubTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.radar),
            tooltip: 'Scan emails',
            onPressed: () => context.push('/scan'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: dashboard.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboard.error != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 12),
                  Text(dashboard.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(dashboardProvider.notifier).loadDashboard(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : dashboard.activeSubscriptionCount == 0 &&
                dashboard.recentPayments.isEmpty
          ? EmptyState(
              icon: Icons.inbox_outlined,
              title: 'No subscriptions found',
              subtitle: 'Scan your Gmail to detect recurring subscriptions',
              actionLabel: 'Start Scan',
              onAction: () => context.push('/scan'),
            )
          : RefreshIndicator(
              onRefresh: () async {
                // Trigger incremental scan and reload
                await ref.read(scannerProvider.notifier).incrementalScan();
                await ref.read(dashboardProvider.notifier).loadDashboard();
              },
              child: _buildDashboardContent(context, ref, dashboard),
            ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              break; // already here
            case 1:
              context.go('/subscriptions');
            case 2:
              context.go('/settings');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined),
            selectedIcon: Icon(Icons.list),
            label: 'Subscriptions',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    DashboardData dashboard,
  ) {
    // Build subscription map for recent payments display
    final subMap = <int, Subscription>{};
    for (final sub in dashboard.topSubscriptions) {
      subMap[sub.id] = sub;
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SpendingSummaryCard(
          totalMonthly: dashboard.totalMonthlySpend,
          totalAllTime: dashboard.totalAllTimeSpend,
          activeCount: dashboard.activeSubscriptionCount,
        ),
        const SizedBox(height: 16),
        MonthlyTrendChart(monthlyData: dashboard.monthlyTrend),
        const SizedBox(height: 16),
        CategoryDonutChart(categorySpend: dashboard.categorySpend),
        const SizedBox(height: 16),
        TopSubscriptionsChart(topSubscriptions: dashboard.topSubscriptions),
        const SizedBox(height: 16),
        RecentPaymentsList(
          payments: dashboard.recentPayments,
          subscriptionMap: subMap,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
