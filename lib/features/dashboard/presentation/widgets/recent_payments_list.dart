import 'package:flutter/material.dart';
import '../../../../database/app_database.dart';
import '../../../../core/extensions.dart';
import '../../../../core/utils/currency_utils.dart';

class RecentPaymentsList extends StatelessWidget {
  final List<Payment> payments;
  final Map<int, Subscription>? subscriptionMap;

  const RecentPaymentsList({
    super.key,
    required this.payments,
    this.subscriptionMap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (payments.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              'No payments detected yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Payments',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...payments.map((payment) {
              final sub = subscriptionMap?[payment.subscriptionId];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        (sub?.serviceName ?? '?')[0].toUpperCase(),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sub?.serviceName ?? 'Unknown Service',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            payment.paymentDate.formatted,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      CurrencyUtils.format(payment.amount, payment.currency),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
