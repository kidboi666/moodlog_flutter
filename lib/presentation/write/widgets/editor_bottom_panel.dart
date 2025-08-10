import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../journal/widgets/location_simple_bottom_sheet.dart';
import '../write_viewmodel.dart';
import 'bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'bottom_sheet/weather_info_bottom_sheet.dart';
import 'image_picker_button.dart';
import 'tag_input_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatefulWidget {
  final TextEditingController contentController;

  const EditorBottomPanel({super.key, required this.contentController});

  @override
  State<EditorBottomPanel> createState() => _EditorBottomPanelState();
}

class _EditorBottomPanelState extends State<EditorBottomPanel> {
  Future<void> _showWeatherBottomSheet() async {
    final viewModel = context.read<WriteViewModel>();
    final weatherInfo = viewModel.weatherInfo;

    if (weatherInfo == null) {
      await viewModel.getCurrentWeather();
      final newWeatherInfo = viewModel.weatherInfo;
      if (newWeatherInfo == null) return;

      if (mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              WeatherInfoBottomSheet(weatherInfo: newWeatherInfo),
        );
      }
    }
  }

  Future<void> _showLocationBottomSheet() async {
    final viewModel = context.read<WriteViewModel>();
    final locationInfo = viewModel.locationInfo;

    if (locationInfo == null) {
      await viewModel.getCurrentLocation();
      final newLocationInfo = viewModel.locationInfo;
      if (newLocationInfo == null) return;

      if (mounted) {
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
    }
  }

  Future<void> _showMoodSelectionBottomSheet() async {
    showModalBottomSheet<MoodType>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => ChangeNotifierProvider.value(
        value: context.read<WriteViewModel>(),
        builder: (context, child) {
          return MoodSliderSelectionBottomSheet();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: colorScheme.surfaceContainerLowest),
        child: Padding(
          padding: Spacing.containerHorizontalPadding,
          child: Row(
            children: [
              IconButton(
                onPressed: () => _showWeatherBottomSheet(),
                icon: const Icon(Icons.wb_sunny_outlined),
              ),
              IconButton(
                onPressed: () => _showLocationBottomSheet(),
                icon: const Icon(Icons.location_on_outlined),
              ),
              IconButton(
                onPressed: () => _showMoodSelectionBottomSheet(),
                icon: const Icon(Icons.mood_outlined),
              ),
              const ImagePickerButton(),
              const TagInputButton(),
              TimestampButton(contentController: widget.contentController),
            ],
          ),
        ),
      ),
    );
  }
}
