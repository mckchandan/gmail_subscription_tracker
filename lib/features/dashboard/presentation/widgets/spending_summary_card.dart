import 'package:flutter/material.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../theme/app_colors.dart';

class SpendingSummaryCard extends StatelessWidget {
  final double totalMonthly;
  final double totalAllTime;
  final int activeCount;
  final String currency;

  const SpendingSummaryCard({
    super.key,
    required this.totalMonthly,
    required this.totalAllTime,
    required this.activeCount,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Monthly Spend',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyUtils.format(totalMonthly, currency),
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MiniStat(
                    label: 'All-Time Spend',
                    value: CurrencyUtils.formatCompact(totalAllTime, currency),
                    icon: Icons.account_balance_wallet,
                  ),
                ),
                Container(width: 1, height: 40, color: theme.dividerColor),
                Expanded(
                  child: _MiniStat(
                    label: 'Active',
                    value: '$activeCount subscriptions',
                    icon: Icons.subscriptions,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MiniStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
