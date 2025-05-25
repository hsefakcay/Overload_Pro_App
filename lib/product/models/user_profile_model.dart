import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String id;
  final String name;
  final double height;
  final double targetWeight;
  final DateTime birthDate;
  final String? photoUrl;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.height,
    required this.targetWeight,
    required this.birthDate,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, name, height, targetWeight, birthDate, photoUrl];

  UserProfileModel copyWith({
    String? id,
    String? name,
    double? height,
    double? targetWeight,
    DateTime? birthDate,
    String? photoUrl,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      targetWeight: targetWeight ?? this.targetWeight,
      birthDate: birthDate ?? this.birthDate,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return UserProfileModel(
        id: '',
        name: '',
        height: 0.0,
        targetWeight: 0.0,
        birthDate: DateTime.now(),
      );
    }
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      targetWeight: (json['targetWeight'] as num?)?.toDouble() ?? 0.0,
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate'].toString()) : DateTime.now(),
      photoUrl: json['photoUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'targetWeight': targetWeight,
      'birthDate': birthDate.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }
}
