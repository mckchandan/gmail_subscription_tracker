import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/subscriptions_provider.dart';
import 'widgets/subscription_card.dart';
import '../../../shared/widgets/empty_state.dart';

class SubscriptionsListScreen extends ConsumerStatefulWidget {
  const SubscriptionsListScreen({super.key});

  @override
  ConsumerState<SubscriptionsListScreen> createState() =>
      _SubscriptionsListScreenState();
}

class _SubscriptionsListScreenState
    extends ConsumerState<SubscriptionsListScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(subscriptionsProvider);
    final notifier = ref.read(subscriptionsProvider.notifier);

    final filtered = state.filteredSubscriptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
        actions: [
          PopupMenuButton<SubscriptionSort>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort by',
            onSelected: notifier.setSort,
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: SubscriptionSort.costHighToLow,
                child: Text('Cost (High → Low)'),
              ),
              PopupMenuItem(value: SubscriptionSort.name, child: Text('Name')),
              PopupMenuItem(
                value: SubscriptionSort.dateAdded,
                child: Text('Date Added'),
              ),
              PopupMenuItem(
                value: SubscriptionSort.totalSpent,
                child: Text('Total Spent'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search subscriptions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          notifier.setSearchQuery('');
                        },
                      )
                    : null,
              ),
              onChanged: notifier.setSearchQuery,
            ),
          ),
          const SizedBox(height: 8),
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: 'All',
                  selected: state.filter == SubscriptionFilter.all,
                  onSelected: () => notifier.setFilter(SubscriptionFilter.all),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Active',
                  selected: state.filter == SubscriptionFilter.active,
                  onSelected: () =>
                      notifier.setFilter(SubscriptionFilter.active),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Cancelled',
                  selected: state.filter == SubscriptionFilter.cancelled,
                  onSelected: () =>
                      notifier.setFilter(SubscriptionFilter.cancelled),
                ),
                const SizedBox(width: 16),
                ..._buildCategoryChips(state, notifier),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                ? const EmptyState(
                    icon: Icons.search_off,
                    title: 'No subscriptions match',
                    subtitle: 'Try a different filter or search term',
                  )
                : RefreshIndicator(
                    onRefresh: notifier.loadSubscriptions,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final sub = filtered[i];
                        return SubscriptionCard(
                          subscription: sub,
                          totalSpent: state.totalSpentMap[sub.id],
                          onTap: () => context.push('/subscriptions/${sub.id}'),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/subscriptions/add'),
        tooltip: 'Add manually',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {
          switch (i) {
            case 0:
              context.go('/dashboard');
            case 1:
              break;
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

  List<Widget> _buildCategoryChips(
    SubscriptionsListState state,
    SubscriptionsNotifier notifier,
  ) {
    final categories = state.subscriptions
        .map((s) => s.serviceCategory)
        .where((c) => c != null)
        .toSet()
        .toList();

    return categories.map((cat) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: _FilterChip(
          label: cat!,
          selected: state.categoryFilter == cat,
          onSelected: () {
            if (state.categoryFilter == cat) {
              notifier.setCategoryFilter(null);
            } else {
              notifier.setCategoryFilter(cat);
            }
          },
        ),
      );
    }).toList();
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}
