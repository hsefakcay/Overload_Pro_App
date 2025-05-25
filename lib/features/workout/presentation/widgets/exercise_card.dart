import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/mixins/localization_mixin.dart';
import 'package:overload_pro_app/product/models/set_model.dart';
import 'package:overload_pro_app/features/exercise/view/exercise_progress_view.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({
    required this.exerciseName,
    required this.workouts,
    super.key,
  });
  final String exerciseName;
  final List<SetModel> workouts;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> with LocalizationMixin {
  SetModel _findBestWorkout(List<SetModel> workouts) {
    return workouts.reduce((curr, next) => curr.weight > next.weight ? curr : next);
  }

  Color _getSetTypeColor(SetType setType) {
    switch (setType) {
      case SetType.failure:
        return Colors.red;
      case SetType.warmUp:
        return Colors.orange;
      case SetType.rir1_2:
        return Colors.green;
      case SetType.dropSet:
        return Colors.purple;
    }
  }

  void _navigateToExerciseProgress(BuildContext context, String exerciseId, String exerciseName) {
    Navigator.push(
      context,
      MaterialPageRoute<ExerciseProgressView>(
        builder: (context) => ExerciseProgressView(
          exerciseId: exerciseId,
          exerciseName: exerciseName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lastWorkout = widget.workouts.reduce(
      (curr, next) =>
          curr.completedAt?.isAfter(next.completedAt ?? DateTime.now()) ?? false ? curr : next,
    );
    final bestWorkout = _findBestWorkout(widget.workouts);
    final totalWorkouts = widget.workouts.length;

    return Card(
      margin: EdgeInsets.only(bottom: context.lowValue),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            widget.workouts.first.exercise.imageUrl ?? '',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.exerciseName,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.update,
                  size: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd/MM/yyyy').format(lastWorkout.completedAt ?? DateTime.now()),
                  style: context.bodySmall.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events_outlined,
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.personalBest,
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${bestWorkout.weight} ${l10n.kg} × ${bestWorkout.reps}',
                          style: context.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getSetTypeColor(bestWorkout.setType).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          bestWorkout.setType.displayName,
                          style: context.bodySmall.copyWith(
                            color: _getSetTypeColor(bestWorkout.setType),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        l10n.totalSets(totalWorkouts),
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () => _navigateToExerciseProgress(context, lastWorkout.id, widget.exerciseName),
      ),
    );
  }
}
