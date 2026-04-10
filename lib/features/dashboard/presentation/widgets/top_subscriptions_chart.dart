import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../database/app_database.dart';
import '../../../../core/extensions.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../theme/app_colors.dart';

class TopSubscriptionsChart extends StatelessWidget {
  final List<Subscription> topSubscriptions;
  final String currency;

  const TopSubscriptionsChart({
    super.key,
    required this.topSubscriptions,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (topSubscriptions.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxVal = topSubscriptions
        .map((s) => s.typicalAmount.toMonthly(s.billingCycle))
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top ${topSubscriptions.length} Most Expensive',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxVal * 1.2,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final sub = topSubscriptions[group.x.toInt()];
                        return BarTooltipItem(
                          '${sub.serviceName}\n${CurrencyUtils.format(rod.toY, currency)}/mo',
                          TextStyle(
                            color: theme.colorScheme.onInverseSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx >= topSubscriptions.length) {
                            return const SizedBox.shrink();
                          }
                          final name = topSubscriptions[idx].serviceName;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              name.length > 8
                                  ? '${name.substring(0, 7)}…'
                                  : name,
                              style: theme.textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: topSubscriptions.asMap().entries.map((e) {
                    final monthly = e.value.typicalAmount.toMonthly(
                      e.value.billingCycle,
                    );
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                          toY: monthly,
                          color: AppColors.categoryColor(
                            e.value.serviceCategory,
                          ),
                          width: 28,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
