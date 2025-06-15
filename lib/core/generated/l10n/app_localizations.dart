import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// Label for all muscle groups option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get muscleGroupAll;

  /// Label for chest muscle group
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get muscleGroupChest;

  /// Label for back muscle group
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get muscleGroupBack;

  /// Label for legs muscle group
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get muscleGroupLegs;

  /// Label for shoulders muscle group
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get muscleGroupShoulders;

  /// Label for arms muscle group
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get muscleGroupArms;

  /// Label for abs muscle group
  ///
  /// In en, this message translates to:
  /// **'Abs'**
  String get muscleGroupAbs;

  /// Label for glutes muscle group
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get muscleGroupGlutes;

  /// Hint text for category selection
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get categorySelectHint;

  /// Label for category field
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Weight Tracker'**
  String get appName;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Navigation label for home/workout screen
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get navHome;

  /// Navigation label for history screen
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// Navigation label for profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Title for the home screen
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get homeTitle;

  /// Message shown when no exercises are available
  ///
  /// In en, this message translates to:
  /// **'No exercises added yet'**
  String get noWorkouts;

  /// Weight unit format
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kgFormat;

  /// Set unit format
  ///
  /// In en, this message translates to:
  /// **'set'**
  String get setFormat;

  /// Repetition unit format
  ///
  /// In en, this message translates to:
  /// **'rep'**
  String get repFormat;

  /// Button text for adding a new exercise
  ///
  /// In en, this message translates to:
  /// **'Add New Exercise'**
  String get addWorkout;

  /// Label for exercise name input
  ///
  /// In en, this message translates to:
  /// **'Exercise Name'**
  String get exerciseName;

  /// Hint text for exercise name input
  ///
  /// In en, this message translates to:
  /// **'Ex: Squat, Bench Press'**
  String get exerciseHint;

  /// Label for weight input
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Hint text for weight input
  ///
  /// In en, this message translates to:
  /// **'Ex: 60.5'**
  String get weightHint;

  /// Label for sets input
  ///
  /// In en, this message translates to:
  /// **'Number of Sets'**
  String get sets;

  /// Hint text for sets input
  ///
  /// In en, this message translates to:
  /// **'Ex: 3'**
  String get setsHint;

  /// Label for reps input
  ///
  /// In en, this message translates to:
  /// **'Number of Reps'**
  String get reps;

  /// Hint text for reps input
  ///
  /// In en, this message translates to:
  /// **'Ex: 12'**
  String get repsHint;

  /// Label for notes input
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notes;

  /// Hint text for notes input
  ///
  /// In en, this message translates to:
  /// **'Add your notes...'**
  String get notesHint;

  /// Label for category selection
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Prompt for category selection
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// Prompt for exercise selection
  ///
  /// In en, this message translates to:
  /// **'Select Exercise'**
  String get selectExercise;

  /// Message shown when exercise needs to be selected
  ///
  /// In en, this message translates to:
  /// **'Please select an exercise first'**
  String get selectExerciseFirst;

  /// Label for set type selection
  ///
  /// In en, this message translates to:
  /// **'Set Type'**
  String get setType;

  /// Prompt for set type selection
  ///
  /// In en, this message translates to:
  /// **'Select Set Type'**
  String get selectSetType;

  /// Title for the history screen
  ///
  /// In en, this message translates to:
  /// **'Workout History'**
  String get historyTitle;

  /// Message shown when no workout history is available
  ///
  /// In en, this message translates to:
  /// **'No workout history found'**
  String get noHistory;

  /// Title for the profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// Label for statistics section
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Label for total workouts statistic
  ///
  /// In en, this message translates to:
  /// **'Total Workouts'**
  String get totalWorkouts;

  /// Label for most used exercise statistic
  ///
  /// In en, this message translates to:
  /// **'Most Used Exercise'**
  String get mostUsedExercise;

  /// Label for maximum weight statistic
  ///
  /// In en, this message translates to:
  /// **'Max Weight'**
  String get maxWeight;

  /// Validation message for required fields
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// Validation message for number input
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get enterValidNumber;

  /// Validation message for integer input
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid integer'**
  String get enterValidInteger;

  /// Hint text for exercise search
  ///
  /// In en, this message translates to:
  /// **'Search exercise...'**
  String get searchExercise;

  /// Message shown when no exercises are found
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get noExercisesFound;

  /// Generic required field message
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get required;

  /// Weight unit abbreviation
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// Message shown when no workouts are found in selected category
  ///
  /// In en, this message translates to:
  /// **'No workouts found in this category'**
  String get noCategoryWorkouts;

  /// Detailed message shown when no workouts are found in selected category
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any workouts in the {category} category yet. Start by adding a new workout.'**
  String noCategoryWorkoutsDetail(String category);

  /// Detailed message shown when no workouts are found
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any workouts yet. Start by adding a new workout.'**
  String get noWorkoutsDetail;

  /// Label for personal best record
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get personalBest;

  /// Label for total number of sets
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String totalSets(int count);

  /// Label for editing personal information
  ///
  /// In en, this message translates to:
  /// **'Edit Personal Info'**
  String get editPersonalInfo;

  /// Label for current weight
  ///
  /// In en, this message translates to:
  /// **'Current Weight'**
  String get currentWeight;

  /// Label for target weight
  ///
  /// In en, this message translates to:
  /// **'Target Weight'**
  String get targetWeight;

  /// Label for height
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Title for personal information section
  ///
  /// In en, this message translates to:
  /// **'Personal Info'**
  String get personalInfo;

  /// Label for weight tracking section
  ///
  /// In en, this message translates to:
  /// **'Weight Tracking'**
  String get weightTracking;

  /// Label for dark mode option
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Label for light mode option
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Label for privacy policy link
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Title for the last workout details section
  ///
  /// In en, this message translates to:
  /// **'Last Workout Details'**
  String get lastWorkoutDetails;

  /// Title for the exercise progress chart
  ///
  /// In en, this message translates to:
  /// **'{exerciseName} Progress Chart'**
  String progressChart(String exerciseName);

  /// Label for highest weight
  ///
  /// In en, this message translates to:
  /// **'Highest'**
  String get highest;

  /// Label for lowest weight
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get lowest;

  /// Label for Body Mass Index
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// BMI status for underweight
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiUnderweight;

  /// BMI status for normal weight
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiNormal;

  /// BMI status for overweight
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiOverweight;

  /// BMI status for obese
  ///
  /// In en, this message translates to:
  /// **'Obese'**
  String get bmiObese;

  /// Title for weight history section
  ///
  /// In en, this message translates to:
  /// **'Weight History'**
  String get weightHistory;

  /// Message shown when no weight records are available
  ///
  /// In en, this message translates to:
  /// **'No weight records found'**
  String get noWeightRecords;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
