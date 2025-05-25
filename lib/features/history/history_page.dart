import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:weight_tracker_app/features/workout/presentation/pages/edit_workout_page.dart';
import 'package:weight_tracker_app/product/models/set_model.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with LocalizationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.historyTitle,
          style: context.titleMedium,
        ),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
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
            if (state.workoutSets.isEmpty) {
              return Center(
                child: Text(
                  l10n.noHistory,
                  style: context.bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: context.paddingMedium,
              itemCount: state.workoutSets.length,
              itemBuilder: (context, index) {
                final workout = state.workoutSets[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<EditWorkoutPage>(
                          builder: (context) => EditWorkoutPage(workout: workout),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withAlpha(26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              workout.exercise.name,
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: context.paddingLow,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '${workout.weight} kg × ${workout.reps}',
                              style: context.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy').format(workout.completedAt ?? DateTime.now()),
                            style: context.bodySmall.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(width: context.highValue * 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              workout.setType.displayName,
                              style: context.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          color: Theme.of(context).colorScheme.error,
                          size: context.highValue,
                        ),
                        onPressed: () {
                          showDialog<AlertDialog>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Workout'),
                              content: const Text('Are you sure you want to delete this workout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<WorkoutBloc>().add(DeleteWorkout(workout.id));
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
}
