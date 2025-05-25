import 'package:equatable/equatable.dart';
import 'workout_exercise_model.dart';

//(Bir günde yapılan tüm hareketler)

class WorkoutDayModel extends Equatable {
  final String id;
  final String name;
  final List<WorkoutExerciseModel> exercises;
  final DateTime date;
  final String? notes;

  const WorkoutDayModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.date,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        exercises,
        date,
        notes,
      ];

  WorkoutDayModel copyWith({
    String? id,
    String? name,
    List<WorkoutExerciseModel>? exercises,
    DateTime? date,
    String? notes,
    e,
  }) {
    return WorkoutDayModel(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
      date: date ?? this.date,
      notes: notes ?? this.notes,
    );
  }

  factory WorkoutDayModel.fromJson(Map<String, dynamic> json) {
    return WorkoutDayModel(
      id: json['id'] as String,
      name: json['name'] as String,
      exercises: (json['exercises'] as List)
          .map((e) => WorkoutExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
