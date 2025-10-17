import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';

class CoverImageButton extends StatelessWidget {
  final String image;

  const CoverImageButton({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(image),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
