import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../core/l10n/app_localizations.dart';

class ContentInput extends StatefulWidget {
  final QuillController quillController;
  final FocusNode? focusNode;

  const ContentInput({
    super.key,
    required this.quillController,
    this.focusNode,
  });

  @override
  State<ContentInput> createState() => _ContentInputState();
}

class _ContentInputState extends State<ContentInput> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.write_input_title,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: KeyboardListener(
                focusNode: FocusNode(),
                onKeyEvent: _handleKeyEvent,
                child: QuillEditor.basic(
                  controller: widget.quillController,
                  focusNode: widget.focusNode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
      // 엔터 키가 눌렸을 때 현재 포맷팅 초기화
      _clearCurrentFormatting();
    }
  }

  void _clearCurrentFormatting() {
    // 엔터 후 새 줄에서 포맷팅이 계속되는 것을 방지
    Future.delayed(const Duration(milliseconds: 10), () {
      if (mounted) {
        final controller = widget.quillController;

        try {
          final selection = controller.selection;
          final cursorPosition = selection.start;

          // 새 줄이 생성된 후 해당 위치에 임시 텍스트 삽입 후 삭제하여 스타일 초기화
          if (cursorPosition > 0) {
            // 임시 공백 문자 삽입
            controller.document.insert(cursorPosition, ' ');

            // 방금 삽입한 공백 문자를 즉시 삭제 (이렇게 하면 해당 위치의 스타일이 초기화됨)
            controller.document.delete(cursorPosition, 1);

            // 커서 위치 복원
            controller.updateSelection(
              TextSelection.collapsed(offset: cursorPosition),
              ChangeSource.local,
            );
          }
        } catch (e) {
          // 에러 발생 시 무시
        }
      }
    });
  }
}
