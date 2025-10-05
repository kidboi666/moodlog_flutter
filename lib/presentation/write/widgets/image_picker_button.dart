import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/widget.dart';
import '../write_view_model.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        return IconButton(
          onPressed: viewModel.pickImage,
          icon: Icon(Icons.image_outlined),
          style: IconButton.styleFrom(padding: EdgeInsets.all(8)),
        ).scale();
      },
    );
  }
}
