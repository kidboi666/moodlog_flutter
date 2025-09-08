import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/ui/widgets/spinner.dart';
import '../../../domain/entities/weather_info.dart';
import '../base_layout_viewmodel.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final weatherInfo = context.select<BaseLayoutViewModel, WeatherInfo?>(
      (vm) => vm.weatherInfo,
    );
    final getWeatherCondition = context
        .read<BaseLayoutViewModel>()
        .getWeatherCondition;
    final isLoadingWeather = context.select<BaseLayoutViewModel, bool>(
      (vm) => vm.isLoadingWeather,
    );
    if (isLoadingWeather) {
      return Spinner(spinnerType: SpinnerType.button);
    }

    if (weatherInfo == null) {
      return _buildGetWeatherButton(context, colorScheme, textTheme);
    }

    return _buildWeatherInfo(
      context,
      weatherInfo.temperature.round(),
      getWeatherCondition(weatherInfo.icon),
      colorScheme,
      textTheme,
    );
  }

  Widget _buildGetWeatherButton(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final getCurrentWeather = context
        .read<BaseLayoutViewModel>()
        .getCurrentWeather;
    return GestureDetector(
      onTap: getCurrentWeather,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
        child: Row(
          children: [
            Icon(Icons.wb_sunny_outlined, color: colorScheme.primary, size: 20),
            const SizedBox(width: Spacing.sm),
            Text(
              '날씨 정보 새로고침',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
    BuildContext context,
    int temperature,
    WeatherCondition condition,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Text(condition.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: Spacing.sm),
          Text(
            '${temperature.round()}°C',
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: Spacing.md),
          GestureDetector(
            onTap: () => context.read<BaseLayoutViewModel>().clearWeather(),
            child: Icon(
              Icons.refresh,
              color: colorScheme.secondary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
