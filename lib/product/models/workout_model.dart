import 'package:equatable/equatable.dart';
import 'workout_exercise_model.dart';

enum SetType {
  warmUp,
  rir1_2,
  failure,
  dropSet,
}

extension SetTypeExtension on SetType {
  String get displayName {
    switch (this) {
      case SetType.warmUp:
        return 'Warm Up';
      case SetType.rir1_2:
        return 'RIR 1-2';
      case SetType.failure:
        return 'Failure';
      case SetType.dropSet:
        return 'Drop Set';
    }
  }
}

class WorkoutModel extends Equatable {
  final String id;
  final String name;
  final List<WorkoutExerciseModel> exercises;
  final DateTime date;
  final String? notes;
  final bool isCompleted;
  final Duration? duration;
  final SetType setType;

  const WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.date,
    this.notes,
    this.isCompleted = false,
    this.duration,
    required this.setType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        exercises,
        date,
        notes,
        isCompleted,
        duration,
        setType,
      ];

  WorkoutModel copyWith({
    String? id,
    String? name,
    List<WorkoutExerciseModel>? exercises,
    DateTime? date,
    String? notes,
    bool? isCompleted,
    Duration? duration,
    SetType? setType,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      duration: duration ?? this.duration,
      setType: setType ?? this.setType,
    );
  }

  factory WorkoutModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('A null value cannot be used to construct WorkoutModel');
    }
    return WorkoutModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      exercises: (json['exercises'] as List?)
              ?.map((e) => WorkoutExerciseModel.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
      notes: json['notes']?.toString(),
      isCompleted: json['isCompleted'] as bool? ?? false,
      duration: json['duration'] != null
          ? Duration(seconds: (json['duration'] as num?)?.toInt() ?? 0)
          : null,
      setType: SetType.values[json['setType'] as int? ?? 0],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'date': date.toIso8601String(),
      'notes': notes,
      'isCompleted': isCompleted,
      'duration': duration?.inSeconds,
      'setType': setType.index,
    };
  }
}
