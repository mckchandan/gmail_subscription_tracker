import 'package:flutter/material.dart';
import '../../../../database/app_database.dart';
import '../../../../core/extensions.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../theme/app_colors.dart';

class PaymentHistoryTable extends StatelessWidget {
  final List<Payment> payments;

  const PaymentHistoryTable({super.key, required this.payments});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (payments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No payment history available',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    // Detect price changes
    final priceChangeIndices = <int>{};
    for (int i = 1; i < payments.length; i++) {
      if ((payments[i].amount - payments[i - 1].amount).abs() > 0.01) {
        priceChangeIndices.add(i);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Date',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Expanded(flex: 3, child: SizedBox()),
            ],
          ),
        ),
        const Divider(height: 1),
        // Rows
        ...payments.asMap().entries.map((entry) {
          final i = entry.key;
          final payment = entry.value;
          final hasPriceChange = priceChangeIndices.contains(i);

          return Container(
            color: hasPriceChange
                ? AppColors.warning.withValues(alpha: 0.05)
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    payment.paymentDate.formatted,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (hasPriceChange) const PriceChangeBadge(),
                      const SizedBox(width: 4),
                      Text(
                        CurrencyUtils.format(payment.amount, payment.currency),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    payment.emailSubject ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class PriceChangeBadge extends StatelessWidget {
  const PriceChangeBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.trending_up, size: 12, color: AppColors.warning),
    );
  }
}
