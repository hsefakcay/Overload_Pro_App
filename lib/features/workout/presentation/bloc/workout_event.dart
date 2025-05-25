import 'package:equatable/equatable.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadWorkouts extends WorkoutEvent {}


class AddWorkout extends WorkoutEvent {
  final SetModel workoutSet;

  const AddWorkout(this.workoutSet);

  @override
  List<Object?> get props => [workoutSet];
}

class UpdateWorkout extends WorkoutEvent {
  final SetModel workoutSet;

  const UpdateWorkout(this.workoutSet);

  @override
  List<Object?> get props => [workoutSet];
}

class DeleteWorkout extends WorkoutEvent {
  final String id;

  const DeleteWorkout(this.id);

  @override
  List<Object?> get props => [id];
}
