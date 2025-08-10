import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../viewmodel/home_viewmodel.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final weatherInfo = viewModel.weatherInfo;
        final isLoadingWeather = viewModel.isLoadingWeather;

        if (isLoadingWeather) {
          return _buildLoadingWidget(context, colorScheme, textTheme);
        }

        if (weatherInfo == null) {
          return _buildGetWeatherButton(
            context,
            viewModel,
            colorScheme,
            textTheme,
          );
        }

        return _buildWeatherInfo(context, weatherInfo, colorScheme, textTheme);
      },
    );
  }

  Widget _buildLoadingWidget(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: Spacing.sm),
          Text(
            '날씨 정보 로딩중...',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetWeatherButton(
    BuildContext context,
    HomeViewModel viewModel,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return GestureDetector(
      onTap: () => viewModel.getCurrentWeather(),
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
    WeatherInfo weatherInfo,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final weatherRepository = context.read<WeatherRepository>();
    final condition = weatherRepository.getWeatherCondition(weatherInfo.icon);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Text(condition.icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: Spacing.sm),
          Text(
            '${weatherInfo.temperature.round()}°C',
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: Spacing.md),
          GestureDetector(
            onTap: () => context.read<HomeViewModel>().clearWeather(),
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
