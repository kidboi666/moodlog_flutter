import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../core/extensions/widget.dart';

class TimestampButton extends StatelessWidget {
  final TextEditingController textEditingController;

  const TimestampButton({super.key, required this.textEditingController});

  void _insertTimestamp() {
    final now = DateTime.now();
    final timestamp = DateFormat('HH:mm').format(now);
    final text = '$timestamp ';
    final currentText = textEditingController.text;
    final selection = textEditingController.selection;

    final newText = currentText.replaceRange(selection.start, selection.end, text);
    textEditingController.value = textEditingController.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selection.start + text.length),
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
