import 'package:equatable/equatable.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  final List<SetModel> workoutSets;

  const WorkoutLoaded(this.workoutSets);

  @override
  List<Object?> get props => [workoutSets];
}

class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}
