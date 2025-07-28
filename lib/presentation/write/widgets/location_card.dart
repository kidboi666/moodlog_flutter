import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
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

          return DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(8),
              dashPattern: [10, 5],
              strokeWidth: 2,
              color: colorScheme.outlineVariant,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 12,
                    color: colorScheme.outlineVariant,
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      locationInfo.address ??
                          '${locationInfo.latitude.toStringAsFixed(2)}, ${locationInfo.longitude.toStringAsFixed(2)}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.outline,
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
            ),
          );
        },
      ),
    );
  }
}
