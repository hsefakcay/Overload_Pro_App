import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:weight_tracker_app/core/generated/l10n/app_localizations.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:weight_tracker_app/features/workout/presentation/bloc/workout_state.dart';
import 'package:weight_tracker_app/product/di/locator.dart';
import 'package:weight_tracker_app/features/profile/bloc/profile_bloc.dart';
import 'package:weight_tracker_app/features/profile/bloc/profile_event.dart';
import 'package:weight_tracker_app/features/profile/bloc/profile_state.dart';
import 'package:weight_tracker_app/features/profile/presentation/dialogs/profile_dialogs.dart';
import 'package:weight_tracker_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:weight_tracker_app/features/profile/presentation/widgets/weight_history_card.dart';
import 'package:weight_tracker_app/features/profile/presentation/widgets/weight_summary_card.dart';
import 'package:weight_tracker_app/features/profile/presentation/widgets/workout_statistics_card.dart';
import 'dart:async';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(locator())..add(LoadProfile()),
        ),
        BlocProvider(
          create: (context) => WorkoutBloc(locator())..add(LoadWorkouts()),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: context.bodyMedium,
                ),
              );
            }

            if (state is ProfileLoaded) {
              return CustomScrollView(
                slivers: [
                  ProfileAppBar(profile: state.profile),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: context.paddingMedium,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WeightSummaryCard(
                            profile: state.profile,
                            weightRecords: state.weightRecords,
                            onWeightTap: (weight) => _showWeightSettingDialog(context, weight),
                            onTargetWeightTap: (targetWeight) =>
                                _showTargetWeightDialog(context, targetWeight),
                            onHeightTap: (height) => _showHeightSettingDialog(context, height),
                            onBMITap: (bmi) => _showBMIInfoDialog(context, bmi),
                          ),
                          SizedBox(height: context.mediumValue),
                          ElevatedButton.icon(
                            onPressed: () => _showPersonalInfoDialog(context, state),
                            icon: const Icon(Icons.edit),
                            label: const Text('Kişisel Bilgileri Düzenle'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: context.mediumValue),
                          BlocBuilder<WorkoutBloc, WorkoutState>(
                            builder: (context, workoutState) {
                              if (workoutState is WorkoutLoaded) {
                                return WorkoutStatisticsCard(
                                  workoutSets: workoutState.workoutSets,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: context.mediumValue),
                          WeightHistoryCard(
                            records: state.weightRecords,
                            profile: state.profile,
                            onDeleteRecord: (id) =>
                                context.read<ProfileBloc>().add(DeleteWeightRecord(id)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showWeightSettingDialog(BuildContext context, double currentWeight) {
    ProfileDialogs.showWeightSettingDialog(
      context,
      currentWeight: currentWeight,
      onSave: (weight) {
        context.read<ProfileBloc>().add(
              UpdateProfile(
                name: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.name
                    : '',
                height: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.height
                    : 0,
                targetWeight: weight,
              ),
            );
      },
    );
  }

  void _showTargetWeightDialog(BuildContext context, double currentTargetWeight) {
    ProfileDialogs.showTargetWeightDialog(
      context,
      currentTargetWeight: currentTargetWeight,
      onSave: (targetWeight) {
        context.read<ProfileBloc>().add(
              UpdateProfile(
                name: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.name
                    : '',
                height: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.height
                    : 0,
                targetWeight: targetWeight,
              ),
            );
      },
    );
  }

  void _showHeightSettingDialog(BuildContext context, double currentHeight) {
    ProfileDialogs.showHeightSettingDialog(
      context,
      currentHeight: currentHeight,
      onSave: (height) {
        context.read<ProfileBloc>().add(
              UpdateProfile(
                name: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.name
                    : '',
                height: height,
                targetWeight: context.read<ProfileBloc>().state is ProfileLoaded
                    ? (context.read<ProfileBloc>().state as ProfileLoaded).profile.targetWeight
                    : 0,
              ),
            );
      },
    );
  }

  void _showBMIInfoDialog(BuildContext context, double bmi) {
    ProfileDialogs.showBMIInfoDialog(context, bmi);
  }

  void _showPersonalInfoDialog(BuildContext context, ProfileLoaded state) {
    final latestWeight = state.weightRecords.isNotEmpty ? state.weightRecords.first.weight : 0.0;
    ProfileDialogs.showPersonalInfoDialog(
      context,
      currentWeight: latestWeight,
      targetWeight: state.profile.targetWeight,
      height: state.profile.height,
      onSave: (weight, targetWeight, height) {
        context.read<ProfileBloc>().add(
              UpdateProfile(
                name: state.profile.name,
                height: height,
                targetWeight: targetWeight,
              ),
            );
        if (weight != latestWeight) {
          context.read<ProfileBloc>().add(
                AddWeightRecord(
                  weight: weight,
                  note: 'Updated from personal info',
                ),
              );
        }
      },
    );
  }
}
