import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double get lowValue => 8;
  double get mediumValue => 16;
  double get highValue => 24;
  double get veryHighValue => height * 0.1;

  double get horizontalSpace => width * 0.04;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;

  bool get isKeyboardOpen => mediaQuery.viewInsets.bottom > 0;
  double get keyboardPadding => mediaQuery.viewInsets.bottom;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);
  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);
  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);

  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: lowValue);
  EdgeInsets get horizontalPaddingMedium => EdgeInsets.symmetric(horizontal: mediumValue);
  EdgeInsets get horizontalPaddingHigh => EdgeInsets.symmetric(horizontal: highValue);

  EdgeInsets get verticalPaddingLow => EdgeInsets.symmetric(vertical: lowValue);
  EdgeInsets get verticalPaddingMedium => EdgeInsets.symmetric(vertical: mediumValue);
  EdgeInsets get verticalPaddingHigh => EdgeInsets.symmetric(vertical: highValue);
}

extension ResponsiveText on BuildContext {
  double get smallText => width * 0.035;
  double get mediumText => width * 0.04;
  double get largeText => width * 0.05;
  double get veryLargeText => width * 0.06;

  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: smallText);
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!.copyWith(fontSize: mediumText);
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!.copyWith(fontSize: largeText);
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!.copyWith(fontSize: mediumText);
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!.copyWith(fontSize: largeText);
  TextStyle get titleLarge =>
      Theme.of(this).textTheme.titleLarge!.copyWith(fontSize: veryLargeText);
  TextStyle get headlineSmall =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(fontSize: largeText);
}
