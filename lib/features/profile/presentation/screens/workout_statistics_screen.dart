import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/workout_statistics_card.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_state.dart';

class WorkoutStatisticsScreen extends StatelessWidget {
  const WorkoutStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.statistics,
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
            return SingleChildScrollView(
              padding: context.paddingMedium,
              child: WorkoutStatisticsCard(
                workoutSets: state.workoutSets,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
