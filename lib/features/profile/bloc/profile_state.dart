import 'package:equatable/equatable.dart';
import '../../../product/models/user_profile_model.dart';
import '../../../product/models/weight_record_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileModel profile;
  final List<WeightRecordModel> weightRecords;

  const ProfileLoaded({
    required this.profile,
    required this.weightRecords,
  });

  @override
  List<Object?> get props => [profile, weightRecords];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
