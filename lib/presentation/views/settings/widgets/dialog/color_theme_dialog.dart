import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/theme/colors.dart';

import '../../../../../core/constants/enum.dart';
import '../../../../../core/l10n/app_localizations.dart';
import '../../../../view_models/settings/settings_viewmodel.dart';

class ColorThemeDialog extends StatelessWidget {
  final SettingsViewModel viewModel;

  const ColorThemeDialog({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.settings_common_color_theme_title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return GridView.builder(
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
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  width: 3,
                                )
                              : Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: 1,
                                ),
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
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(AppLocalizations.of(context)!.common_confirm_cancel),
        ),
      ],
    );
  }
}
