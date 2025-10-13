import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/screens/home/home_view_model.dart';
import 'package:moodlog/presentation/widgets/spinner.dart';
import 'package:provider/provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((HomeViewModel vm) => vm.isLoading);
    final weatherInfo = context.select((HomeViewModel vm) => vm.weatherInfo);

    return Row(
      children: [
        if (isLoading)
          const Spinner()
        else
          ..._buildWeatherWidget(
            context,
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
    BuildContext context,
    String conditionIcon,
    double temperature,
    VoidCallback clearWeather,
  ) {
    return [
      Text(conditionIcon, style: const TextStyle(fontSize: 24)),
      const SizedBox(width: Spacing.sm),
      Text(
        '${temperature.round()}°C',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      const SizedBox(width: Spacing.md),
      IconButton(
        onPressed: () => clearWeather(),
        icon: Icon(
          Icons.refresh,
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6),
        ),
      ),
    ];
  }
}
