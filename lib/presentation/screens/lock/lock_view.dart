import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';
import 'package:moodlog/presentation/providers/app_state_provider.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  void _showPinScreen(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final settingsRepo = context.read<SettingsRepository>();

    screenLockCreate(
      context: context,
      title: Text(t.lockScreenTitle),
      confirmTitle: Text(t.lockScreenConfirmTitle),
      digits: 4,
      onConfirmed: (pin) async {
        await settingsRepo.savePin(pin);
        if (!mounted) return;

        // ignore: use_build_context_synchronously
        context.read<AppStateProvider>().setAuthenticated(true);
        if (mounted) {
          // ignore: use_build_context_synchronously
          context.go(Routes.home);
        }
      },
      footer: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(t.lockScreenCancel),
      ),
    );
  }

  void _showPinVerifyScreen(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final settingsRepo = context.read<SettingsRepository>();

    screenLock(
      context: context,
      correctString: '0000',
      title: Text(t.lockScreenTitle),
      canCancel: false,
      onUnlocked: () {
        context.read<AppStateProvider>().setAuthenticated(true);
        context.go(Routes.home);
      },
      onValidate: (pin) async {
        final isValid = await settingsRepo.verifyPin(pin);
        return isValid;
      },
      onError: (_) {},
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lockType = context.read<AppStateProvider>().appState.lockType;
      final settingsRepo = context.read<SettingsRepository>();

      if (lockType == LockType.none) {
        context.read<AppStateProvider>().setAuthenticated(true);
        context.go(Routes.home);
      } else if (lockType == LockType.pin) {
        settingsRepo.hasPin().then((hasPin) {
          if (!mounted) return;
          if (hasPin) {
            _showPinVerifyScreen(context);
          } else {
            _showPinScreen(context);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80),
            const SizedBox(height: 20),
            Text(
              t.lockScreenTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
