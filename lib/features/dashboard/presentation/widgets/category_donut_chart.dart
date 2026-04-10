import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../../../core/utils/currency_utils.dart';

class CategoryDonutChart extends StatelessWidget {
  final Map<String, double> categorySpend;
  final String currency;

  const CategoryDonutChart({
    super.key,
    required this.categorySpend,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (categorySpend.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              'No category data yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    final total = categorySpend.values.fold(0.0, (a, b) => a + b);
    final entries = categorySpend.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending by Category',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: entries.map((e) {
                          final pct = (e.value / total * 100);
                          return PieChartSectionData(
                            value: e.value,
                            title: pct >= 10
                                ? '${pct.toStringAsFixed(0)}%'
                                : '',
                            color: AppColors.categoryColor(e.key),
                            radius: 50,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.categoryColor(e.key),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${e.key} (${CurrencyUtils.formatCompact(e.value, currency)})',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
