import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../domain/entities/journal/location_info.dart';
import '../../../domain/entities/journal/weather_info.dart';
import '../../journal/widgets/location_simple_bottom_sheet.dart';
import '../write_view_model.dart';
import 'bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'bottom_sheet/weather_info_bottom_sheet.dart';
import 'image_picker_button.dart';
import 'tag_input_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatefulWidget {
  final QuillController quillController;

  const EditorBottomPanel({super.key, required this.quillController});

  @override
  State<EditorBottomPanel> createState() => _EditorBottomPanelState();
}

class _EditorBottomPanelState extends State<EditorBottomPanel>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = View.of(context).viewInsets.bottom;
    final keyboardVisible = bottomInset > 0;
    if (keyboardVisible != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = keyboardVisible;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _showWeatherBottomSheet() async {
    final viewModel = context.read<WriteViewModel>();
    WeatherInfo? weatherInfo = viewModel.weatherInfo;

    if (weatherInfo == null) {
      await viewModel.getCurrentWeather();
      weatherInfo = viewModel.weatherInfo;
    }

    if (mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => WeatherInfoBottomSheet(weatherInfo: weatherInfo!),
      );
    }
  }

  Future<void> _showLocationBottomSheet() async {
    final viewModel = context.read<WriteViewModel>();
    LocationInfo? locationInfo = viewModel.locationInfo;

    if (locationInfo == null) {
      await viewModel.getCurrentLocation();
      locationInfo = viewModel.locationInfo;
    }

    if (mounted) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            LocationSimpleBottomSheet(locationInfo: locationInfo!),
      );
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
    final selectedMood = context.select<WriteViewModel, MoodType>(
      (vm) => vm.selectedMood,
    );

    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isKeyboardVisible ? colorScheme.surfaceContainer : null,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.containerHorizontalPadding.horizontal / 2,
              vertical: Spacing.xs,
            ),
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
                  icon: Icon(
                    Icons.mood_outlined,
                    color: Color(selectedMood.colorValue),
                  ),
                ),
                const ImagePickerButton(),
                const TagInputButton(),
                TimestampButton(quillController: widget.quillController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
