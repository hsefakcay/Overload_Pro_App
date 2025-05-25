// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get muscleGroupAll => 'All';

  @override
  String get muscleGroupChest => 'Chest';

  @override
  String get muscleGroupBack => 'Back';

  @override
  String get muscleGroupLegs => 'Legs';

  @override
  String get muscleGroupShoulders => 'Shoulders';

  @override
  String get muscleGroupArms => 'Arms';

  @override
  String get muscleGroupAbs => 'Abs';

  @override
  String get muscleGroupGlutes => 'Glutes';

  @override
  String get categorySelectHint => 'Select Category';

  @override
  String get categoryLabel => 'Category';

  @override
  String get appName => 'Weight Tracker';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get navHome => 'Workout';

  @override
  String get navHistory => 'History';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeTitle => 'Workouts';

  @override
  String get noWorkouts => 'No exercises added yet';

  @override
  String get kgFormat => 'kg';

  @override
  String get setFormat => 'set';

  @override
  String get repFormat => 'rep';

  @override
  String get addWorkout => 'Add New Exercise';

  @override
  String get exerciseName => 'Exercise Name';

  @override
  String get exerciseHint => 'Ex: Squat, Bench Press';

  @override
  String get weight => 'Weight';

  @override
  String get weightHint => 'Ex: 60.5';

  @override
  String get sets => 'Number of Sets';

  @override
  String get setsHint => 'Ex: 3';

  @override
  String get reps => 'Number of Reps';

  @override
  String get repsHint => 'Ex: 12';

  @override
  String get notes => 'Notes (Optional)';

  @override
  String get notesHint => 'Add your notes...';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get selectExercise => 'Select Exercise';

  @override
  String get selectExerciseFirst => 'Please select an exercise first';

  @override
  String get setType => 'Set Type';

  @override
  String get selectSetType => 'Select Set Type';

  @override
  String get historyTitle => 'Workout History';

  @override
  String get noHistory => 'No workout history found';

  @override
  String get profileTitle => 'Profile';

  @override
  String get statistics => 'Statistics';

  @override
  String get totalWorkouts => 'Total Workouts';

  @override
  String get mostUsedExercise => 'Most Used Exercise';

  @override
  String get maxWeight => 'Max Weight';

  @override
  String get requiredField => 'This field is required';

  @override
  String get enterValidNumber => 'Please enter a valid number';

  @override
  String get enterValidInteger => 'Please enter a valid integer';

  @override
  String get searchExercise => 'Search exercise...';

  @override
  String get noExercisesFound => 'No exercises found';

  @override
  String get required => 'This field is required';

  @override
  String get kg => 'kg';

  @override
  String get noCategoryWorkouts => 'No workouts found in this category';

  @override
  String noCategoryWorkoutsDetail(String category) {
    return 'You don\'t have any workouts in the $category category yet. Start by adding a new workout.';
  }

  @override
  String get noWorkoutsDetail =>
      'You don\'t have any workouts yet. Start by adding a new workout.';

  @override
  String get personalBest => 'Record';

  @override
  String totalSets(int count) {
    return 'Total: $count';
  }

  @override
  String get editPersonalInfo => 'Edit Personal Info';

  @override
  String get currentWeight => 'Current Weight';

  @override
  String get targetWeight => 'Target Weight';

  @override
  String get height => 'Height';

  @override
  String get personalInfo => 'Personal Info';
}
