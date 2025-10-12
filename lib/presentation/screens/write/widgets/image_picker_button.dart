import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/presentation/screens/write/write_view_model.dart';
import 'package:provider/provider.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<WriteViewModel>().pickImage(),
      icon: Icon(Icons.image_outlined),
      style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
    ).scale();
  }
}
