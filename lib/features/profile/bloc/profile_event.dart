import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final double height;
  final double targetWeight;

  const UpdateProfile({
    required this.name,
    required this.height,
    required this.targetWeight,
  });

  @override
  List<Object?> get props => [name, height, targetWeight];
}

class AddWeightRecord extends ProfileEvent {
  final double weight;
  final String? note;

  const AddWeightRecord({
    required this.weight,
    this.note,
  });

  @override
  List<Object?> get props => [weight, note];
}

class DeleteWeightRecord extends ProfileEvent {
  final String recordId;

  const DeleteWeightRecord(this.recordId);

  @override
  List<Object?> get props => [recordId];
}
