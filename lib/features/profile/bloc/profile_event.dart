import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  const UpdateProfile({
    required this.name,
    required this.height,
    required this.targetWeight,
    required this.weight,
    this.photoUrl,
  });
  final String name;
  final double height;
  final double targetWeight;
  final double weight;
  final String? photoUrl;

  @override
  List<Object?> get props => [name, height, targetWeight, weight, photoUrl];
}

class AddWeightRecord extends ProfileEvent {
  const AddWeightRecord({
    required this.weight,
    this.note,
  });
  final double weight;
  final String? note;

  @override
  List<Object?> get props => [weight, note];
}

class DeleteWeightRecord extends ProfileEvent {
  const DeleteWeightRecord(this.recordId);
  final String recordId;

  @override
  List<Object?> get props => [recordId];
}
