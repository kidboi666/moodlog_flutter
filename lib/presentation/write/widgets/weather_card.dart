import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../viewmodel/write_viewmodel.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.read<WriteViewModel>();
    final weatherInfo = context.select<WriteViewModel, WeatherInfo?>(
      (vm) => vm.weatherInfo,
    );
    final isLoadingWeather = context.select<WriteViewModel, bool>(
      (vm) => vm.isLoadingWeather,
    );

    if (isLoadingWeather) {
      return _buildLoadingCard(context, colorScheme, textTheme);
    }

    if (weatherInfo == null) {
      return const SizedBox.shrink();
    }

    final weatherRepository = context.read<WeatherRepository>();
    final condition = weatherRepository.getWeatherCondition(weatherInfo.icon);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: GestureDetector(
        onTap: () => viewModel.clearWeather(),
        child: Row(
          children: [
            Text(condition.icon, style: textTheme.titleLarge),
            const SizedBox(width: Spacing.sm),

            // Weather Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${weatherInfo.temperature.round()}°C',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: Spacing.xs),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard(
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
        ],
      ),
    );
  }
}
