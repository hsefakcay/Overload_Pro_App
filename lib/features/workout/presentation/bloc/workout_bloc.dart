import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/workout_repository.dart';
import 'workout_event.dart';
import 'workout_state.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutRepository _repository;

  WorkoutBloc(this._repository) : super(WorkoutInitial()) {
    on<LoadWorkouts>(_onLoadWorkouts);
    on<AddWorkout>(_onAddWorkout);
    on<UpdateWorkout>(_onUpdateWorkout);
    on<DeleteWorkout>(_onDeleteWorkout);
  }

  Future<void> _onLoadWorkouts(LoadWorkouts event, Emitter<WorkoutState> emit) async {
    try {
      emit(WorkoutLoading());
      final workouts = await _repository.getWorkouts();
      emit(WorkoutLoaded(workouts.toList()));
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> _onAddWorkout(AddWorkout event, Emitter<WorkoutState> emit) async {
    try {
      if (state is WorkoutLoaded) {
        final currentWorkouts = (state as WorkoutLoaded).workoutSets;
        await _repository.addWorkout(event.workoutSet);
        emit(WorkoutLoaded([...currentWorkouts, event.workoutSet]));
      }
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> _onUpdateWorkout(UpdateWorkout event, Emitter<WorkoutState> emit) async {
    try {
      if (state is WorkoutLoaded) {
        final currentWorkouts = (state as WorkoutLoaded).workoutSets;
        await _repository.updateWorkout(event.workoutSet);
        final updatedWorkouts = currentWorkouts
            .map((workout) => workout.id == event.workoutSet.id ? event.workoutSet : workout)
            .toList();
        emit(WorkoutLoaded(updatedWorkouts));
      }
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }

  Future<void> _onDeleteWorkout(DeleteWorkout event, Emitter<WorkoutState> emit) async {
    try {
      if (state is WorkoutLoaded) {
        final currentWorkouts = (state as WorkoutLoaded).workoutSets;
        await _repository.deleteWorkout(event.id);
        final updatedWorkouts = currentWorkouts.where((workout) => workout.id != event.id).toList();
        emit(WorkoutLoaded(updatedWorkouts));
      }
    } catch (e) {
      emit(WorkoutError(e.toString()));
    }
  }
}
