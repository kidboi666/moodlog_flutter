import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/common.dart';
import '../../../../common/constants/enum.dart';
import '../../../../common/l10n/app_localizations.dart';
import '../../../../common/theme/colors.dart';
import '../../viewmodel/settings_viewmodel.dart';

class ColorThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ColorThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(
        t.settings_common_color_theme_title,
        style: textTheme.titleLarge,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: ColorTheme.values.length,
          itemBuilder: (context, index) {
            final colorTheme = ColorTheme.values[index];
            final isSelected = viewModel.appState.colorTheme == colorTheme;
            final color = AppColor.colorMap[colorTheme]!;

            return GestureDetector(
              onTap: () {
                viewModel.setColorTheme(colorTheme);
              },
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? Icon(Icons.check, color: Colors.white, size: 24)
                        : null,
                  ),
                  const SizedBox(height: Spacing.md),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(t.common_confirm_cancel),
        ),
      ],
    );
  }
}
