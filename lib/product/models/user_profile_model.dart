import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  const UserProfileModel({
    required this.id,
    required this.name,
    required this.height,
    required this.targetWeight,
    required this.weight,
    required this.birthDate,
    this.photoUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserProfileModel(
        id: '',
        name: '',
        height: 0,
        targetWeight: 0,
        weight: 0,
        birthDate: DateTime.now(),
      );
    }
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      targetWeight: (json['targetWeight'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate'].toString()) : DateTime.now(),
      photoUrl: json['photoUrl']?.toString(),
    );
  }
  final String id;
  final String name;
  final double height;
  final double targetWeight;
  final double weight;
  final DateTime birthDate;
  final String? photoUrl;

  @override
  List<Object?> get props => [id, name, height, targetWeight, weight, birthDate, photoUrl];

  UserProfileModel copyWith({
    String? id,
    String? name,
    double? height,
    double? targetWeight,
    double? weight,
    DateTime? birthDate,
    String? photoUrl,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      targetWeight: targetWeight ?? this.targetWeight,
      weight: weight ?? this.weight,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'targetWeight': targetWeight,
      'weight': weight,
      'birthDate': birthDate.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }
}
