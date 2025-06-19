// ProfilePage'dan dışarı taşınan widgetlar:
// - ProfileView, _ProfileContent, _ProfileActions, _ProfileActionCard, _ThemeToggleCard, _ErrorView, _LoadingView, WeightHistoryPage

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/core/theme/theme_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_event.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_state.dart';
import 'package:overload_pro_app/features/profile/presentation/dialogs/profile_dialogs.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_summary_card.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_history_card.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';
import 'package:overload_pro_app/core/router/app_routes.dart';
import 'package:overload_pro_app/features/profile/presentation/screens/edit_profile_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const _LoadingView();
          }
          if (state is ProfileError) {
            return _ErrorView(message: state.message);
          }
          if (state is ProfileLoaded) {
            return _ProfileContent(
              profile: state.profile,
              weightRecords: state.weightRecords,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: context.bodyMedium,
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.profile,
    required this.weightRecords,
  });
  final UserProfileModel profile;
  final List<WeightRecordModel> weightRecords;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ProfileAppBar(profile: profile),
        SliverToBoxAdapter(
          child: Padding(
            padding: context.paddingMedium,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeightSummaryCard(
                  profile: profile,
                  weightRecords: weightRecords,
                  onBMITap: (bmi) => _showBMIInfoDialog(context, bmi),
                ),
                SizedBox(height: context.mediumValue),
                _ProfileActions(profile: profile),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showBMIInfoDialog(BuildContext context, double bmi) {
    ProfileDialogs.showBMIInfoDialog(context, bmi);
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions({required this.profile});
  final UserProfileModel profile;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _ProfileActionCard(
          icon: Icons.edit,
          title: l10n.editPersonalInfo,
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => BlocProvider.value(
                  value: context.read<ProfileBloc>(),
                  child: EditProfilePage(
                    initialName: profile.name,
                    initialWeight: profile.targetWeight,
                    initialHeight: profile.height,
                    initialPhotoUrl: profile.photoUrl,
                    initialTargetWeight: profile.targetWeight,
                  ),
                ),
              ),
            );
            if (result == true) {
              context.read<ProfileBloc>().add(LoadProfile());
            }
          },
        ),
        _ProfileActionCard(
          icon: Icons.monitor_weight_rounded,
          title: l10n.weightTracking,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<dynamic>(
                builder: (_) => BlocProvider.value(
                  value: context.read<ProfileBloc>(),
                  child: const WeightHistoryPage(),
                ),
              ),
            );
          },
        ),
        _ProfileActionCard(
          icon: Icons.bar_chart_outlined,
          title: l10n.statistics,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.workoutStatistics);
          },
        ),
        const _ThemeToggleCard(),
        _ProfileActionCard(
          icon: Icons.privacy_tip_outlined,
          title: l10n.privacyPolicy,
          onTap: _launchPrivacyPolicy,
        ),
      ],
    );
  }

  Future<void> _launchPrivacyPolicy() async {
    final url = Uri.parse('https://hsefakcay.github.io/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}

class _ProfileActionCard extends StatelessWidget {
  const _ProfileActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}

class _ThemeToggleCard extends StatelessWidget {
  const _ThemeToggleCard();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;
        return Card(
          child: ListTile(
            leading: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: Text(isDarkMode ? l10n.darkMode : l10n.lightMode),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (_) => context.read<ThemeBloc>().add(ToggleTheme()),
            ),
          ),
        );
      },
    );
  }
}

class WeightHistoryPage extends StatelessWidget {
  const WeightHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.weightHistory)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: WeightHistoryCard(
                  records: state.weightRecords,
                  profile: state.profile,
                  onDeleteRecord: (id) => context.read<ProfileBloc>().add(DeleteWeightRecord(id)),
                ),
              ),
            );
          }
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
