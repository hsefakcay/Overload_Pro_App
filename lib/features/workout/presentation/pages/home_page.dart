import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';
import 'package:weight_tracker_app/features/exercise/data/repositories/exercise_repository.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_state.dart';
import 'package:weight_tracker_app/features/workout/presentation/widgets/custom_dropdown.dart';
import 'package:weight_tracker_app/features/workout/presentation/widgets/exercise_card.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with LocalizationMixin {
  final _exerciseRepository = ExerciseRepository();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(child: _buildWorkoutList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        l10n.homeTitle,
        style: context.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: context.paddingMedium,
      child: _buildCategoryDropdown(),
    );
  }

  Widget _buildCategoryDropdown() {
    final categories = [l10n.muscleGroupAll, ..._exerciseRepository.getAllMuscleGroups(context)];

    return CustomDropdown<String>(
      value: _selectedCategory,
      labelText: l10n.categoryLabel,
      hintText: l10n.categorySelectHint,
      items: categories.map(_buildDropdownMenuItem).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      menuMaxHeight: context.height * 0.5,
    );
  }

  Widget _buildWorkoutList() {
    return BlocBuilder<WorkoutBloc, WorkoutState>(
      builder: (context, state) {
        if (state is WorkoutInitial) {
          context.read<WorkoutBloc>().add(LoadWorkouts());
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WorkoutLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WorkoutError) {
          return _buildErrorView(state.message);
        }

        if (state is WorkoutLoaded) {
          if (state.workoutSets.isEmpty) {
            return _buildEmptyView();
          }

          final exerciseGroups = _groupWorkoutsByExercise(state.workoutSets);

          if (exerciseGroups.isEmpty) {
            return _buildEmptyCategoryView();
          }

          final sortedExercises = _getSortedExercises(exerciseGroups);
          return _buildExerciseList(sortedExercises, exerciseGroups);
        }

        return const SizedBox.shrink();
      },
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String? category) {
    return DropdownMenuItem(
      value: category,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.lowValue,
          vertical: context.lowValue / 2,
        ),
        child: Text(category ?? ''),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Text(
        message,
        style: context.bodyMedium,
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noWorkouts,
            style: context.bodyLarge.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCategoryView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            l10n.noCategoryWorkouts,
            style: context.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.mediumValue),
            child: Text(
              _selectedCategory != null
                  ? l10n.noCategoryWorkoutsDetail(_selectedCategory!)
                  : l10n.noWorkoutsDetail,
              style: context.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<SetModel>> _groupWorkoutsByExercise(List<SetModel> workouts) {
    final exerciseGroups = <String, List<SetModel>>{};
    final exerciseRepository = ExerciseRepository();

    for (final workout in workouts) {
      if (_selectedCategory != null && _selectedCategory != l10n.muscleGroupAll) {
        final selectedCategoryIdentifier =
            exerciseRepository.getMuscleGroupIdentifier(context, _selectedCategory!);
        if (workout.exercise.muscleGroup != selectedCategoryIdentifier) {
          continue;
        }
      }

      if (!exerciseGroups.containsKey(workout.exercise.name)) {
        exerciseGroups[workout.exercise.name] = [];
      }
      exerciseGroups[workout.exercise.name]!.add(workout);
    }

    return exerciseGroups;
  }

  List<String> _getSortedExercises(Map<String, List<SetModel>> exerciseGroups) {
    return exerciseGroups.keys.toList()
      ..sort((a, b) {
        final lastWorkoutA = exerciseGroups[a]!.reduce(
          (curr, next) =>
              curr.completedAt?.isAfter(next.completedAt ?? DateTime.now()) ?? false ? curr : next,
        );
        final lastWorkoutB = exerciseGroups[b]!.reduce(
          (curr, next) =>
              curr.completedAt?.isAfter(next.completedAt ?? DateTime.now()) ?? false ? curr : next,
        );
        return lastWorkoutB.completedAt?.compareTo(lastWorkoutA.completedAt ?? DateTime.now()) ?? 0;
      });
  }

  Widget _buildExerciseList(
    List<String> sortedExercises,
    Map<String, List<SetModel>> exerciseGroups,
  ) {
    return ListView.builder(
      padding: context.paddingMedium,
      itemCount: sortedExercises.length,
      itemBuilder: (context, index) {
        final exerciseName = sortedExercises[index];
        final workouts = exerciseGroups[exerciseName]!;
        return ExerciseCard(
          exerciseName: exerciseName,
          workouts: workouts,
        );
      },
    );
  }
}
