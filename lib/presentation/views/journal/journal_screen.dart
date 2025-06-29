import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:moodlog/router/routes.dart';

import '../../view_models/journal/journal_viewmodel.dart';

class JournalScreen extends StatefulWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopButton(
          onTap: widget.viewModel.source == 'write'
              ? () => context.replace(Routes.home)
              : null,
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          return Column(
            children: [
              ListView(
                controller: _scrollController,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    widget.viewModel.journal?.imageUri
                        ?.map(
                          (image) => Image.file(File(image), fit: BoxFit.cover),
                        )
                        .toList() ??
                    [],
              ),
              Text(widget.viewModel.journal?.content ?? ''),
            ],
          );
        },
      ),
    );
  }
}
