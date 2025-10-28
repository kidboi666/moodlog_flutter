import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
import 'package:moodlog/presentation/screens/journal/widgets/location_map_bottom_sheet.dart';
import 'package:provider/provider.dart';

class HeroMoodBanner extends StatelessWidget {
  final CheckIn checkIn;

  const HeroMoodBanner({super.key, required this.checkIn});

  @override
  Widget build(BuildContext context) {
    final moodType = checkIn.moodType;
    final moodColor = Color(moodType.colorValue);
    final hasWeather =
        checkIn.temperature != null && checkIn.weatherIcon != null;
    final hasLocation =
        checkIn.address != null ||
        (checkIn.latitude != null && checkIn.longitude != null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildMoodInfo(context, moodType, moodColor),
              if (hasWeather) ...[
                CommonSizedBox.widthMd,
                _buildWeatherInfo(context),
              ],
            ],
          ),
          if (hasLocation) ...[
            CommonSizedBox.heightSm,
            _buildLocationCard(context),
          ],
        ],
      ),
    );
  }

  String _getMoodDisplayName(BuildContext context, MoodType moodType) {
    final t = AppLocalizations.of(context)!;
    switch (moodType) {
      case MoodType.veryHappy:
        return t.common_mood_verygood;
      case MoodType.happy:
        return t.common_mood_good;
      case MoodType.neutral:
        return t.common_mood_neutral;
      case MoodType.sad:
        return t.common_mood_bad;
      case MoodType.verySad:
        return t.common_mood_verybad;
    }
  }

  Widget _buildMoodInfo(
    BuildContext context,
    MoodType moodType,
    Color moodColor,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(moodType.emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: Spacing.sm),
        Text(
          _getMoodDisplayName(context, moodType),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: moodColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo(BuildContext context) {
    final weatherUseCase = context.read<WeatherUseCase>();
    final condition = weatherUseCase.getWeatherCondition(checkIn.weatherIcon!);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(condition.icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(width: 4),
        Text(
          '${checkIn.temperature!.round()}°C',
          style: textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    if (checkIn.latitude == null || checkIn.longitude == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => LocationMapBottomSheet(
        latitude: checkIn.latitude!,
        longitude: checkIn.longitude!,
        address: checkIn.address,
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showLocationBottomSheet(context),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(20),
          dashPattern: const [10, 5],
          strokeWidth: 2,
          color: colorScheme.outlineVariant,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 18, color: colorScheme.outline),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  checkIn.address ??
                      '${checkIn.latitude!.toStringAsFixed(2)}, ${checkIn.longitude!.toStringAsFixed(2)}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.outline,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
