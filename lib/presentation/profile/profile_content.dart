part of 'profile_view.dart';

class _ProfileScreenContent extends StatefulWidget {
  @override
  State<_ProfileScreenContent> createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<_ProfileScreenContent> {
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
      viewModel.clearState();
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
    final isAnonymousUser = context.select(
      (ProfileViewModel vm) => vm.isAnonymousUser,
    );

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
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.sm,
            children: [
              const ProfileAvatar(),
              const AccountCard(),
              if (isAnonymousUser) const AnonymousUserCard(),
              if (isAnonymousUser) const GuestLoginButton(),
              const NicknameCard(),
              const CreationTimeCard(),
              if (!isAnonymousUser) const DeleteAccountButton(),
              const Expanded(child: SizedBox()),
              if (!isAnonymousUser) const SignOutButton(),
              const UserIdCard(),
            ],
          ),
          Builder(
            builder: (context) {
              final isLoading = context.select(
                (ProfileViewModel vm) => vm.isLoading,
              );
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
