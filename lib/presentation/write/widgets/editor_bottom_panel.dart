import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/common.dart';
import '../../../common/constants/enum.dart';
import '../../journal/widgets/location_simple_bottom_sheet.dart';
import '../viewmodel/write_viewmodel.dart';
import 'bottom_sheet/mood_selection_bottom_sheet.dart';
import 'bottom_sheet/weather_info_bottom_sheet.dart';
import 'image_picker_button.dart';
import 'tag_input_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatelessWidget {
  final TextEditingController contentController;

  const EditorBottomPanel({super.key, required this.contentController});

  Future<void> _showWeatherBottomSheet(BuildContext context) async {
    final viewModel = context.read<WriteViewModel>();
    final weatherInfo = viewModel.weatherInfo;

    if (weatherInfo == null) {
      // 날씨 정보가 없으면 먼저 가져오기
      await viewModel.getCurrentWeather();
      final newWeatherInfo = viewModel.weatherInfo;
      if (newWeatherInfo == null) return;

      if (context.mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              WeatherInfoBottomSheet(weatherInfo: newWeatherInfo),
        );
      }
    } else {
      if (context.mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              WeatherInfoBottomSheet(weatherInfo: weatherInfo),
        );
      }
    }
  }

  Future<void> _showLocationBottomSheet(BuildContext context) async {
    final viewModel = context.read<WriteViewModel>();
    final locationInfo = viewModel.locationInfo;

    if (locationInfo == null) {
      // 위치 정보가 없으면 먼저 가져오기
      await viewModel.getCurrentLocation();
      final newLocationInfo = viewModel.locationInfo;
      if (newLocationInfo == null) return;

      if (context.mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => LocationSimpleBottomSheet(
            latitude: newLocationInfo.latitude,
            longitude: newLocationInfo.longitude,
            address: newLocationInfo.address,
          ),
        );
      }
    } else {
      if (context.mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => LocationSimpleBottomSheet(
            latitude: locationInfo.latitude,
            longitude: locationInfo.longitude,
            address: locationInfo.address,
          ),
        );
      }
    }
  }

  Future<void> _showMoodSelectionBottomSheet(BuildContext context) async {
    final viewModel = context.read<WriteViewModel>();
    final selectedMood = await showModalBottomSheet<MoodType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => ChangeNotifierProvider.value(
        value: viewModel,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(bottomSheetContext).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: const MoodSelectionBottomSheet(),
        ),
      ),
    );

    if (selectedMood != null && context.mounted) {
      viewModel.updateMoodType(selectedMood);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          boxShadow: keyboardHeight > 0
              ? [
                  BoxShadow(
                    color: colorScheme.shadow.withValues(alpha: 0.6),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: Spacing.containerHorizontalPadding,
          child: Row(
            children: [
              IconButton(
                onPressed: () => _showWeatherBottomSheet(context),
                icon: const Icon(Icons.wb_sunny_outlined),
              ),
              IconButton(
                onPressed: () => _showLocationBottomSheet(context),
                icon: const Icon(Icons.location_on_outlined),
              ),
              IconButton(
                onPressed: () => _showMoodSelectionBottomSheet(context),
                icon: const Icon(Icons.mood_outlined),
              ),
              const ImagePickerButton(),
              const TagInputButton(),
              TimestampButton(contentController: contentController),
            ],
          ),
        ),
      ),
    );
  }
}
