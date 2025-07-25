import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimestampButton extends StatelessWidget {
  final TextEditingController contentController;
  
  const TimestampButton({
    super.key,
    required this.contentController,
  });

  void _insertTimestamp() {
    final now = DateTime.now();
    final timestamp = DateFormat('HH:mm').format(now);
    final text = contentController.text;
    final selection = contentController.selection;

    final newText = text.replaceRange(
      selection.start,
      selection.end,
      '$timestamp ',
    );

    contentController.text = newText;
    contentController.selection = TextSelection.collapsed(
      offset: selection.start + timestamp.length + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _insertTimestamp,
      icon: Icon(Icons.access_time, size: 20),
      style: IconButton.styleFrom(
        padding: EdgeInsets.all(8),
      ),
    );
  }
}