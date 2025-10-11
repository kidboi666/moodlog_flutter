import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/snack_bar.dart';
import '../../core/l10n/app_localizations.dart';
import 'profile_view_model.dart';
import 'widgets/creation_time_card.dart';
import 'widgets/nickname_card.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/user_id_card.dart';

part 'profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(
        userProvider: context.read(),
        pickImageUseCase: context.read(),
      ),
      child: _ProfileScreenContent(),
    );
  }
}
