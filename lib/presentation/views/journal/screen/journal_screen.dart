import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/presentation/views/journal/widgets/delete_confirm.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:moodlog/router/routes.dart';

import '../../../view_models/journal/journal_viewmodel.dart';
import '../widgets/cover_image.dart';

class JournalScreen extends StatefulWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _dialogBuilder(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) =>
          DeleteConfirm(viewModel: widget.viewModel, id: widget.viewModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopButton(
          onTap: widget.viewModel.source == 'write'
              ? () => context.replace(Routes.home)
              : null,
        ),
        actions: [
          IconButton(
            onPressed: () => _dialogBuilder(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          return ListView(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 8,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width - 32,
                            child: ListView(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...widget.viewModel.journal?.imageUri?.map(
                                      (image) => CoverImage(image: image),
                                    ) ??
                                    [],
                              ],
                            ),
                          ),
                          Text(widget.viewModel.journal?.content ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
