import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/common.dart';
import '../../../widgets/pop_button.dart';

class CoverImage extends StatefulWidget {
  final String image;

  const CoverImage({super.key, required this.image});

  @override
  State<CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<CoverImage> {
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
      child: Container(
        margin: const EdgeInsets.only(right: Spacing.md),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - (Spacing.lg * 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(widget.image),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
