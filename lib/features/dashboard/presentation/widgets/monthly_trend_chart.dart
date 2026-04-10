import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_colors.dart';

class MonthlyTrendChart extends StatelessWidget {
  final Map<DateTime, double> monthlyData;
  final String currency;

  const MonthlyTrendChart({
    super.key,
    required this.monthlyData,
    this.currency = 'USD',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (monthlyData.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              'No spending data yet',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      );
    }

    final sortedEntries = monthlyData.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final spots = <FlSpot>[];
    for (int i = 0; i < sortedEntries.length; i++) {
      spots.add(FlSpot(i.toDouble(), sortedEntries[i].value));
    }

    final maxY = sortedEntries
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spending Trend',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (value) =>
                        FlLine(color: theme.dividerColor, strokeWidth: 1),
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
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= sortedEntries.length) {
                            return const SizedBox.shrink();
                          }
                          // Show every 2nd or 3rd label to avoid overlap
                          if (sortedEntries.length > 6 && idx % 2 != 0) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            DateFormat('MMM').format(sortedEntries[idx].key),
                            style: theme.textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: spots.length <= 12),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final idx = spot.x.toInt();
                          final date = sortedEntries[idx].key;
                          return LineTooltipItem(
                            '${DateFormat('MMM yyyy').format(date)}\n\$${spot.y.toStringAsFixed(2)}',
                            TextStyle(
                              color: theme.colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
