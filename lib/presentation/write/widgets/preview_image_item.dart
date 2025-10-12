import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class PreviewImageItem extends StatelessWidget {
  final String imageUri;
  final Function(String) onTap;

  const PreviewImageItem({
    super.key,
    required this.imageUri,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          child: InkWell(
            onTap: () => onTap(imageUri),
            child: Ink.image(
              image: FileImage(File(imageUri)),
              fit: BoxFit.cover,
              width: 60,
              height: 60,
            ),
          ),
        ),
      ),
    );
  }
}
