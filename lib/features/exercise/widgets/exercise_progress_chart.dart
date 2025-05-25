import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:intl/intl.dart';

class ExerciseProgressChart extends StatefulWidget {
  const ExerciseProgressChart({
    required this.progressData,
    required this.exerciseName,
    super.key,
  });
  final List<SetModel> progressData;
  final String exerciseName;

  @override
  State<ExerciseProgressChart> createState() => _ExerciseProgressChartState();
}

class _ExerciseProgressChartState extends State<ExerciseProgressChart> with LocalizationMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.progressData.isEmpty) {
      return Center(
        child: Text(
          l10n.noWorkoutsDetail,
          style: context.bodyMedium,
        ),
      );
    }

    // Sort data by date
    final sortedData = List<SetModel>.from(widget.progressData)
      ..sort((a, b) => a.completedAt?.compareTo(b.completedAt ?? DateTime.now()) ?? 0);

    final maxY = sortedData.map((e) => e.weight).reduce((a, b) => a > b ? a : b);
    final minY = sortedData.map((e) => e.weight).reduce((a, b) => a < b ? a : b);
    final yMargin = (maxY - minY) * 0.2;

    // Adjust X-axis range for single data point
    final isSinglePoint = sortedData.length == 1;
    final effectiveMinX = isSinglePoint ? -0.5 : 0;
    final effectiveMaxX = isSinglePoint ? 0.5 : sortedData.length - 1.0;

    return Column(
      children: [
        Padding(
          padding: context.paddingLow,
          child: Text(
            '${widget.exerciseName} İlerleme Grafiği',
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Container(
          height: context.dynamicHeight(0.4),
          margin: context.paddingMedium,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(context.lowValue * 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: context.paddingMedium,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  horizontalInterval: 5,
                  verticalInterval: 100,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Theme.of(context).dividerColor.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: context.highValue,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < sortedData.length) {
                          final date = sortedData[value.toInt()].completedAt;
                          if (date != null) {
                            return Padding(
                              padding: EdgeInsets.only(top: context.lowValue),
                              child: Text(
                                DateFormat('dd/MM').format(date),
                                style: context.bodySmall,
                              ),
                            );
                          }
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (double value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: context.lowValue * 0.5,
                          ),
                          child: Text(
                            '${value.round()}',
                            style: context.bodySmall,
                          ),
                        );
                      },
                      reservedSize: context.highValue * 1.3,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                ),
                minX: effectiveMinX.toDouble(),
                maxX: effectiveMaxX,
                minY: minY - yMargin,
                maxY: maxY + yMargin,
                lineBarsData: [
                  LineChartBarData(
                    spots: sortedData.asMap().entries.map((entry) {
                      return FlSpot(
                        entry.key.toDouble(),
                        entry.value.weight,
                      );
                    }).toList(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary,
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: context.lowValue / 1.3,
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 2,
                          strokeColor: Theme.of(context).scaffoldBackgroundColor,
                        );
                      },
                      checkToShowDot: (spot, barData) => true,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          Theme.of(context).colorScheme.primary.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: context.lowValue,
                    tooltipPadding: context.paddingLow,
                    tooltipMargin: context.lowValue,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        final index = spot.x.toInt();
                        final setData = sortedData[index];
                        return LineTooltipItem(
                          '${setData.weight.toStringAsFixed(1)} kg\n'
                          '${setData.reps} tekrar\n'
                          '${setData.setType.displayName}',
                          context.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.onTertiary,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((spotIndex) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        FlDotData(
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: context.lowValue / 1.5,
                              color: Theme.of(context).colorScheme.primary,
                              strokeWidth: 1,
                            );
                          },
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: context.paddingMedium,
          child: Container(
            padding: context.paddingMedium,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(context.lowValue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'En Yüksek',
                      style: context.bodySmall.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '${maxY.toStringAsFixed(1)} kg',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: context.mediumValue * 2.5,
                  width: 1,
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                ),
                Column(
                  children: [
                    Text(
                      'En Düşük',
                      style: context.bodySmall.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '${minY.toStringAsFixed(1)} kg',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
