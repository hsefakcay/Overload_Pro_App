import 'package:weight_tracker_app/product/models/set_model.dart';
import '../../../../product/database/database_helper.dart';
import '../../domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final DatabaseHelper _databaseHelper;

  WorkoutRepositoryImpl(this._databaseHelper);

  @override
  Future<List<SetModel>> getWorkouts() async {
    return await _databaseHelper.getWorkouts();
  }

  @override
  Future<void> addWorkout(SetModel workout) async {
    await _databaseHelper.insertWorkout(workout);
  }

  @override
  Future<void> updateWorkout(SetModel workout) async {
    await _databaseHelper.updateWorkout(workout);
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await _databaseHelper.deleteWorkout(id);
  }
}
