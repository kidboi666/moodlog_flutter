import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../write_view_model.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final locationInfo = context.select(
      (WriteViewModel vm) => vm.locationInfo,
    );

    if (locationInfo == null) {
      return Row(
        children: [
          TextButton.icon(
            onPressed: () => context.read<WriteViewModel>().getCurrentLocation(),
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

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 12, color: colorScheme.primary),
              SizedBox(width: 4),
              Text(
                locationInfo.address ??
                    '${locationInfo.latitude.toStringAsFixed(2)}, ${locationInfo.longitude.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        TextButton.icon(
          onPressed: () => context.read<WriteViewModel>().clearLocation(),
          icon: Icon(Icons.close, size: 14),
          label: Text(t.write_location_remove),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
