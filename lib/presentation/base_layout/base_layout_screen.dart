import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/navigation.dart';
import '../../core/routing/routes.dart';
import '../../core/ui/widgets/avatar.dart';
import '../../core/ui/widgets/banner_ad_widget.dart';
import '../../core/utils/animated_container.dart';
import 'base_layout_viewmodel.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/rail_navigation.dart';
import 'widgets/title_bar.dart';

part 'base_layout_screen_content.dart';

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
        locationUseCase: context.read(),
        weatherUseCase: context.read(),
      ),
      child: _BaseLayoutScreenContent(
        navigationShell: navigationShell,
        children: children,
      ),
    );
  }
}
