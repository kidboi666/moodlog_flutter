import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../viewmodel/write_viewmodel.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<WriteViewModel>(
      builder: (context, viewModel, child) {
        final locationInfo = viewModel.locationInfo;

        if (locationInfo == null) {
          return Row(
            children: [
              TextButton.icon(
                onPressed: () => viewModel.getCurrentLocation(),
                icon: Icon(Icons.location_on, size: 16),
                label: Text(t.write_location_add),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          );
        }

        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on, size: 16, color: colorScheme.primary),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  locationInfo.address ??
                      '${locationInfo.latitude.toStringAsFixed(4)}, ${locationInfo.longitude.toStringAsFixed(4)}',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () => viewModel.clearLocation(),
                icon: Icon(Icons.close, size: 16),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 24, minHeight: 24),
              ),
            ],
          ),
        );
      },
    );
  }
}
