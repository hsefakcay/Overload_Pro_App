import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'dart:async';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';

class ProfileDialogs {
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
              'Vücut Kitle İndeksi (BMI) : ${bmi.toStringAsFixed(1)}',
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
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat'),
            ),
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
}
