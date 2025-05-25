import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overload_pro_app/features/profile/repositories/profile_repository.dart';
import 'package:overload_pro_app/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:overload_pro_app/features/workout/domain/repositories/workout_repository.dart';
import 'package:overload_pro_app/product/database/database_helper.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton(prefs);

  // Database
  locator.registerLazySingleton(DatabaseHelper.new);

  // Repositories
  locator.registerLazySingleton(() => ProfileRepository(prefs));
  locator.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(locator<DatabaseHelper>()),
  );
}
