import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/product/models/exercise_model.dart';

@immutable
class ExerciseRepository {
  final List<ExerciseModel> _exercises = [
    // Chest Exercises
    const ExerciseModel(
      id: '1',
      name: 'Bench Press',
      muscleGroup: 'muscleGroupChest',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '2',
      name: 'Incline Bench Press',
      muscleGroup: 'muscleGroupChest',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '3',
      name: 'Decline Bench Press',
      muscleGroup: 'muscleGroupChest',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '4',
      name: 'Dumbbell Fly',
      muscleGroup: 'muscleGroupChest',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '5',
      name: 'Cable Crossover',
      muscleGroup: 'muscleGroupChest',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Back Exercises
    const ExerciseModel(
      id: '6',
      name: 'Lat Pulldown',
      muscleGroup: 'muscleGroupBack',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '7',
      name: 'Barbell Row',
      muscleGroup: 'muscleGroupBack',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '8',
      name: 'Seated Cable Row',
      muscleGroup: 'muscleGroupBack',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '9',
      name: 'Pull-up',
      muscleGroup: 'muscleGroupBack',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '10',
      name: 'T-Bar Row',
      muscleGroup: 'muscleGroupBack',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Leg Exercises
    const ExerciseModel(
      id: '11',
      name: 'Squat',
      muscleGroup: 'muscleGroupLegs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '12',
      name: 'Leg Press',
      muscleGroup: 'muscleGroupLegs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '13',
      name: 'Romanian Deadlift',
      muscleGroup: 'muscleGroupLegs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '14',
      name: 'Leg Extension',
      muscleGroup: 'muscleGroupLegs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '15',
      name: 'Leg Curl',
      muscleGroup: 'muscleGroupLegs',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Shoulder Exercises
    const ExerciseModel(
      id: '16',
      name: 'Military Press',
      muscleGroup: 'muscleGroupShoulders',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '17',
      name: 'Lateral Raise',
      muscleGroup: 'muscleGroupShoulders',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '18',
      name: 'Front Raise',
      muscleGroup: 'muscleGroupShoulders',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '19',
      name: 'Face Pull',
      muscleGroup: 'muscleGroupShoulders',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '20',
      name: 'Reverse Fly',
      muscleGroup: 'muscleGroupShoulders',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Arm Exercises
    const ExerciseModel(
      id: '21',
      name: 'Barbell Curl',
      muscleGroup: 'muscleGroupArms',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '22',
      name: 'Tricep Pushdown',
      muscleGroup: 'muscleGroupArms',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '23',
      name: 'Hammer Curl',
      muscleGroup: 'muscleGroupArms',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '24',
      name: 'Skull Crusher',
      muscleGroup: 'muscleGroupArms',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '25',
      name: 'Preacher Curl',
      muscleGroup: 'muscleGroupArms',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Abdominal Exercises
    const ExerciseModel(
      id: '26',
      name: 'Crunch',
      muscleGroup: 'muscleGroupAbs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '27',
      name: 'Plank',
      muscleGroup: 'muscleGroupAbs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '28',
      name: 'Russian Twist',
      muscleGroup: 'muscleGroupAbs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '29',
      name: 'Leg Raise',
      muscleGroup: 'muscleGroupAbs',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '30',
      name: 'Cable Woodchopper',
      muscleGroup: 'muscleGroupAbs',
      imageUrl: 'assets/images/squat.JPG',
    ),

    // Glute Exercises
    const ExerciseModel(
      id: '31',
      name: 'Hip Thrust',
      muscleGroup: 'muscleGroupGlutes',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '32',
      name: 'Glute Bridge',
      muscleGroup: 'muscleGroupGlutes',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '33',
      name: 'Bulgarian Split Squat',
      muscleGroup: 'muscleGroupGlutes',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '34',
      name: 'Cable Kickback',
      muscleGroup: 'muscleGroupGlutes',
      imageUrl: 'assets/images/squat.JPG',
    ),
    const ExerciseModel(
      id: '35',
      name: 'Side Leg Raise',
      muscleGroup: 'muscleGroupGlutes',
      imageUrl: 'assets/images/squat.JPG',
    ),
  ];

  List<ExerciseModel> getAllExercises() {
    return _exercises;
  }

  List<String?> getAllMuscleGroups(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final muscleGroups = _exercises.map((e) => e.muscleGroup).toSet().toList()..sort();

    return muscleGroups.map((group) {
      switch (group) {
        case 'muscleGroupChest':
          return localizations.muscleGroupChest;
        case 'muscleGroupBack':
          return localizations.muscleGroupBack;
        case 'muscleGroupLegs':
          return localizations.muscleGroupLegs;
        case 'muscleGroupShoulders':
          return localizations.muscleGroupShoulders;
        case 'muscleGroupArms':
          return localizations.muscleGroupArms;
        case 'muscleGroupAbs':
          return localizations.muscleGroupAbs;
        case 'muscleGroupGlutes':
          return localizations.muscleGroupGlutes;
        default:
          return group;
      }
    }).toList();
  }

  String getMuscleGroupTranslation(BuildContext context, String muscleGroup) {
    final localizations = AppLocalizations.of(context)!;
    switch (muscleGroup) {
      case 'muscleGroupChest':
        return localizations.muscleGroupChest;
      case 'muscleGroupBack':
        return localizations.muscleGroupBack;
      case 'muscleGroupLegs':
        return localizations.muscleGroupLegs;
      case 'muscleGroupShoulders':
        return localizations.muscleGroupShoulders;
      case 'muscleGroupArms':
        return localizations.muscleGroupArms;
      case 'muscleGroupAbs':
        return localizations.muscleGroupAbs;
      case 'muscleGroupGlutes':
        return localizations.muscleGroupGlutes;
      default:
        return muscleGroup;
    }
  }

  String? getMuscleGroupIdentifier(BuildContext context, String translatedName) {
    final localizations = AppLocalizations.of(context)!;
    if (translatedName == localizations.muscleGroupChest) return 'muscleGroupChest';
    if (translatedName == localizations.muscleGroupBack) return 'muscleGroupBack';
    if (translatedName == localizations.muscleGroupLegs) return 'muscleGroupLegs';
    if (translatedName == localizations.muscleGroupShoulders) return 'muscleGroupShoulders';
    if (translatedName == localizations.muscleGroupArms) return 'muscleGroupArms';
    if (translatedName == localizations.muscleGroupAbs) return 'muscleGroupAbs';
    if (translatedName == localizations.muscleGroupGlutes) return 'muscleGroupGlutes';
    return null;
  }

  List<ExerciseModel> getExercisesByMuscleGroup(String muscleGroup, [BuildContext? context]) {
    // If context is provided, try to get the identifier from the translated name
    String? identifier;
    if (context != null) {
      identifier = getMuscleGroupIdentifier(context, muscleGroup);
    }

    // If identifier is not found, use the original muscleGroup value
    // This handles both translated names and direct identifier usage
    return _exercises
        .where((exercise) => exercise.muscleGroup == (identifier ?? muscleGroup))
        .toList();
  }

  ExerciseModel? getExerciseById(String id) {
    try {
      return _exercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }
}
