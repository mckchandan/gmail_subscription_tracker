import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../database/app_database.dart';
import '../../scanner/providers/scanner_provider.dart';
import '../../../core/extensions.dart';

enum SubscriptionFilter { all, active, cancelled }

enum SubscriptionSort { costHighToLow, name, dateAdded, totalSpent }

class SubscriptionsListState {
  final List<Subscription> subscriptions;
  final SubscriptionFilter filter;
  final SubscriptionSort sort;
  final String? categoryFilter;
  final String searchQuery;
  final bool isLoading;
  final Map<int, double> totalSpentMap;

  const SubscriptionsListState({
    this.subscriptions = const [],
    this.filter = SubscriptionFilter.all,
    this.sort = SubscriptionSort.costHighToLow,
    this.categoryFilter,
    this.searchQuery = '',
    this.isLoading = true,
    this.totalSpentMap = const {},
  });

  List<Subscription> get filteredSubscriptions {
    var list = List<Subscription>.from(subscriptions);

    // Apply status filter
    switch (filter) {
      case SubscriptionFilter.active:
        list = list.where((s) => s.isActive).toList();
      case SubscriptionFilter.cancelled:
        list = list.where((s) => !s.isActive).toList();
      case SubscriptionFilter.all:
        break;
    }

    // Apply category filter
    if (categoryFilter != null) {
      list = list.where((s) => s.serviceCategory == categoryFilter).toList();
    }

    // Apply search
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list
          .where(
            (s) =>
                s.serviceName.toLowerCase().contains(q) ||
                s.senderDomain.toLowerCase().contains(q),
          )
          .toList();
    }

    // Apply sort
    switch (sort) {
      case SubscriptionSort.costHighToLow:
        list.sort((a, b) {
          final aCost = a.typicalAmount.toMonthly(a.billingCycle);
          final bCost = b.typicalAmount.toMonthly(b.billingCycle);
          return bCost.compareTo(aCost);
        });
      case SubscriptionSort.name:
        list.sort((a, b) => a.serviceName.compareTo(b.serviceName));
      case SubscriptionSort.dateAdded:
        list.sort((a, b) => b.firstSeenDate.compareTo(a.firstSeenDate));
      case SubscriptionSort.totalSpent:
        list.sort((a, b) {
          final aTotal = totalSpentMap[a.id] ?? 0;
          final bTotal = totalSpentMap[b.id] ?? 0;
          return bTotal.compareTo(aTotal);
        });
    }

    return list;
  }

  SubscriptionsListState copyWith({
    List<Subscription>? subscriptions,
    SubscriptionFilter? filter,
    SubscriptionSort? sort,
    String? categoryFilter,
    String? searchQuery,
    bool? isLoading,
    Map<int, double>? totalSpentMap,
    bool clearCategory = false,
  }) => SubscriptionsListState(
    subscriptions: subscriptions ?? this.subscriptions,
    filter: filter ?? this.filter,
    sort: sort ?? this.sort,
    categoryFilter: clearCategory
        ? null
        : (categoryFilter ?? this.categoryFilter),
    searchQuery: searchQuery ?? this.searchQuery,
    isLoading: isLoading ?? this.isLoading,
    totalSpentMap: totalSpentMap ?? this.totalSpentMap,
  );
}

final subscriptionsProvider =
    StateNotifierProvider<SubscriptionsNotifier, SubscriptionsListState>((ref) {
      final db = ref.watch(databaseProvider);
      return SubscriptionsNotifier(db);
    });

class SubscriptionsNotifier extends StateNotifier<SubscriptionsListState> {
  final AppDatabase _db;

  SubscriptionsNotifier(this._db) : super(const SubscriptionsListState()) {
    loadSubscriptions();
  }

  Future<void> loadSubscriptions() async {
    state = state.copyWith(isLoading: true);
    try {
      final subs = await _db.subscriptionDao.getAllSubscriptions();

      // Calculate total spent for each subscription
      final totalMap = <int, double>{};
      for (final sub in subs) {
        totalMap[sub.id] = await _db.paymentDao.totalSpentForSubscription(
          sub.id,
        );
      }

      state = state.copyWith(
        subscriptions: subs,
        totalSpentMap: totalMap,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setFilter(SubscriptionFilter filter) =>
      state = state.copyWith(filter: filter);

  void setSort(SubscriptionSort sort) => state = state.copyWith(sort: sort);

  void setCategoryFilter(String? category) => state = category == null
      ? state.copyWith(clearCategory: true)
      : state.copyWith(categoryFilter: category);

  void setSearchQuery(String query) =>
      state = state.copyWith(searchQuery: query);

  Future<void> toggleActive(int id, bool active) async {
    await _db.subscriptionDao.toggleActive(id, active);
    await loadSubscriptions();
  }

  Future<void> deleteSubscription(int id) async {
    await _db.paymentDao.deletePaymentsForSubscription(id);
    await _db.subscriptionDao.deleteSubscription(id);
    await loadSubscriptions();
  }
}
