import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../product/models/exercise_model.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseModel exercise;
  final bool isSelected;
  final VoidCallback onTap;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8 : 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 3,
              )
            : BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 0.5,
              ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Padding(
              padding: context.paddingLow,
              child: _buildExerciseImage(context),
            ),
            Expanded(
              child: _buildExerciseDetails(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseImage(BuildContext context) {
    return Hero(
      tag: 'exercise_${exercise.id}',
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(12),
        ),
        child: Image.asset(
          exercise.imageUrl ?? "",
          width: context.dynamicWidth(0.25),
          height: context.dynamicWidth(0.2),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildExerciseDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.name,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            exercise.muscleGroup ?? '',
            style: context.bodyMedium,
          ),
        ],
      ),
    );
  }
}
