import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../journal_viewmodel.dart';
import 'location_map_bottom_sheet.dart';

class LocationCard extends StatelessWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  const LocationCard({
    super.key,
    required this.viewModel,
    required this.currentAlign,
  });

  void _showLocationMap(BuildContext context) {
    final journal = viewModel.journal;

    if (journal == null) {
      return;
    }

    if (journal.latitude == null || journal.longitude == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationMapBottomSheet(
        latitude: journal.latitude!,
        longitude: journal.longitude!,
        address: journal.address,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final journal = viewModel.journal;

    if (journal == null) {
      return const SizedBox.shrink();
    }

    return Visibility(
      visible: journal.latitude != null && journal.longitude != null,
      child: Row(
        mainAxisAlignment: currentAlign.mainAxisAlignment,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () => _showLocationMap(context),
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: Radius.circular(12),
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
                        size: 18,
                        color: colorScheme.outlineVariant,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          journal.address ??
                              '${journal.latitude?.toStringAsFixed(2) ?? '0.00'}, ${journal.longitude?.toStringAsFixed(2) ?? '0.00'}',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.outline,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
