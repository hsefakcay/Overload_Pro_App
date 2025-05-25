import 'package:equatable/equatable.dart';
import 'package:overload_pro_app/product/models/exercise_model.dart';

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

class SetModel extends Equatable {
  const SetModel({
    required this.id,
    required this.weight,
    required this.exercise,
    required this.reps,
    required this.setType,
    this.order,
    this.isCompleted = false,
    this.notes,
    this.completedAt,
  });

  factory SetModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const SetModel(
        id: '',
        weight: 0,
        reps: 0,
        setType: SetType.warmUp,
        exercise: ExerciseModel(
          id: '',
          name: 'Unknown Exercise',
        ),
      );
    }
    return SetModel(
      id: json['id']?.toString() ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      reps: json['reps'] as int? ?? 0,
      setType: SetType.values[json['setType'] as int? ?? 0],
      order: json['order'] as int?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      notes: json['notes']?.toString(),
      completedAt:
          json['completedAt'] != null ? DateTime.tryParse(json['completedAt'].toString()) : null,
      exercise: json['exercise'] != null
          ? ExerciseModel.fromJson(json['exercise'] as Map<String, dynamic>?)
          : const ExerciseModel(
              id: '',
              name: 'Unknown Exercise',
            ),
    );
  }
  final String id;
  final double weight;
  final ExerciseModel exercise;
  final int reps;
  final SetType setType;
  final int? order;
  final bool isCompleted;
  final String? notes;
  final DateTime? completedAt;

  @override
  List<Object?> get props =>
      [id, weight, reps, order, setType, isCompleted, notes, completedAt, exercise];

  SetModel copyWith({
    String? id,
    double? weight,
    int? reps,
    SetType? setType,
    ExerciseModel? exercise,
    int? order,
    bool? isCompleted,
    String? notes,
    DateTime? completedAt,
  }) {
    return SetModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      setType: setType ?? this.setType,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
      exercise: exercise ?? this.exercise,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'reps': reps,
      'setType': setType,
      'order': order,
      'isCompleted': isCompleted,
      'notes': notes,
      'completedAt': completedAt?.toIso8601String(),
      'exercise': exercise.toJson(),
    };
  }
}
