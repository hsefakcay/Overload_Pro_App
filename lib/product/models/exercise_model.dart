import 'package:flutter/foundation.dart';

@immutable
class ExerciseModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final String? muscleGroup;
  final String? equipment;
  final bool isCustom;

  const ExerciseModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.videoUrl,
    this.muscleGroup,
    this.equipment,
    this.isCustom = false,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('A null value cannot be used to construct ExerciseModel');
    }
    return ExerciseModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      videoUrl: json['videoUrl']?.toString(),
      muscleGroup: json['muscleGroup']?.toString(),
      equipment: json['equipment']?.toString(),
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'muscleGroup': muscleGroup,
      'equipment': equipment,
      'isCustom': isCustom,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExerciseModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
