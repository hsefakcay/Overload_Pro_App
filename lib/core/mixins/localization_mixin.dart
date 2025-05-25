import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/generated/l10n/app_localizations.dart';

mixin LocalizationMixin<T extends StatefulWidget> on State<T> {
  AppLocalizations get l10n => AppLocalizations.of(context)!;
}
