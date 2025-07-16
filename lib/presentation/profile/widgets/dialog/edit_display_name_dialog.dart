import 'package:flutter/material.dart';

class EditDisplayNameDialog extends StatefulWidget {
  final String? initialName;

  const EditDisplayNameDialog({super.key, this.initialName});

  @override
  State<EditDisplayNameDialog> createState() => EditDisplayNameDialogState();
}

class EditDisplayNameDialogState extends State<EditDisplayNameDialog> {
  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
    _controller.addListener(_validateInput);
    _validateInput();
  }

  void _validateInput() {
    setState(() {
      _isValid = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('닉네임 변경'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: '새 닉네임을 입력하세요',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('취소')),
        TextButton(
          onPressed: _isValid
              ? () => Navigator.pop(context, _controller.text.trim())
              : null,
          child: Text('확인'),
        ),
      ],
    );
  }
}
