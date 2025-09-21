import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../constants/common.dart';
import '../../constants/enum.dart';
import '../../extensions/date_time.dart';
import '../../extensions/widget.dart';
import '../../l10n/app_localizations.dart';

class JournalCard extends StatelessWidget {
  final int id;
  final String content;
  final MoodType moodType;
  final String? coverImg;
  final DateTime createdAt;
  final void Function() onTap;
  final void Function() onDismissed;

  const JournalCard({
    super.key,
    required this.id,
    required this.content,
    required this.moodType,
    required this.createdAt,
    required this.onTap,
    required this.onDismissed,
    this.coverImg,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Roundness.card),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(Roundness.card),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xl,
            vertical: Spacing.xl,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Mood color indicator
                Container(
                  width: Spacing.sm,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Roundness.card),
                    color: Color(moodType.colorValue),
                  ),
                ),
                const SizedBox(width: Spacing.lg),

                // Content section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        createdAt.formatted(t),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      _buildContentPreview(content.trim(), textTheme),
                      if (coverImg != null && coverImg!.isNotEmpty) ...[
                        const SizedBox(height: Spacing.md),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Roundness.xs),
                          child: Image.file(
                            File(coverImg!),
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(
                                    Roundness.xs,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      color: colorScheme.outline,
                                      size: 32,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Image not found',
                                      style: TextStyle(
                                        color: colorScheme.outline,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).scale();
  }

  Widget _buildContentPreview(String content, TextTheme textTheme) {
    if (content.isEmpty) {
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
        maxHeight: 100, // 카드에서는 높이 제한
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
}
