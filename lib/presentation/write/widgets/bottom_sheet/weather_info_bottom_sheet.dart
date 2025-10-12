import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';

class WeatherInfoBottomSheet extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const WeatherInfoBottomSheet({super.key, required this.weatherInfo});

  String _getWeatherIcon(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('clear') || desc.contains('맑')) {
      return '☀️';
    } else if (desc.contains('cloud') || desc.contains('흐')) {
      return '☁️';
    } else if (desc.contains('rain') || desc.contains('비')) {
      return '🌧️';
    } else if (desc.contains('snow') || desc.contains('눈')) {
      return '❄️';
    } else if (desc.contains('thunder') || desc.contains('뇌우')) {
      return '⛈️';
    } else if (desc.contains('drizzle') || desc.contains('이슬비')) {
      return '🌦️';
    } else if (desc.contains('mist') ||
        desc.contains('fog') ||
        desc.contains('안개')) {
      return '🌫️';
    } else {
      return weatherInfo.icon.isNotEmpty ? weatherInfo.icon : '🌤️';
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
              Icon(Icons.wb_sunny, color: colorScheme.primary, size: 24),
              const SizedBox(width: Spacing.sm),
              Text(
                t.weather_current_weather,
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

          // Weather Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(Spacing.lg),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              children: [
                // Weather icon and temperature
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getWeatherIcon(weatherInfo.description),
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(width: Spacing.md),
                    Text(
                      '${weatherInfo.temperature.round()}°',
                      style: textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: Spacing.sm),

                Text(
                  weatherInfo.description,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: Spacing.lg),

                // Weather details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildWeatherDetail(
                      context,
                      Icons.water_drop,
                      t.weather_humidity,
                      '${weatherInfo.humidity}%',
                    ),
                    _buildWeatherDetail(
                      context,
                      Icons.air,
                      t.weather_wind,
                      '${weatherInfo.windSpeed.toStringAsFixed(1)} m/s',
                    ),
                    _buildWeatherDetail(
                      context,
                      Icons.compress,
                      t.weather_pressure,
                      '${weatherInfo.pressure.round()} hPa',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Bottom spacing for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.onSurfaceVariant, size: 20),
        const SizedBox(height: Spacing.xs),
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.xs),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
