import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/navigation.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/routing/routes.dart';
import '../../core/ui/widgets/animated_container.dart';
import '../settings/widgets/dialog/app_info_dialog.dart';
import '../settings/widgets/dialog/contact_dialog.dart';

import 'base_layout_view_model.dart';
import 'widgets/title_bar.dart';
import 'widgets/weather_widget.dart';

import '../settings/widgets/section_header.dart';

part 'base_layout_content.dart';

class BaseLayoutScreen extends StatelessWidget {
  final List<Widget> children;
  final StatefulNavigationShell navigationShell;

  const BaseLayoutScreen({
    super.key,
    required this.children,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BaseLayoutViewModel(
        userProvider: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
        settingsRepository: context.read(),
      ),
      child: _BaseLayoutScreenContent(
        navigationShell: navigationShell,
        children: children,
      ),
    );
  }
}
