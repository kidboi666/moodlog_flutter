import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/profile/widgets/anonymous_user_card.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/snack_bar.dart';
import '../../core/l10n/app_localizations.dart';
import 'profile_view_model.dart';
import 'widgets/account_card.dart';
import 'widgets/creation_time_card.dart';
import 'widgets/delete_account_button.dart';
import 'widgets/nickname_card.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/sign_out_button.dart';
import 'widgets/user_id_card.dart';

part 'profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(
        userProvider: context.read(),
        authUseCase: context.read(),
        pickImageUseCase: context.read(),
      ),
      child: _ProfileScreenContent(),
    );
  }
}
