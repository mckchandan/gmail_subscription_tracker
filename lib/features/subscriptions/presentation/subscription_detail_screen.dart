import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/subscriptions_provider.dart';
import '../../scanner/providers/scanner_provider.dart';
import 'widgets/payment_history_table.dart';
import '../../../database/app_database.dart';
import '../../../core/extensions.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../theme/app_colors.dart';

/// Provider for a single subscription's payment list
final subscriptionPaymentsProvider = FutureProvider.family<List<Payment>, int>((
  ref,
  subscriptionId,
) {
  final db = ref.watch(databaseProvider);
  return db.paymentDao.getPaymentsForSubscription(subscriptionId);
});

/// Provider for total spent on a subscription
final subscriptionTotalProvider = FutureProvider.family<double, int>((
  ref,
  subscriptionId,
) {
  final db = ref.watch(databaseProvider);
  return db.paymentDao.totalSpentForSubscription(subscriptionId);
});

class SubscriptionDetailScreen extends ConsumerWidget {
  final int subscriptionId;

  const SubscriptionDetailScreen({super.key, required this.subscriptionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subsState = ref.watch(subscriptionsProvider);
    final paymentsAsync = ref.watch(
      subscriptionPaymentsProvider(subscriptionId),
    );
    final totalAsync = ref.watch(subscriptionTotalProvider(subscriptionId));
    final theme = Theme.of(context);

    final subscription = subsState.subscriptions
        .where((s) => s.id == subscriptionId)
        .firstOrNull;

    if (subscription == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Subscription')),
        body: const Center(child: Text('Subscription not found')),
      );
    }

    final monthlyCost = subscription.typicalAmount.toMonthly(
      subscription.billingCycle,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(subscription.serviceName),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  subscription.isActive
                      ? 'Mark as Cancelled'
                      : 'Mark as Active',
                ),
                onTap: () {
                  ref
                      .read(subscriptionsProvider.notifier)
                      .toggleActive(subscriptionId, !subscription.isActive);
                },
              ),
              PopupMenuItem(
                child: const Text('Delete Subscription'),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Delete Subscription?'),
                      content: Text(
                        'This will remove ${subscription.serviceName} and all its payment records.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true && context.mounted) {
                    ref
                        .read(subscriptionsProvider.notifier)
                        .deleteSubscription(subscriptionId);
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Service icon + name
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.categoryColor(
                    subscription.serviceCategory,
                  ).withValues(alpha: 0.15),
                  child: Text(
                    subscription.serviceName[0].toUpperCase(),
                    style: TextStyle(
                      color: AppColors.categoryColor(
                        subscription.serviceCategory,
                      ),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      subscription.serviceName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: subscription.isActive
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        subscription.isActive ? 'Active' : 'Cancelled',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: subscription.isActive
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subscription.serviceCategory != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subscription.serviceCategory!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Stats cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _DetailStatCard(
                  label: 'Monthly Cost',
                  value: CurrencyUtils.format(
                    monthlyCost,
                    subscription.currency,
                  ),
                  icon: Icons.calendar_month,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                _DetailStatCard(
                  label: 'Billing',
                  value: subscription.billingCycle.capitalize,
                  icon: Icons.repeat,
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                totalAsync.when(
                  data: (total) => _DetailStatCard(
                    label: 'Total Paid',
                    value: CurrencyUtils.format(total, subscription.currency),
                    icon: Icons.account_balance_wallet,
                    color: AppColors.entertainment,
                  ),
                  loading: () => const _DetailStatCard(
                    label: 'Total Paid',
                    value: '...',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.entertainment,
                  ),
                  error: (_, __) => const _DetailStatCard(
                    label: 'Total Paid',
                    value: '-',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.entertainment,
                  ),
                ),
                const SizedBox(width: 12),
                _DetailStatCard(
                  label: 'Duration',
                  value: subscription.firstSeenDate.durationSince(),
                  icon: Icons.timer,
                  color: AppColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Payment history
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Payment History',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: paymentsAsync.when(
              data: (payments) => PaymentHistoryTable(payments: payments),
              loading: () => const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Error: $e'),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _DetailStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _DetailStatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
