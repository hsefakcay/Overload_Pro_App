import 'package:equatable/equatable.dart';
import 'exercise_model.dart';
import 'set_model.dart';

//(Bir harekette yapılan tüm setler)

class WorkoutExerciseModel extends Equatable {
  final String id;
  final ExerciseModel exercise;
  final List<SetModel> sets;
  final String? notes;
  final int order;

  const WorkoutExerciseModel({
    required this.id,
    required this.exercise,
    required this.sets,
    this.notes,
    required this.order,
  });

  @override
  List<Object?> get props => [id, exercise, sets, notes, order];

  WorkoutExerciseModel copyWith({
    String? id,
    ExerciseModel? exercise,
    List<SetModel>? sets,
    String? notes,
    int? order,
  }) {
    return WorkoutExerciseModel(
      id: id ?? this.id,
      exercise: exercise ?? this.exercise,
      sets: sets ?? this.sets,
      notes: notes ?? this.notes,
      order: order ?? this.order,
    );
  }

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('A null value cannot be used to construct WorkoutExerciseModel');
    }
    return WorkoutExerciseModel(
      id: json['id']?.toString() ?? '',
      exercise: ExerciseModel.fromJson(json['exercise'] as Map<String, dynamic>?),
      sets: (json['sets'] as List?)
              ?.map((e) => SetModel.fromJson(e as Map<String, dynamic>?))
              .toList() ??
          [],
      notes: json['notes']?.toString(),
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise.toJson(),
      'sets': sets.map((e) => e.toJson()).toList(),
      'notes': notes,
      'order': order,
    };
  }
}
