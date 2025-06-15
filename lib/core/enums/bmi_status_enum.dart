import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';

/// Represents the different BMI (Body Mass Index) status categories.
enum BMIStatus {
  /// BMI less than 18.5
  underweight,

  /// BMI between 18.5 and 24.9
  normal,

  /// BMI between 25 and 29.9
  overweight,

  /// BMI 30 or greater
  obese;

  /// Returns the localized name for this BMI status.
  String getLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case BMIStatus.underweight:
        return l10n.bmiUnderweight;
      case BMIStatus.normal:
        return l10n.bmiNormal;
      case BMIStatus.overweight:
        return l10n.bmiOverweight;
      case BMIStatus.obese:
        return l10n.bmiObese;
    }
  }

  /// Returns the color associated with this BMI status.
  Color getColor() {
    switch (this) {
      case BMIStatus.underweight:
      case BMIStatus.overweight:
        return Colors.orange;
      case BMIStatus.normal:
        return Colors.green;
      case BMIStatus.obese:
        return Colors.red;
    }
  }

  /// Calculates the BMI status based on the given BMI value.
  static BMIStatus fromBMI(double bmi) {
    if (bmi < 18.5) return BMIStatus.underweight;
    if (bmi < 25) return BMIStatus.normal;
    if (bmi < 30) return BMIStatus.overweight;
    return BMIStatus.obese;
  }
}
