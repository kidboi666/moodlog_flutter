import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/use_cases/get_current_location_use_case.dart';
import 'package:moodlog/domain/use_cases/weather_use_case.dart';
import 'package:moodlog/presentation/screens/quick_check_in/quick_check_in_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:provider/provider.dart';

class WeatherDateTimePage extends StatefulWidget {
  final void Function() onBack;

  const WeatherDateTimePage({
    super.key,
    required this.onBack,
  });

  @override
  State<WeatherDateTimePage> createState() => _WeatherDateTimePageState();
}

class _WeatherDateTimePageState extends State<WeatherDateTimePage> {
  double? _latitude;
  double? _longitude;
  String? _address;
  double? _temperature;
  String? _weatherIcon;
  String? _weatherDescription;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    setState(() => _isLoading = true);

    try {
      final locationUseCase = context.read<GetCurrentLocationUseCase>();
      final weatherUseCase = context.read<WeatherUseCase>();

      final locationResult = await locationUseCase.call();

      switch (locationResult) {
        case Ok<LocationInfo>():
          final location = locationResult.value;
          _latitude = location.latitude;
          _longitude = location.longitude;
          _address = location.address;

          final weatherResult = await weatherUseCase.getCurrentWeather(
            latitude: location.latitude,
            longitude: location.longitude,
          );

          switch (weatherResult) {
            case Ok():
              final weather = weatherResult.value;
              if (mounted) {
                setState(() {
                  _temperature = weather.temperature;
                  _weatherIcon = weather.icon;
                  _weatherDescription = weather.description;
                  _isLoading = false;
                });
              }
            case Error():
              if (mounted) {
                setState(() => _isLoading = false);
              }
          }
        case Error<LocationInfo>():
          if (mounted) {
            setState(() => _isLoading = false);
          }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _submitCheckIn() async {
    final viewModel = context.read<QuickCheckInViewModel>();
    final t = AppLocalizations.of(context)!;

    final success = await viewModel.submitCheckIn(
      latitude: _latitude,
      longitude: _longitude,
      address: _address,
      temperature: _temperature,
      weatherIcon: _weatherIcon,
      weatherDescription: _weatherDescription,
    );

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.quick_check_in_success)),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.quick_check_in_error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;
    final viewModel = context.watch<QuickCheckInViewModel>();

    final dateTime = viewModel.createdAt;
    final formattedDate = DateFormat.yMMMd().format(dateTime);
    final formattedTime = DateFormat.Hm().format(dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            child: Text(
              t.quick_check_in_weather_question,
              style: textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.xl * 2),
          FadeIn(
            delay: DelayMS.medium,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.md),
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 48,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: Spacing.md),
                    Text(
                      formattedDate,
                      style: textTheme.titleLarge,
                    ),
                    Text(
                      formattedTime,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),
          if (_isLoading)
            FadeIn(
              delay: DelayMS.medium * 2,
              child: const CircularProgressIndicator(),
            )
          else if (_temperature != null && _weatherDescription != null)
            FadeIn(
              delay: DelayMS.medium * 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Column(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        size: 48,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: Spacing.md),
                      Text(
                        '${_temperature!.toStringAsFixed(1)}°C',
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        _weatherDescription!,
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const Spacer(),
          FadeIn(
            delay: DelayMS.medium * 3,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onBack,
                    child: Text(t.quick_check_in_previous),
                  ).scale(),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: FilledButton(
                    onPressed: viewModel.isLoading ? null : _submitCheckIn,
                    child: viewModel.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(t.quick_check_in_submit),
                  ).scale(),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xl),
        ],
      ),
    );
  }
}
