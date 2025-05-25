import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';

class WeightHistoryCard extends StatelessWidget {
  const WeightHistoryCard({
    required this.records,
    required this.profile,
    required this.onDeleteRecord,
    super.key,
  });

  final List<WeightRecordModel> records;
  final UserProfileModel profile;
  final Function(String) onDeleteRecord;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: context.paddingMedium,
          child: Center(
            child: Text(
              'Henüz kilo kaydı bulunmuyor',
              style: context.bodyMedium,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: context.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kilo Geçmişi',
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.track_changes,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hedef Kilo: ${profile.targetWeight.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                _createLineChartData(context),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                final previousWeight =
                    index < records.length - 1 ? records[index + 1].weight : null;
                final weightChange = previousWeight != null ? record.weight - previousWeight : 0.0;
                final isPositive = weightChange > 0;
                final isNegative = weightChange < 0;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Icon(
                      Icons.monitor_weight,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    '${record.weight.toStringAsFixed(1)} kg',
                    style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${record.date.day}/${record.date.month}/${record.date.year}',
                    style: context.bodySmall,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (weightChange != 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isPositive
                                ? Colors.red.withOpacity(0.1)
                                : isNegative
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                size: 16,
                                color: isPositive ? Colors.red : Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${weightChange.abs().toStringAsFixed(1)} kg',
                                style: context.bodySmall.copyWith(
                                  color: isPositive ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => onDeleteRecord(record.id),
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _createLineChartData(BuildContext context) {
    final spots = <FlSpot>[];
    final targetSpots = <FlSpot>[];
    final targetWeight = profile.targetWeight;

    // Sort records by date in ascending order for the chart
    final sortedRecords = List<WeightRecordModel>.from(records)
      ..sort((a, b) => a.date.compareTo(b.date));

    for (var i = 0; i < sortedRecords.length; i++) {
      spots.add(FlSpot(i.toDouble(), sortedRecords[i].weight));
      targetSpots.add(FlSpot(i.toDouble(), targetWeight));
    }

    return LineChartData(
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 5,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).dividerColor,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= sortedRecords.length) return const Text('');
              final date = sortedRecords[value.toInt()].date;
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${date.day}/${date.month}',
                  style: context.bodySmall,
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 5,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: context.bodySmall,
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      minX: 0,
      maxX: (spots.length - 1).toDouble(),
      minY: (targetWeight - 10).clamp(0, double.infinity),
      maxY: (targetWeight + 10).clamp(0, double.infinity),
      lineBarsData: [
        // Target weight line
        LineChartBarData(
          spots: targetSpots,
          color: Colors.green,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(),
          dashArray: [5, 5],
        ),
        // Actual weight line
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: Theme.of(context).primaryColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Theme.of(context).primaryColor,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          tooltipPadding: const EdgeInsets.all(8),
          tooltipMargin: 8,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final isTarget = spot.barIndex == 0;
              return LineTooltipItem(
                isTarget
                    ? 'Hedef: ${spot.y.toStringAsFixed(1)} kg'
                    : '${spot.y.toStringAsFixed(1)} kg',
                TextStyle(
                  color: isTarget ? Colors.green : Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: targetWeight,
            color: Colors.green,
            dashArray: [5, 5],
          ),
        ],
      ),
    );
  }
}
