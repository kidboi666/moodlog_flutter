import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        final locationInfo = viewModel.locationInfo;

        if (locationInfo == null) {
          return IconButton(
            onPressed: () {
              viewModel.getCurrentLocation();
            },
            icon: Icon(Icons.location_on),
          );
        }

        return IconButton(
          onPressed: () => viewModel.clearLocation(),
          icon: Icon(
            Icons.location_on,
            color: colorScheme.primary,
          ),
          style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
        );
      },
    );
  }
}
