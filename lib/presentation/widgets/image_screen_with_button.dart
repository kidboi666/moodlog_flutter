import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/extensions/string.dart';
import 'pop_button.dart';

class ImageScreenWithButton extends StatelessWidget {
  final String image;
  final Widget button;

  const ImageScreenWithButton({
    super.key,
    required this.image,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          barrierDismissible: true,
          builder: (context) => Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              leading: PopButton(),
              backgroundColor: Colors.transparent,
            ),
            body: InteractiveViewer(
              child: Center(
                child: image.isNetworkImage()
                    ? Image.network(image)
                    : Image.file(File(image)),
              ),
            ),
          ),
        ),
      ),
      child: button,
    );
  }
}
