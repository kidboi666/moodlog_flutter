import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/presentation/screens/write/widgets/preview_image_item.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';

class ImagePreviewSection extends StatelessWidget {
  final Function(String) onTap;
  final List<String> selectedImageList;

  const ImagePreviewSection({
    super.key,
    required this.onTap,
    required this.selectedImageList,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: DurationMS.quick,
      curve: Curves.easeInOutCubicEmphasized,
      height: selectedImageList.isNotEmpty ? 60 : 0,
      child: SizedBox(
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: selectedImageList
              .map(
                (imageUri) => FadeIn(
                  child: PreviewImageItem(imageUri: imageUri, onTap: onTap),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
