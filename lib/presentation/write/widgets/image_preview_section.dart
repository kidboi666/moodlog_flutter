import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../write_viewmodel.dart';

class ImagePreviewSection extends StatefulWidget {
  const ImagePreviewSection({super.key});

  @override
  State<ImagePreviewSection> createState() => _ImagePreviewSectionState();
}

class _ImagePreviewSectionState extends State<ImagePreviewSection> {
  late ScrollController _scrollController;
  final Map<String, Image> _imageCache = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        if (viewModel.imageUri.isEmpty) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 60,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: viewModel.imageUri
                .map(
                  (imageUri) => Card(
                    elevation: 0,
                    margin: Spacing.imagePickerBoxInnerPadding,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: _buildOptimizedImage(imageUri)
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildOptimizedImage(String imageUri) {
    if (!_imageCache.containsKey(imageUri)) {
      _imageCache[imageUri] = Image.file(
        File(imageUri),
        fit: BoxFit.cover,
        width: 60,
      );
    }
    return _imageCache[imageUri]!;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
