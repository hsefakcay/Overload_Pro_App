import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (records.isEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: isDark ? const Color(0xFF23272F) : null,
        child: Padding(
          padding: context.paddingMedium,
          child: Center(
            child: Text(
              l10n.noWeightRecords,
              style: context.bodyMedium,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? const Color(0xFF23272F) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern başlık ve gradient arka plan
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      colors: [Color(0xFF23272F), Color(0xFF2C313A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                const Icon(Icons.show_chart, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  l10n.weightHistory,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: context.paddingMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Motivasyon/Başarı Mesajı
                if (records.isNotEmpty) _buildMotivationMessage(context, l10n),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.green.withOpacity(0.18) : Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.green.withOpacity(0.5) : Colors.green.withOpacity(0.3),
                    ),
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
                        '${l10n.targetWeight}: ${profile.targetWeight.toStringAsFixed(1)} ${l10n.kg}',
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
                    _createLineChartData(context, isDark),
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
                    final weightChange =
                        previousWeight != null ? record.weight - previousWeight : 0.0;
                    final isPositive = weightChange > 0;
                    final isNegative = weightChange < 0;

                    // En yüksek ve en düşük kilo için rozet
                    final maxWeight = records.map((e) => e.weight).reduce((a, b) => a > b ? a : b);
                    final minWeight = records.map((e) => e.weight).reduce((a, b) => a < b ? a : b);
                    final isMax = record.weight == maxWeight;
                    final isMin = record.weight == minWeight;

                    // En büyük artış ve azalış için rozet
                    double maxLoss = 0;
                    double maxGain = 0;
                    var maxLossIndex = -1;
                    var maxGainIndex = -1;
                    for (var i = 1; i < records.length; i++) {
                      final diff = records[i - 1].weight - records[i].weight;
                      if (diff > maxLoss) {
                        maxLoss = diff;
                        maxLossIndex = i;
                      }
                      final gain = records[i].weight - records[i - 1].weight;
                      if (gain > maxGain) {
                        maxGain = gain;
                        maxGainIndex = i;
                      }
                    }
                    final isMaxLoss = index == maxLossIndex;
                    final isMaxGain = index == maxGainIndex;

                    // Yüzde değişim
                    double? percentChange;
                    if (previousWeight != null && previousWeight != 0) {
                      percentChange = ((record.weight - previousWeight) / previousWeight) * 100;
                    }

                    return ListTile(
                      leading: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.monitor_weight,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          if (isMax)
                            Tooltip(
                              message: l10n.maxWeight,
                              child: const Icon(Icons.emoji_events, color: Colors.amber, size: 18),
                            ),
                          if (isMin)
                            Tooltip(
                              message: l10n.minWeight ?? 'Min',
                              child: const Icon(Icons.star, color: Colors.blue, size: 18),
                            ),
                          if (isMaxLoss)
                            Tooltip(
                              message: l10n.biggestLoss ?? 'Biggest Loss',
                              child: const Icon(Icons.trending_down, color: Colors.green, size: 18),
                            ),
                          if (isMaxGain)
                            Tooltip(
                              message: l10n.biggestGain ?? 'Biggest Gain',
                              child: const Icon(Icons.trending_up, color: Colors.red, size: 18),
                            ),
                        ],
                      ),
                      title: Text(
                        '${record.weight.toStringAsFixed(1)} ${l10n.kg}',
                        style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(record.date, context),
                            style: context.bodySmall,
                          ),
                          if (percentChange != null)
                            Text(
                              '${percentChange > 0 ? '+' : ''}${percentChange.toStringAsFixed(1)}%',
                              style: context.bodySmall.copyWith(
                                color: percentChange > 0 ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
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
                                    '${weightChange.abs().toStringAsFixed(1)} ${l10n.kg}',
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
        ],
      ),
    );
  }

  Widget _buildMotivationMessage(BuildContext context, AppLocalizations l10n) {
    final latestWeight = records.isNotEmpty ? records.first.weight : 0.0;
    final target = profile.targetWeight;
    final diff = (latestWeight - target).abs();
    final reached = latestWeight == target;
    final lost = latestWeight > target;
    final left = latestWeight < target;
    if (reached) {
      return Text(
        l10n.targetReached,
        style: context.titleSmall.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (left) {
      return Text(
        l10n.kgToTarget(diff.toStringAsFixed(1)),
        style: context.bodyMedium.copyWith(
          color: Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      return Text(
        l10n.belowTarget(diff.toStringAsFixed(1)),
        style: context.bodyMedium.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  LineChartData _createLineChartData(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
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
            color: isDark ? Colors.white12 : Theme.of(context).dividerColor,
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
                  style: context.bodySmall.copyWith(color: isDark ? Colors.white70 : null),
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
                style: context.bodySmall.copyWith(color: isDark ? Colors.white70 : null),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: isDark ? Colors.white12 : Theme.of(context).dividerColor),
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
          color: Colors.orangeAccent,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            getDotPainter: (spot, percent, barData, index) {
              final isLast = index == spots.length - 1;
              return FlDotCirclePainter(
                radius: isLast ? 6 : 4,
                color: isLast ? Colors.amber : Colors.orangeAccent,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.orangeAccent.withOpacity(0.12),
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
                '${spot.y.toStringAsFixed(1)} ${l10n.kg}',
                TextStyle(
                  color: isTarget ? Colors.lightGreenAccent : Colors.orangeAccent,
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
            color: Colors.lightGreenAccent,
            strokeWidth: 3,
            dashArray: [10, 10],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    // Türkçe ve İngilizce için ay isimleri
    final locale = Localizations.localeOf(context).languageCode;
    final monthsTr = [
      'Oca',
      'Şub',
      'Mar',
      'Nis',
      'May',
      'Haz',
      'Tem',
      'Ağu',
      'Eyl',
      'Eki',
      'Kas',
      'Ara',
    ];
    final monthsEn = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final months = locale == 'tr' ? monthsTr : monthsEn;
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
