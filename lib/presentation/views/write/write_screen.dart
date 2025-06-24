import 'package:flutter/material.dart';
import 'package:moodlog/presentation/view_models/write/write_viewmodel.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key, required this.viewModel});

  final WriteViewModel viewModel;

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _contentController = TextEditingController();
  final String _moodName = 'happy';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(controller: _contentController),
            Text(_moodName),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
