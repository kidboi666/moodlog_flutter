import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/utils/result.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../../../domain/use_cases/weather/get_current_weather_use_case.dart';

class JournalWeatherWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final String? address;

  const JournalWeatherWidget({
    super.key,
    this.latitude,
    this.longitude,
    this.address,
  });

  @override
  State<JournalWeatherWidget> createState() => _JournalWeatherWidgetState();
}

class _JournalWeatherWidgetState extends State<JournalWeatherWidget> {
  WeatherInfo? _weatherInfo;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      _loadWeather();
    }
  }

  Future<void> _loadWeather() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final weatherUseCase = context.read<GetCurrentWeatherUseCase>();
      final result = await weatherUseCase.execute(
        latitude: widget.latitude!,
        longitude: widget.longitude!,
      );

      if (!mounted) return;

      switch (result) {
        case Ok<WeatherInfo>():
          setState(() {
            _weatherInfo = result.value;
            _isLoading = false;
          });
        case Failure<WeatherInfo>():
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_isLoading) {
      return _buildLoadingWidget(colorScheme, textTheme);
    }

    if (_hasError || _weatherInfo == null) {
      return _buildErrorWidget(colorScheme, textTheme);
    }

    return _buildWeatherInfo(colorScheme, textTheme);
  }

  Widget _buildLoadingWidget(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.md),
      padding: const EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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

  Widget _buildErrorWidget(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.md),
      padding: const EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_off, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: Spacing.sm),
          Text(
            '날씨 정보 불러오기 실패',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: Spacing.xs),
          GestureDetector(
            onTap: _loadWeather,
            child: Icon(Icons.refresh, size: 14, color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(ColorScheme colorScheme, TextTheme textTheme) {
    final weatherRepository = context.read<WeatherRepository>();
    final condition = weatherRepository.getWeatherCondition(_weatherInfo!.icon);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.md),
      padding: const EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(condition.icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: Spacing.xs),
          Text(
            '${_weatherInfo!.temperature.round()}°C',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: Spacing.xs),
          Text(
            _weatherInfo!.description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (widget.address != null) ...[
            const SizedBox(width: Spacing.xs),
            Icon(
              Icons.location_on_outlined,
              size: 12,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 2),
            Flexible(
              child: Text(
                widget.address!,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
