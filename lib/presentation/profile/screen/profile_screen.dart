import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../widgets/account_card.dart';
import '../widgets/creation_time_card.dart';
import '../widgets/nickname_card.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/user_id_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(t.profile_title),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: Stack(
            children: [
              Column(
                spacing: Spacing.sm,
                children: [
                  ProfileAvatar(photoUrl: viewModel.user?.photoURL),
                  AccountCard(
                    isGoogleUser: viewModel.isGoogleUser,
                    email: viewModel.user?.email ?? '',
                  ),
                  NicknameCard(
                    nickname: viewModel.user?.displayName ?? '',
                    updateDisplayName: viewModel.updateDisplayName,
                    showEditDisplayNameDialog:
                        viewModel.showEditDisplayNameDialog,
                  ),
                  CreationTimeCard(
                    creationTime: viewModel.user?.metadata.creationTime,
                  ),
                  const Expanded(child: SizedBox()),
                  UserIdCard(uid: viewModel.user?.uid ?? ''),
                ],
              ),
              if (viewModel.isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
