import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/enums/bmi_status_enum.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';

class WeightSummaryCard extends StatelessWidget {
  const WeightSummaryCard({
    required this.profile,
    required this.weightRecords,
    required this.onBMITap,
    super.key,
  });
  final UserProfileModel profile;
  final List<WeightRecordModel> weightRecords;

  final Function(double) onBMITap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final latestWeight = weightRecords.isNotEmpty ? weightRecords.first.weight : 0.0;
    final bmi = profile.height > 0
        ? (latestWeight / ((profile.height / 100) * (profile.height / 100)))
        : 0.0;
    final bmiStatus = BMIStatus.fromBMI(bmi);
    final weightChange = weightRecords.length >= 2 ? latestWeight - weightRecords[1].weight : 0.0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: context.paddingMedium,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: _buildWeightStat(
                    context,
                    l10n.currentWeight,
                    '${weightRecords.isNotEmpty ? weightRecords.first.weight : 0.0} ${l10n.kg}',
                    Icons.monitor_weight,
                    weightChange,
                    l10n,
                  ),
                ),
                GestureDetector(
                  child: _buildWeightStat(
                    context,
                    l10n.targetWeight,
                    '${profile.targetWeight} ${l10n.kg}',
                    Icons.track_changes,
                    null,
                    l10n,
                  ),
                ),
                GestureDetector(
                  child: _buildWeightStat(
                    context,
                    l10n.height,
                    '${profile.height} cm',
                    Icons.height,
                    null,
                    l10n,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => onBMITap(bmi),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: bmiStatus.getColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      color: bmiStatus.getColor(),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${l10n.bmi}: ${bmi.toStringAsFixed(1)}',
                      style: context.titleSmall.copyWith(
                        color: bmiStatus.getColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bmiStatus.getLocalizedName(l10n),
                      style: context.bodySmall.copyWith(
                        color: bmiStatus.getColor(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    double? change,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: context.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (change != null) ...[
          const SizedBox(height: 4),
          _buildWeightChange(context, change, l10n),
        ],
      ],
    );
  }

  Widget _buildWeightChange(BuildContext context, double change, AppLocalizations l10n) {
    final isPositive = change > 0;
    final color = isPositive ? Colors.red : Colors.green;
    final icon = isPositive ? Icons.arrow_upward : Icons.arrow_downward;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        Text(
          '${change.abs().toStringAsFixed(1)} ${l10n.kg}',
          style: context.bodySmall.copyWith(color: color),
        ),
      ],
    );
  }
}
