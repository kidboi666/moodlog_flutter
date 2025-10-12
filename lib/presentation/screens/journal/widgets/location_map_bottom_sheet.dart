import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationMapBottomSheet extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationMapBottomSheet({
    super.key,
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  State<LocationMapBottomSheet> createState() => _LocationMapBottomSheetState();
}

class _LocationMapBottomSheetState extends State<LocationMapBottomSheet> {
  String get _staticMapUrl {
    const apiKey = 'AIzaSyCyU0_xtUCwWi4SDlCvjcILAHIexlAWVKE'; // API 키
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=${widget.latitude},${widget.longitude}&'
        'zoom=16&'
        'size=640x400&'
        'scale=2&'
        'markers=color:red|${widget.latitude},${widget.longitude}&'
        'key=$apiKey';
  }

  Future<void> _openInGoogleMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${widget.latitude},${widget.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                Icon(Icons.location_on, color: colorScheme.primary, size: 20),
                const SizedBox(width: Spacing.sm),
                Text(
                  AppLocalizations.of(context)!.location_journal_location,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  iconSize: 20,
                ),
              ],
            ),
          ),

          // Map
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: Spacing.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: GestureDetector(
                onTap: _openInGoogleMaps,
                child: Stack(
                  children: [
                    // Static Map Image
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        _staticMapUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: colorScheme.surfaceContainer,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map_outlined,
                                    size: 48,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(height: Spacing.sm),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.location_map_load_error,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.outline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Click overlay indicator
                    Positioned(
                      top: Spacing.sm,
                      right: Spacing.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.xs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.open_in_new,
                              size: 12,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.location_tap_to_open,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Address Info
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
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
                      const SizedBox(width: Spacing.sm),
                      Text(
                        AppLocalizations.of(context)!.location_address,
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.xs),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(Spacing.sm),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.address ??
                          '${widget.latitude.toStringAsFixed(6)}, ${widget.longitude.toStringAsFixed(6)}',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
