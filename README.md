# Weight Tracker App

A Flutter application for tracking workout weights and exercises.

## Features

- Track exercises with weights, sets, and reps
- Record workout history
- Add notes to workouts
- View workout progress

## Project Structure

The project follows Clean Architecture principles with the following structure:

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── theme/
  │   └── utils/
  └── features/
      └── workout/
          ├── data/
          │   ├── models/
          │   └── repositories/
          ├── domain/
          │   ├── entities/
          │   └── repositories/
          └── presentation/
              ├── bloc/
              ├── pages/
              └── widgets/
```

## Getting Started

1. Install Flutter (3.0.0 or higher)
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the application

## Dependencies

- flutter_bloc: State management
- get_it: Dependency injection
- hive: Local storage
- equatable: Value equality
- intl: Formatting

## Development

To generate necessary files:
```bash
flutter pub run build_runner build
``` 