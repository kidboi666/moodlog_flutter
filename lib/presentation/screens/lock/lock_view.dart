import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/presentation/screens/lock/lock_view_model.dart';
import 'package:provider/provider.dart';

part 'lock_content.dart';

class LockScreen extends StatelessWidget {
  const LockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LockViewModel(
        settingsUseCase: context.read(),
        appStateProvider: context.read(),
      ),
      child: const _LockScreenContent(),
    );
  }
}
