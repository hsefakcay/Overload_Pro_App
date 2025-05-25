import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/core/theme/theme_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_state.dart';
import 'package:overload_pro_app/product/di/locator.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_event.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_state.dart';
import 'package:overload_pro_app/features/profile/presentation/dialogs/profile_dialogs.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_history_card.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_summary_card.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/workout_statistics_card.dart';
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
                            onBMITap: (bmi) => _showBMIInfoDialog(context, bmi),
                          ),
                          SizedBox(height: context.mediumValue),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Kişisel Bilgileri Düzenle'),
                              onTap: () {},
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: const Icon(Icons.monitor_weight_rounded),
                              title: const Text('Kilo Takibi'),
                              onTap: () {},
                            ),
                          ),
                          SizedBox(height: context.lowValue),
                          BlocBuilder<ThemeBloc, ThemeState>(
                            builder: (context, themeState) {
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    themeState is ThemeLoaded && themeState.isDarkMode
                                        ? Icons.dark_mode
                                        : Icons.light_mode,
                                  ),
                                  title: Text(
                                    themeState is ThemeLoaded && themeState.isDarkMode
                                        ? 'Dark Mode'
                                        : 'Light Mode',
                                  ),
                                  trailing: Switch(
                                    value: themeState is ThemeLoaded && themeState.isDarkMode,
                                    onChanged: (value) {
                                      context.read<ThemeBloc>().add(ToggleTheme());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: context.lowValue),
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

  void _showBMIInfoDialog(BuildContext context, double bmi) {
    ProfileDialogs.showBMIInfoDialog(context, bmi);
  }
}
