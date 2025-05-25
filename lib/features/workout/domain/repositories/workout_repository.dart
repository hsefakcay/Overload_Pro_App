import 'package:weight_tracker_app/product/models/set_model.dart';

abstract class WorkoutRepository {
  Future<List<SetModel>> getWorkouts();
  Future<void> addWorkout(SetModel workout);
  Future<void> updateWorkout(SetModel workout);
  Future<void> deleteWorkout(String id);
}
