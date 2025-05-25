import 'package:equatable/equatable.dart';
import 'package:overload_pro_app/product/models/set_model.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkouts extends WorkoutEvent {}

class AddWorkout extends WorkoutEvent {
  const AddWorkout(this.workoutSet);
  final SetModel workoutSet;

  @override
  List<Object?> get props => [workoutSet];
}

class UpdateWorkout extends WorkoutEvent {
  const UpdateWorkout(this.workoutSet);
  final SetModel workoutSet;

  @override
  List<Object?> get props => [workoutSet];
}

class DeleteWorkout extends WorkoutEvent {
  const DeleteWorkout(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}
