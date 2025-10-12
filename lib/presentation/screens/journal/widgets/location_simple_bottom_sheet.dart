import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSimpleBottomSheet extends StatelessWidget {
  final LocationInfo locationInfo;

  const LocationSimpleBottomSheet({super.key, required this.locationInfo});

  Future<void> _openInGoogleMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${locationInfo.latitude},${locationInfo.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(bottom: Spacing.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Row(
            children: [
              Icon(Icons.location_on, color: colorScheme.primary, size: 24),
              const SizedBox(width: Spacing.sm),
              Text(
                t.location_journal_location,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          const SizedBox(height: Spacing.lg),

          // Address Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      t.location_address,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  locationInfo.address ?? t.location_no_address,
                  style: textTheme.bodyLarge,
                ),
                if (locationInfo.address != null) ...[
                  const SizedBox(height: Spacing.sm),
                  Row(
                    children: [
                      Icon(
                        Icons.my_location,
                        color: colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      const SizedBox(width: Spacing.xs),
                      Text(
                        t.location_coordinates,
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    '${locationInfo.latitude.toStringAsFixed(6)}, ${locationInfo.longitude.toStringAsFixed(6)}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: Spacing.lg),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _openInGoogleMaps,
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(t.location_open_in_google_maps),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
                  ),
                ),
              ),
            ],
          ),

          // Bottom spacing for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
