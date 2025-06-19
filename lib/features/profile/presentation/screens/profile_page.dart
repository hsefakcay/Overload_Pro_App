import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overload_pro_app/core/mixins/localization_mixin.dart';
import 'package:overload_pro_app/core/router/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';
import 'package:overload_pro_app/core/generated/l10n/app_localizations.dart';
import 'package:overload_pro_app/core/theme/theme_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:overload_pro_app/features/workout/presentation/bloc/workout_event.dart';
import 'package:overload_pro_app/product/di/locator.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_bloc.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_event.dart';
import 'package:overload_pro_app/features/profile/bloc/profile_state.dart';
import 'package:overload_pro_app/features/profile/presentation/dialogs/profile_dialogs.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_history_card.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/weight_summary_card.dart';
import 'package:overload_pro_app/product/models/user_profile_model.dart';
import 'package:overload_pro_app/product/models/weight_record_model.dart';
import 'package:overload_pro_app/features/profile/presentation/screens/edit_profile_page.dart';
import 'package:overload_pro_app/features/profile/presentation/widgets/profile_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with LocalizationMixin {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(locator())..add(LoadProfile()),
        ),
        BlocProvider(
          create: (context) => WorkoutBloc(locator())..add(LoadWorkouts()),
        ),
      ],
      child: const ProfileView(),
    );
  }
}
