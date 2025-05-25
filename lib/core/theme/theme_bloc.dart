import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

// States
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  ThemeLoaded(this.isDarkMode);
  final bool isDarkMode;
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._prefs) : super(ThemeInitial()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
  }
  final SharedPreferences _prefs;
  static const String _themeKey = 'is_dark_mode';

  void _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) {
    final isDarkMode = _prefs.getBool(_themeKey) ?? false;
    emit(ThemeLoaded(isDarkMode));
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final currentState = state;
    if (currentState is ThemeLoaded) {
      final newIsDarkMode = !currentState.isDarkMode;
      _prefs.setBool(_themeKey, newIsDarkMode);
      emit(ThemeLoaded(newIsDarkMode));
    }
  }
}
