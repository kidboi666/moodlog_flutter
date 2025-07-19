import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/common.dart';
import '../viewmodel/write_viewmodel.dart';

class ImagePickingSection extends StatefulWidget {
  const ImagePickingSection({super.key});

  @override
  State<ImagePickingSection> createState() => _ImagePickingSectionState();
}

class _ImagePickingSectionState extends State<ImagePickingSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<WriteViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
          height: 60,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              if (viewModel.imageUri.isNotEmpty)
                ...viewModel.imageUri.map(
                  (imageUri) => Card(
                    elevation: 0,
                    margin: Spacing.imagePickerBoxInnerPadding,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(imageUri),
                        fit: BoxFit.cover,
                        width: 60,
                      ),
                    ),
                  ),
                ),
              Card(
                elevation: 0,
                color: colorScheme.surfaceContainer,
                margin: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: InkWell(
                  onTap: viewModel.pickImage,
                  borderRadius: BorderRadius.circular(12.0),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.image_outlined,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
