import 'dart:io';

import 'package:flutter/material.dart';

import 'pop_button.dart';

class ImageScreenWithButton extends StatefulWidget {
  final String image;
  final Widget button;

  const ImageScreenWithButton({
    super.key,
    required this.image,
    required this.button,
  });

  @override
  State<ImageScreenWithButton> createState() => _ImageScreenWithButtonState();
}

class _ImageScreenWithButtonState extends State<ImageScreenWithButton> {
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
              child: Center(child: Image.file(File(widget.image))),
            ),
          ),
        ),
      ),
      child: widget.button,
    );
  }
}
