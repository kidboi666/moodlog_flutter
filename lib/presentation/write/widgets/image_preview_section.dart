import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../write_viewmodel.dart';

class ImagePreviewSection extends StatefulWidget {
  final Function onTap;

  const ImagePreviewSection({super.key, required this.onTap});

  @override
  State<ImagePreviewSection> createState() => _ImagePreviewSectionState();
}

class _ImagePreviewSectionState extends State<ImagePreviewSection> {
  late ScrollController _scrollController;

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
                .map((imageUri) => _buildPreviewImage(imageUri, widget.onTap))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildPreviewImage(String imageUri, Function onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: Spacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          child: InkWell(
            onTap: () => onTap(),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
