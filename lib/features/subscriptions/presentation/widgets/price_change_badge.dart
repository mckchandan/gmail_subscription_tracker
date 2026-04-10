import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class PriceChangeBadgeWidget extends StatelessWidget {
  final double oldPrice;
  final double newPrice;
  final String currency;

  const PriceChangeBadgeWidget({
    super.key,
    required this.oldPrice,
    required this.newPrice,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final increased = newPrice > oldPrice;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: increased
            ? AppColors.error.withValues(alpha: 0.1)
            : AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            increased ? Icons.arrow_upward : Icons.arrow_downward,
            size: 14,
            color: increased ? AppColors.error : AppColors.success,
          ),
          const SizedBox(width: 4),
          Text(
            'Price ${increased ? "increased" : "decreased"}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: increased ? AppColors.error : AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
