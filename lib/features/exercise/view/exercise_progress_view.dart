import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/product/models/set_model.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/features/exercise/widgets/exercise_progress_chart.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_state.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_event.dart';

class ExerciseProgressView extends StatelessWidget {
  const ExerciseProgressView({
    required this.exerciseId,
    required this.exerciseName,
    super.key,
  });
  final String exerciseId;
  final String exerciseName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutInitial) {
            context.read<WorkoutBloc>().add(LoadWorkouts());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutError) {
            return Center(
              child: Text(
                state.message,
                style: context.bodyMedium,
              ),
            );
          }

          if (state is WorkoutLoaded) {
            final exerciseWorkouts =
                state.workoutSets.where((set) => set.exercise.name == exerciseName).toList();

            if (exerciseWorkouts.isEmpty) {
              return Center(
                child: Text(
                  'Bu egzersiz için henüz kayıtlı antrenman bulunmuyor.',
                  style: context.bodyMedium,
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          ExerciseProgressChart(
                            progressData: exerciseWorkouts,
                            exerciseName: exerciseName,
                          ),
                          Expanded(
                            child: Padding(
                              padding: context.paddingMedium,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: context.paddingMedium,
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.fitness_center,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Son Antrenman Detayları',
                                            style: context.titleMedium.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: context.paddingMedium,
                                      child: Column(
                                        children: [
                                          _buildDetailRow(
                                            context,
                                            'Ağırlık',
                                            '${exerciseWorkouts.last.weight} kg',
                                            Icons.monitor_weight_outlined,
                                          ),
                                          _buildDetailRow(
                                            context,
                                            'Tekrar',
                                            exerciseWorkouts.last.reps.toString(),
                                            Icons.repeat,
                                          ),
                                          _buildDetailRow(
                                            context,
                                            'Set Tipi',
                                            exerciseWorkouts.last.setType.displayName,
                                            Icons.category_outlined,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.bodySmall.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
