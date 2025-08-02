import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/extensions/snack_bar.dart';
import '../../../common/l10n/app_localizations.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../widgets/account_card.dart';
import '../widgets/creation_time_card.dart';
import '../widgets/nickname_card.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/sign_out_button.dart';
import '../widgets/user_id_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = context.read<ProfileViewModel>();
      _viewModel!.addListener(_handleViewModelChanges);
    });
  }

  void _handleViewModelChanges() {
    final viewModel = context.read<ProfileViewModel>();
    if (viewModel.successMessage != null) {
      context.showSnackBar(
        SnackBar(
          content: Text(viewModel.successMessage!),
          behavior: SnackBarBehavior.floating,
        ),
      );
      viewModel.clearSuccessMessage();
    }
    if (viewModel.error != null) {
      context.showSnackBar(
        SnackBar(
          content: Text('오류: ${viewModel.error!}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      viewModel.clearError();
    }
  }

  @override
  void dispose() {
    _viewModel?.removeListener(_handleViewModelChanges);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
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
              const ProfileAvatar(),
              const AccountCard(),
              const NicknameCard(),
              const CreationTimeCard(),
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
              const SignOutButton(),
              const UserIdCard(),
            ],
          ),
          Selector<ProfileViewModel, bool>(
            selector: (context, viewModel) => viewModel.isLoading,
            builder: (context, isLoading, _) {
              return Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(child: CircularProgressIndicator()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
