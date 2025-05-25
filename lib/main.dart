import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overload_pro_app/core/constants/app_constants.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/core/router/app_routes.dart';
import 'package:overload_pro_app/core/theme/app_theme.dart';
import 'package:overload_pro_app/core/theme/theme_bloc.dart';
import 'package:overload_pro_app/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/product/database/database_helper.dart';
import 'package:overload_pro_app/product/di/locator.dart';
import 'package:overload_pro_app/product/init/app_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Platform kontrolü
  if (!Platform.isAndroid && !Platform.isIOS) {
    await SystemNavigator.pop();
    return;
  }

  await AppInit.init();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WorkoutBloc>(
          create: (context) => WorkoutBloc(
            WorkoutRepositoryImpl(
              DatabaseHelper(),
            ),
          ),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(locator<SharedPreferences>())..add(LoadTheme()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getLightTheme(context),
            darkTheme: AppTheme.getDarkTheme(context),
            themeMode: state is ThemeLoaded && state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.splash,
            routes: AppRoutes.routes,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English
              Locale('tr'), // Turkish
            ],
          );
        },
      ),
    );
  }
}
