import 'package:overload_pro_app/product/models/set_model.dart';
import 'package:overload_pro_app/product/database/database_helper.dart';
import 'package:overload_pro_app/features/workout/domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  WorkoutRepositoryImpl(this._databaseHelper);
  final DatabaseHelper _databaseHelper;

  @override
  Future<List<SetModel>> getWorkouts() async {
    return _databaseHelper.getWorkouts();
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
