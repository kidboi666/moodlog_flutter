import 'dart:io';

import 'package:flutter/material.dart';

import '../../../view_models/write/write_viewmodel.dart';

class ImagePickingSection extends StatelessWidget {
  final WriteViewModel viewModel;

  ImagePickingSection({super.key, required this.viewModel});
 
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          if (viewModel.imageUri.isNotEmpty)
            ...viewModel.imageUri.map(
              (imageUri) => Card(
                elevation: 1,
                margin: const EdgeInsets.only(right: 8.0),
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
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
