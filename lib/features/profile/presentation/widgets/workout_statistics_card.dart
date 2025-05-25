import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';
import 'package:weight_tracker_app/features/exercise/data/repositories/exercise_repository.dart';

class WorkoutStatisticsCard extends StatelessWidget {
  const WorkoutStatisticsCard({
    required this.workoutSets,
    super.key,
  });

  final List<SetModel> workoutSets;

  @override
  Widget build(BuildContext context) {
    final exerciseRepository = ExerciseRepository();
    final exerciseStats = _calculateExerciseStats(workoutSets);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: context.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Antrenman İstatistikleri',
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMostFrequentExercises(context, exerciseStats),
            const SizedBox(height: 16),
            _buildHighestWeights(context, exerciseStats),
            const SizedBox(height: 16),
            _buildMuscleGroupDistribution(context, exerciseStats, exerciseRepository),
          ],
        ),
      ),
    );
  }

  Widget _buildMostFrequentExercises(
    BuildContext context,
    Map<String, ExerciseStats> exerciseStats,
  ) {
    final sortedExercises = exerciseStats.values.toList()
      ..sort((a, b) => b.totalSets.compareTo(a.totalSets));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'En Çok Yapılan Egzersizler',
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...sortedExercises.take(3).map(
              (stats) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        stats.exerciseName,
                        style: context.bodyMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${stats.totalSets} set',
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildHighestWeights(
    BuildContext context,
    Map<String, ExerciseStats> exerciseStats,
  ) {
    final sortedExercises = exerciseStats.values.toList()
      ..sort((a, b) => b.highestWeight.compareTo(a.highestWeight));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'En Yüksek Ağırlıklar',
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...sortedExercises.take(3).map(
              (stats) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        stats.exerciseName,
                        style: context.bodyMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${stats.highestWeight} kg',
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Widget _buildMuscleGroupDistribution(
    BuildContext context,
    Map<String, ExerciseStats> exerciseStats,
    ExerciseRepository exerciseRepository,
  ) {
    final muscleGroupStats = <String, int>{};
    for (final stats in exerciseStats.values) {
      final muscleGroup = exerciseRepository.getMuscleGroupTranslation(
        context,
        stats.muscleGroup ?? '',
      );
      muscleGroupStats[muscleGroup] = (muscleGroupStats[muscleGroup] ?? 0) + stats.totalSets;
    }

    final sortedMuscleGroups = muscleGroupStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kas Grubu Dağılımı',
          style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...sortedMuscleGroups.take(3).map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: context.bodyMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${entry.value} set',
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }

  Map<String, ExerciseStats> _calculateExerciseStats(List<SetModel> workoutSets) {
    final exerciseStats = <String, ExerciseStats>{};

    for (final set in workoutSets) {
      final exerciseName = set.exercise.name;
      if (!exerciseStats.containsKey(exerciseName)) {
        exerciseStats[exerciseName] = ExerciseStats(
          exerciseName: exerciseName,
          muscleGroup: set.exercise.muscleGroup,
          totalSets: 0,
          highestWeight: 0,
        );
      }

      final stats = exerciseStats[exerciseName]!;
      stats.totalSets++;
      if (set.weight > stats.highestWeight) {
        stats.highestWeight = set.weight;
      }
    }

    return exerciseStats;
  }
}

class ExerciseStats {
  ExerciseStats({
    required this.exerciseName,
    required this.muscleGroup,
    required this.totalSets,
    required this.highestWeight,
  });
  final String exerciseName;
  final String? muscleGroup;
  int totalSets;
  double highestWeight;
}
