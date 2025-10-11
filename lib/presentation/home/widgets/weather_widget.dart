import 'package:flutter/material.dart';
import 'package:moodlog/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/ui/widgets/spinner.dart';


class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isLoading = context.select((HomeViewModel vm) => vm.isLoading);
    final weatherInfo = context.select((HomeViewModel vm) => vm.weatherInfo);

    return Row(
      children: [
        if (isLoading)
          const Spinner()
        else
          ..._buildWeatherWidget(
            colorScheme,
            textTheme,
            context
                .read<HomeViewModel>()
                .getWeatherCondition(weatherInfo?.icon)
                .icon,
            weatherInfo?.temperature ?? 0,
            context.read<HomeViewModel>().clearWeather,
          ),
      ],
    );
  }

  List<Widget> _buildWeatherWidget(
    ColorScheme colorScheme,
    TextTheme textTheme,
    String conditionIcon,
    double temperature,
    VoidCallback clearWeather,
  ) {
    return [
      Text(conditionIcon, style: const TextStyle(fontSize: 24)),
      const SizedBox(width: Spacing.sm),
      Text(
        '${temperature.round()}°C',
        style: textTheme.headlineMedium?.copyWith(color: colorScheme.onSurface),
      ),
      const SizedBox(width: Spacing.md),
      IconButton(
        onPressed: () => clearWeather(),
        icon: Icon(
          Icons.refresh,
          color: colorScheme.secondary.withValues(alpha: 0.6),
        ),
      ),
    ];
  }
}
