import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return SizedBox(
      height: 60,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: [
          if (context.watch<WriteViewModel>().imageUri.isNotEmpty)
            ...context.watch<WriteViewModel>().imageUri.map(
              (imageUri) => Card(
                elevation: 0,
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
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: InkWell(
              onTap: context.read<WriteViewModel>().pickImage,
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
