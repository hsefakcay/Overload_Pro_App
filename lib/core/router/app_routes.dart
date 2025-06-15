import 'package:flutter/material.dart';
import 'package:overload_pro_app/features/history/history_page.dart';
import 'package:overload_pro_app/features/main/main_page.dart';
import 'package:overload_pro_app/features/profile/presentation/screens/profile_page.dart';
import 'package:overload_pro_app/features/profile/presentation/screens/workout_statistics_screen.dart';
import 'package:overload_pro_app/features/splash/splash_screen.dart';
import 'package:overload_pro_app/features/workout/presentation/pages/add_workout_page.dart';
import 'package:overload_pro_app/features/workout/presentation/pages/home_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String main = '/main';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String addWorkout = '/add-workout';
  static const String workoutStatistics = '/workout-statistics';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        main: (context) => const MainPage(child: HomePage()),
        history: (context) => const MainPage(child: HistoryPage()),
        profile: (context) => const MainPage(child: ProfilePage()),
        addWorkout: (context) => const AddWorkoutPage(),
        workoutStatistics: (context) => const WorkoutStatisticsScreen(),
      };
}
