import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../../../core/constants/enum.dart';
import '../../../core/extensions/localization.dart';
import '../../../core/ui/widgets/tag_section.dart';
import '../../../domain/entities/journal/journal.dart';
import '../../../domain/use_cases/weather_use_case.dart';
import '../journal_view_model.dart';
import 'journal_cover_image.dart';
import 'location_card.dart';

class ContentBox extends StatefulWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  const ContentBox({
    super.key,
    required this.viewModel,
    required this.currentAlign,
  });

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  bool get _hasWeatherData {
    final journal = widget.viewModel.journal;
    if (journal == null) return false;

    return journal.temperature != null &&
        journal.weatherIcon != null &&
        journal.weatherDescription != null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final journal = widget.viewModel.journal;

    if (journal == null) {
      return const SizedBox.shrink();
    }

    final isVisibleImage = journal.imageUri?.isNotEmpty ?? false;

    return Expanded(
      child: Column(
        spacing: Spacing.xl,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              spacing: Spacing.sm,
              children: [
                Row(
                  mainAxisAlignment: widget.currentAlign.mainAxisAlignment,
                  children: [
                    Text(
                      journal.moodType.getDisplayName(context),
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(journal.moodType.emoji, style: textTheme.titleLarge),
                    if (_hasWeatherData) ...[
                      const SizedBox(width: Spacing.md),
                      _buildWeatherInfo(context, textTheme, journal),
                    ],
                  ],
                ),
                LocationCard(
                  viewModel: widget.viewModel,
                  currentAlign: widget.currentAlign,
                ),
              ],
            ),
          ),
          JournalCoverImage(
            viewModel: widget.viewModel,
            isVisibleImage: isVisibleImage,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: Spacing.md),
              child: Column(
                crossAxisAlignment: widget.currentAlign.crossAxisAlignment,
                children: [
                  _buildContentDisplay(journal.content, textTheme),
                  if (journal.tags != null && journal.tags!.isNotEmpty) ...[
                    const SizedBox(height: Spacing.lg),
                    TagSection(
                      tags: journal.tags!,
                      textAlign: widget.currentAlign,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentDisplay(String? content, TextTheme textTheme) {
    if (content == null || content.isEmpty) {
      return const SizedBox.shrink();
    }

    final controller = QuillController.basic();

    // 마크다운 텍스트를 QuillDocument로 변환
    try {
      final document = _parseMarkdownToDocument(content);
      controller.document = document;
    } catch (e) {
      // 파싱 실패 시 일반 텍스트로 표시
      controller.document = Document()..insert(0, content);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: double.infinity,
      ),
      child: IgnorePointer(child: QuillEditor.basic(controller: controller)),
    );
  }

  Document _parseMarkdownToDocument(String content) {
    final document = Document();

    // 마크다운 패턴을 순서대로 처리
    final patterns = [
      {'pattern': r'\*\*(.*?)\*\*', 'attribute': Attribute.bold},
      {'pattern': r'__(.*?)__', 'attribute': Attribute.underline},
      {'pattern': r'~~(.*?)~~', 'attribute': Attribute.strikeThrough},
      {'pattern': r'(?<!\*)\*([^*]+?)\*(?!\*)', 'attribute': Attribute.italic},
    ];

    String processedContent = content;
    final List<Map<String, dynamic>> formatRanges = [];

    // 각 패턴에 대해 매치 찾기
    for (final patternData in patterns) {
      final pattern = patternData['pattern'] as String;
      final attribute = patternData['attribute'] as Attribute;
      final regex = RegExp(pattern);

      final matches = regex.allMatches(processedContent).toList();

      // 역순으로 처리하여 인덱스 변화 방지
      for (final match in matches.reversed) {
        final matchText = match.group(1) ?? '';
        final start = match.start;
        final end = match.end;

        // 포맷 정보 저장
        formatRanges.add({
          'start': start,
          'length': matchText.length,
          'attribute': attribute,
        });

        // 마크다운 마커 제거하고 텍스트만 남기기
        processedContent =
            processedContent.substring(0, start) +
            matchText +
            processedContent.substring(end);
      }
    }

    // 텍스트 삽입
    document.insert(0, processedContent);

    // 포맷 적용 (시작 위치 기준으로 정렬)
    formatRanges.sort((a, b) => a['start'].compareTo(b['start']));

    int offset = 0;
    for (final range in formatRanges) {
      final start = range['start'] as int;
      final length = range['length'] as int;
      final attribute = range['attribute'] as Attribute;

      document.format(start - offset, length, attribute);

      // 제거된 마커 길이만큼 오프셋 조정
      offset += _getMarkerLength(attribute) * 2; // 시작/끝 마커
    }

    return document;
  }

  int _getMarkerLength(Attribute attribute) {
    if (attribute == Attribute.bold) return 2; // **
    if (attribute == Attribute.underline) return 2; // __
    if (attribute == Attribute.strikeThrough) return 2; // ~~
    if (attribute == Attribute.italic) return 1; // *
    return 0;
  }

  Widget _buildWeatherInfo(
    BuildContext context,
    TextTheme textTheme,
    Journal journal,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final weatherUseCase = context.read<WeatherUseCase>();
    final condition = weatherUseCase.getWeatherCondition(journal.weatherIcon!);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(condition.icon, style: textTheme.titleMedium),
        const SizedBox(width: Spacing.xs),
        Text(
          '${journal.temperature!.round()}°C',
          style: textTheme.titleMedium?.copyWith(color: colorScheme.secondary),
        ),
      ],
    );
  }
}
