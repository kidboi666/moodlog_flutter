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
import 'tag_input_button.dart';
import 'timestamp_button.dart';

class EditorBottomPanel extends StatefulWidget {
  final QuillController quillController;

  const EditorBottomPanel({super.key, required this.quillController});

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

  void _toggleAttribute(Attribute attribute) {
    final controller = widget.quillController;
    final selection = controller.selection;

    if (selection.isCollapsed) {
      // 선택된 텍스트가 없을 때 현재 라인에서 작동
      final text = controller.document.toPlainText();
      final cursorPosition = selection.start;

      // 현재 커서 위치에서 라인의 시작과 끝을 찾기
      int lineStart = cursorPosition;
      int lineEnd = cursorPosition;

      // 라인 시작 찾기
      while (lineStart > 0 && text[lineStart - 1] != '\n') {
        lineStart--;
      }

      // 라인 끝 찾기
      while (lineEnd < text.length && text[lineEnd] != '\n') {
        lineEnd++;
      }

      // 라인에 텍스트가 있는 경우에만 처리
      if (lineStart < lineEnd) {
        // 라인 전체 선택
        controller.updateSelection(
          TextSelection(baseOffset: lineStart, extentOffset: lineEnd),
          ChangeSource.local,
        );

        // 포맷팅 토글 적용
        controller.formatSelection(attribute);

        // 커서를 원래 위치로 복원
        controller.updateSelection(
          TextSelection.collapsed(offset: cursorPosition),
          ChangeSource.local,
        );
      }
    } else {
      // 선택된 텍스트가 있을 때는 선택된 부분만 토글
      controller.formatSelection(attribute);
    }
  }

  void _insertLink() {
    final controller = widget.quillController;
    final selection = controller.selection;

    if (selection.isCollapsed) {
      // 선택된 텍스트가 없을 때 현재 라인에서 작동
      final text = controller.document.toPlainText();
      final cursorPosition = selection.start;

      // 현재 커서 위치에서 라인의 시작과 끝을 찾기
      int lineStart = cursorPosition;
      int lineEnd = cursorPosition;

      // 라인 시작 찾기
      while (lineStart > 0 && text[lineStart - 1] != '\n') {
        lineStart--;
      }

      // 라인 끝 찾기
      while (lineEnd < text.length && text[lineEnd] != '\n') {
        lineEnd++;
      }

      // 라인에 텍스트가 있는 경우에만 처리
      if (lineStart < lineEnd) {
        // 라인 전체 선택
        controller.updateSelection(
          TextSelection(baseOffset: lineStart, extentOffset: lineEnd),
          ChangeSource.local,
        );

        // 링크 포맷팅 토글 적용
        controller.formatSelection(Attribute.link);

        // 커서를 원래 위치로 복원
        controller.updateSelection(
          TextSelection.collapsed(offset: cursorPosition),
          ChangeSource.local,
        );
      }
    } else {
      // 선택된 텍스트가 있을 때는 선택된 부분만 토글
      controller.formatSelection(Attribute.link);
    }
  }

  Widget _buildMarkdownButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(onPressed: onPressed, icon: Icon(icon), iconSize: 20);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selectedMood = context.select<WriteViewModel, MoodType>(
      (vm) => vm.selectedMood,
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: colorScheme.surfaceContainerLowest),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                  icon: Icon(
                    Icons.mood_outlined,
                    color: Color(selectedMood.colorValue),
                  ),
                ),
                const ImagePickerButton(),
                const TagInputButton(),
                TimestampButton(quillController: widget.quillController),
                // Markdown formatting buttons
                _buildMarkdownButton(
                  icon: Icons.format_bold,
                  onPressed: () => _toggleAttribute(Attribute.bold),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_italic,
                  onPressed: () => _toggleAttribute(Attribute.italic),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_underlined,
                  onPressed: () => _toggleAttribute(Attribute.underline),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_strikethrough,
                  onPressed: () => _toggleAttribute(Attribute.strikeThrough),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_list_bulleted,
                  onPressed: () => _toggleAttribute(Attribute.ul),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_list_numbered,
                  onPressed: () => _toggleAttribute(Attribute.ol),
                ),
                _buildMarkdownButton(
                  icon: Icons.format_quote,
                  onPressed: () => _toggleAttribute(Attribute.blockQuote),
                ),
                _buildMarkdownButton(icon: Icons.link, onPressed: _insertLink),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
