import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/write_viewmodel.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Consumer<WriteViewModel>(
        builder: (context, viewModel, child) {
          final locationInfo = viewModel.locationInfo;
          if (locationInfo == null) {
            return SizedBox.shrink();
          }

          return Container(
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
                Expanded(
                  child: Text(
                    locationInfo.address ??
                        '${locationInfo.latitude.toStringAsFixed(2)}, ${locationInfo.longitude.toStringAsFixed(2)}',
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () => viewModel.clearLocation(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.close,
                      size: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
