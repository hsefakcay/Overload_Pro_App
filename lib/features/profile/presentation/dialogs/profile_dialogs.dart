import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'dart:async';
import 'package:weight_tracker_app/core/generated/l10n/app_localizations.dart';

class ProfileDialogs {
  static Future<void> showAddWeightDialog(
    BuildContext context, {
    required Function(double weight, String? note) onSave,
  }) {
    final weightController = TextEditingController();
    final noteController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.lowValue * 2)),
        title: Text(
          'Yeni Kilo Kaydı',
          style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: 'Kilo (kg)',
                hintText: 'Örn: 75.5',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.lowValue),
                ),
                prefixIcon: const Icon(Icons.monitor_weight),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: context.mediumValue),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: 'Not (Opsiyonel)',
                hintText: 'Örn: Sabah aç karnına',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.lowValue),
                ),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.lowValue),
              ),
            ),
            onPressed: () {
              final weight = double.tryParse(weightController.text);
              if (weight != null) {
                onSave(weight, noteController.text.isEmpty ? null : noteController.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  static Future<void> showWeightSettingDialog(
    BuildContext context, {
    required double currentWeight,
    required Function(double) onSave,
  }) {
    var weight = currentWeight;

    return showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.lowValue * 2),
          ),
          title: Text(
            'Kilo Ayarla',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircularButton(
                    context,
                    Icons.remove,
                    () => setState(() => weight = (weight - 0.1).clamp(30.0, 300.0)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: context.mediumValue),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.mediumValue,
                      vertical: context.lowValue,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(context.lowValue),
                    ),
                    child: Text(
                      '${weight.toStringAsFixed(1)} kg',
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _buildCircularButton(
                    context,
                    Icons.add,
                    () => setState(() => weight = (weight + 0.1).clamp(30.0, 300.0)),
                  ),
                ],
              ),
              SizedBox(height: context.mediumValue),
              TextField(
                controller: TextEditingController(text: weight.toStringAsFixed(1)),
                decoration: InputDecoration(
                  labelText: 'Kilo (kg)',
                  hintText: 'Örn: 75.5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.lowValue),
                  ),
                  prefixIcon: const Icon(Icons.monitor_weight),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  final newWeight = double.tryParse(value);
                  if (newWeight != null) {
                    setState(() => weight = newWeight.clamp(30.0, 300.0));
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.lowValue),
                ),
              ),
              onPressed: () {
                onSave(weight);
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showTargetWeightDialog(
    BuildContext context, {
    required double currentTargetWeight,
    required Function(double) onSave,
  }) {
    var targetWeight = currentTargetWeight;

    return showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Hedef Kilo Ayarla',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircularButton(
                    context,
                    Icons.remove,
                    () => setState(() => targetWeight = (targetWeight - 0.1).clamp(30.0, 300.0)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${targetWeight.toStringAsFixed(1)} kg',
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _buildCircularButton(
                    context,
                    Icons.add,
                    () => setState(() => targetWeight = (targetWeight + 0.1).clamp(30.0, 300.0)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: targetWeight.toStringAsFixed(1)),
                decoration: InputDecoration(
                  labelText: 'Hedef Kilo (kg)',
                  hintText: 'Örn: 75.5',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.track_changes),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  final newWeight = double.tryParse(value);
                  if (newWeight != null) {
                    setState(() => targetWeight = newWeight.clamp(30.0, 300.0));
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                onSave(targetWeight);
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showHeightSettingDialog(
    BuildContext context, {
    required double currentHeight,
    required Function(double) onSave,
  }) {
    var height = currentHeight;

    return showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Boy Ayarla',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircularButton(
                    context,
                    Icons.remove,
                    () => setState(() => height = (height - 1).clamp(100.0, 250.0)),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${height.toStringAsFixed(0)} cm',
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  _buildCircularButton(
                    context,
                    Icons.add,
                    () => setState(() => height = (height + 1).clamp(100.0, 250.0)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: height.toStringAsFixed(0)),
                decoration: InputDecoration(
                  labelText: 'Boy (cm)',
                  hintText: 'Örn: 175',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final newHeight = double.tryParse(value);
                  if (newHeight != null) {
                    setState(() => height = newHeight.clamp(100.0, 250.0));
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                onSave(height);
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showBMIInfoDialog(BuildContext context, double bmi) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'BMI Bilgisi',
          style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vücut Kitle İndeksi (BMI): ${bmi.toStringAsFixed(1)}',
              style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBMIRangeInfo(context, "18.5'ten düşük", 'Zayıf', Colors.orange),
            _buildBMIRangeInfo(context, '18.5 - 24.9', 'Normal', Colors.green),
            _buildBMIRangeInfo(context, '25 - 29.9', 'Kilolu', Colors.orange),
            _buildBMIRangeInfo(context, '30 ve üzeri', 'Obez', Colors.red),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  static Widget _buildCircularButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(context.lowValue * 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(context.lowValue * 2),
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(context.lowValue),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: context.mediumValue,
          ),
        ),
      ),
    );
  }

  static Widget _buildBMIRangeInfo(
    BuildContext context,
    String range,
    String status,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            range,
            style: context.bodyMedium,
          ),
          const Spacer(),
          Text(
            status,
            style: context.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Timer? _incrementTimer;

  static void _startAutoIncrement(VoidCallback increment) {
    _incrementTimer?.cancel();
    _incrementTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      increment();
    });
  }

  static void _stopAutoIncrement() {
    _incrementTimer?.cancel();
    _incrementTimer = null;
  }

  static Future<void> showPersonalInfoDialog(
    BuildContext context, {
    required double currentWeight,
    required double targetWeight,
    required double height,
    required Function(double, double, double) onSave,
  }) {
    var weight = currentWeight;
    var target = targetWeight;
    var heightValue = height;
    final l10n = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Kişisel Bilgiler',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoField(
                  context,
                  'Güncel Kilo',
                  weight,
                  (value) => setState(() => weight = value),
                  Icons.monitor_weight,
                ),
                const SizedBox(height: 16),
                _buildInfoField(
                  context,
                  'Hedef Kilo',
                  target,
                  (value) => setState(() => target = value),
                  Icons.track_changes,
                ),
                const SizedBox(height: 16),
                _buildInfoField(
                  context,
                  'Boy',
                  heightValue,
                  (value) => setState(() => heightValue = value),
                  Icons.height,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                onSave(weight, target, heightValue);
                Navigator.pop(context);
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfoField(
    BuildContext context,
    String label,
    double value,
    Function(double) onChanged,
    IconData icon,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.titleSmall.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: TextEditingController(text: value.toStringAsFixed(1)),
                decoration: InputDecoration(
                  hintText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixText: label == l10n.height ? 'cm' : 'kg',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (text) {
                  final newValue = double.tryParse(text);
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
