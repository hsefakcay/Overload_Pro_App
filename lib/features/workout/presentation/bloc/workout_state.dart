import 'package:equatable/equatable.dart';
import 'package:overload_pro_app/product/models/set_model.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState {}

class WorkoutLoading extends WorkoutState {}

class WorkoutLoaded extends WorkoutState {
  const WorkoutLoaded(this.workoutSets);
  final List<SetModel> workoutSets;

  @override
  List<Object?> get props => [workoutSets];
}

class WorkoutError extends WorkoutState {
  const WorkoutError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
