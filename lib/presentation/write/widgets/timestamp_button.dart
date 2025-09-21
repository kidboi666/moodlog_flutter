import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/widget.dart';

class TimestampButton extends StatelessWidget {
  final QuillController quillController;

  const TimestampButton({super.key, required this.quillController});

  void _insertTimestamp() {
    final now = DateTime.now();
    final timestamp = DateFormat('HH:mm').format(now);
    final selection = quillController.selection;

    quillController.document.insert(selection.start, '$timestamp ');
    quillController.updateSelection(
      TextSelection.collapsed(offset: selection.start + timestamp.length + 1),
      ChangeSource.local,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _insertTimestamp,
      icon: Icon(Icons.access_time),
      style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
    ).scale();
  }
}
