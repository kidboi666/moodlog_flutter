part of 'lock_view.dart';

class _LockScreenContent extends StatefulWidget {
  const _LockScreenContent();

  @override
  State<_LockScreenContent> createState() => _LockScreenContentState();
}

class _LockScreenContentState extends State<_LockScreenContent> {
  void _showPinScreen(BuildContext context, LockViewModel viewModel) {
    final t = AppLocalizations.of(context)!;

    screenLockCreate(
      context: context,
      title: Text(t.lockScreenTitle),
      confirmTitle: Text(t.lockScreenConfirmTitle),
      digits: 4,
      onConfirmed: (pin) async {
        await viewModel.savePin(pin);
        if (!mounted) return;

        if (mounted) {
          context.go(Routes.home);
        }
      },
      footer: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(t.lockScreenCancel),
      ),
    );
  }

  void _showPinVerifyScreen(BuildContext context, LockViewModel viewModel) {
    final t = AppLocalizations.of(context)!;

    screenLock(
      context: context,
      correctString: '0000',
      title: Text(t.lockScreenTitle),
      canCancel: false,
      onUnlocked: () {
        context.go(Routes.home);
      },
      onValidate: (pin) async {
        return await viewModel.verifyPin(pin);
      },
      onError: (_) {},
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<LockViewModel>();
      final lockType = viewModel.lockType;

      if (lockType == LockType.none) {
        viewModel.setAuthenticated();
        context.go(Routes.home);
      } else if (lockType == LockType.pin) {
        viewModel.hasPin().then((hasPin) {
          if (!mounted) return;
          if (hasPin) {
            _showPinVerifyScreen(context, viewModel);
          } else {
            _showPinScreen(context, viewModel);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}
