import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../journal/widgets/location_simple_bottom_sheet.dart';
import '../write_viewmodel.dart';
import 'bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'bottom_sheet/weather_info_bottom_sheet.dart';
import 'image_picker_button.dart';
import 'markdown_button_section.dart';
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
  late Map<String, bool> _currentFormattingStates;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _currentFormattingStates = {
      'bold': false,
      'italic': false,
      'underline': false,
      'strikeThrough': false,
      'link': false,
      'ul': false,
      'ol': false,
      'blockQuote': false,
    };
    WidgetsBinding.instance.addObserver(this);
    widget.quillController.addListener(_updateFormattingStates);
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
    widget.quillController.removeListener(_updateFormattingStates);
    super.dispose();
  }

  void _updateFormattingStates() {
    final controller = widget.quillController;
    final selection = controller.selection;

    if (selection.isCollapsed && selection.start > 0) {
      final style = controller.document.collectStyle(
        selection.start > 0 ? selection.start - 1 : 0,
        1,
      );

      setState(() {
        _currentFormattingStates['bold'] = style.containsKey(
          Attribute.bold.key,
        );
        _currentFormattingStates['italic'] = style.containsKey(
          Attribute.italic.key,
        );
        _currentFormattingStates['underline'] = style.containsKey(
          Attribute.underline.key,
        );
        _currentFormattingStates['strikeThrough'] = style.containsKey(
          Attribute.strikeThrough.key,
        );
        _currentFormattingStates['link'] = style.containsKey(
          Attribute.link.key,
        );
        _currentFormattingStates['ul'] = style.containsKey(Attribute.ul.key);
        _currentFormattingStates['ol'] = style.containsKey(Attribute.ol.key);
        _currentFormattingStates['blockQuote'] = style.containsKey(
          Attribute.blockQuote.key,
        );
      });
    } else {
      setState(() {
        _currentFormattingStates.updateAll((key, value) => false);
      });
    }
  }

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

  void _toggleAttribute(Attribute attribute) {
    final controller = widget.quillController;
    final selection = controller.selection;

    if (selection.isCollapsed) {
      final text = controller.document.toPlainText();
      final cursorPosition = selection.start;

      int lineStart = cursorPosition;
      int lineEnd = cursorPosition;

      while (lineStart > 0 && text[lineStart - 1] != '\n') {
        lineStart--;
      }

      while (lineEnd < text.length && text[lineEnd] != '\n') {
        lineEnd++;
      }

      if (lineStart < lineEnd) {
        final lineStyle = controller.document.collectStyle(
          lineStart,
          lineEnd - lineStart,
        );
        final isCurrentlyFormatted = lineStyle.containsKey(attribute.key);

        controller.updateSelection(
          TextSelection(baseOffset: lineStart, extentOffset: lineEnd),
          ChangeSource.local,
        );

        if (isCurrentlyFormatted) {
          controller.formatSelection(Attribute.clone(attribute, null));
        } else {
          controller.formatSelection(attribute);
        }

        controller.updateSelection(
          TextSelection.collapsed(offset: cursorPosition),
          ChangeSource.local,
        );
      }
    } else {
      final selectedLength = selection.end - selection.start;
      final selectedStyle = controller.document.collectStyle(
        selection.start,
        selectedLength,
      );
      final isCurrentlyFormatted = selectedStyle.containsKey(attribute.key);

      if (isCurrentlyFormatted) {
        controller.formatSelection(Attribute.clone(attribute, null));
      } else {
        controller.formatSelection(attribute);
      }
    }
  }

  void _insertLink() {
    _toggleAttribute(Attribute.link);
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
                MarkdownButtonSection(
                  toggleAttribute: _toggleAttribute,
                  insertLink: _insertLink,
                  currentFormattingStates: _currentFormattingStates,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
