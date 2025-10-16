import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/entities/journal/weather_info.dart';
import 'package:moodlog/presentation/screens/journal/widgets/location_simple_bottom_sheet.dart';
import 'package:moodlog/presentation/screens/write/widgets/bottom_sheet/weather_info_bottom_sheet.dart';
import 'package:moodlog/presentation/screens/write/widgets/image_picker_button.dart';
import 'package:moodlog/presentation/screens/write/widgets/timestamp_button.dart';
import 'package:moodlog/presentation/screens/write/write_view_model.dart';
import 'package:provider/provider.dart';

class EditorBottomPanel extends StatefulWidget {
  final TextEditingController textEditingController;

  const EditorBottomPanel({super.key, required this.textEditingController});

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                const ImagePickerButton(),
                TimestampButton(
                  textEditingController: widget.textEditingController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
