import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/weather_info.dart';
import '../../../domain/repositories/weather_repository.dart';
import '../../../domain/use_cases/weather/get_current_weather_use_case.dart';

class MoodWeatherBar extends StatefulWidget {
  final MoodType moodType;
  final double? latitude;
  final double? longitude;

  const MoodWeatherBar({
    super.key,
    required this.moodType,
    this.latitude,
    this.longitude,
  });

  @override
  State<MoodWeatherBar> createState() => _MoodWeatherBarState();
}

class _MoodWeatherBarState extends State<MoodWeatherBar> {
  WeatherInfo? _weatherInfo;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // initState에서 context.read를 사용하면 안되므로 didChangeDependencies에서 로드
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_weatherInfo == null && !_isLoading) {
      _loadWeather();
    }
  }

  Future<void> _loadWeather() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    // 기본 위치는 서울
    double latitude = widget.latitude ?? 37.5665;
    double longitude = widget.longitude ?? 126.9780;

    try {
      final weatherUseCase = context.read<GetCurrentWeatherUseCase>();
      final result = await weatherUseCase.execute(
        latitude: latitude,
        longitude: longitude,
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
            _isLoading = false;
          });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 4,
      decoration: BoxDecoration(
        color: Color(widget.moodType.colorValue),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 감정 표시 (첫 번째 줄)
            Row(
              children: [
                Text(
                  widget.moodType.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: Spacing.xs),
                Expanded(
                  child: Text(
                    widget.moodType.displayName,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            // 날씨 정보 (두 번째 줄)
            if (_isLoading || _weatherInfo != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  if (_isLoading)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '날씨 로딩중...',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    )
                  else if (_weatherInfo != null) ...[
                    Expanded(
                      child: _buildWeatherInfo(colorScheme, textTheme),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: _loadWeather,
                      child: Icon(
                        Icons.refresh,
                        size: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(ColorScheme colorScheme, TextTheme textTheme) {
    final weatherRepository = context.read<WeatherRepository>();
    final condition = weatherRepository.getWeatherCondition(_weatherInfo!.icon);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(condition.icon, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        Text(
          '${_weatherInfo!.temperature.round()}°C',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            _weatherInfo!.description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
