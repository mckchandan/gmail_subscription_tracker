import 'package:flutter/material.dart';
import '../../../../database/app_database.dart';
import '../../../../core/extensions.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../theme/app_colors.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final double? totalSpent;
  final VoidCallback? onTap;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    this.totalSpent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final monthlyCost = subscription.typicalAmount.toMonthly(
      subscription.billingCycle,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Service icon
              CircleAvatar(
                radius: 24,
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
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Service info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            subscription.serviceName,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusBadge(isActive: subscription.isActive),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (subscription.serviceCategory != null) ...[
                          _CategoryTag(category: subscription.serviceCategory!),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          subscription.billingCycle.capitalize,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    if (totalSpent != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Total: ${CurrencyUtils.format(totalSpent!, subscription.currency)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Monthly cost
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyUtils.format(monthlyCost, subscription.currency),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/month',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;
  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? 'Active' : 'Cancelled',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.success : AppColors.error,
        ),
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  final String category;
  const _CategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.categoryColor(category).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 10,
          color: AppColors.categoryColor(category),
        ),
      ),
    );
  }
}
