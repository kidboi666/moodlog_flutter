import 'package:flutter/material.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/extensions/date_time.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../presentation/widgets/pop_button.dart';
import '../../../view_models/journal/journal_viewmodel.dart';
import '../widgets/cover_image.dart';

class JournalScreen extends StatefulWidget {
  final JournalViewModel viewModel;

  const JournalScreen({super.key, required this.viewModel});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: PopButton(
              onTap: () => widget.viewModel.handleBackNavigation(context),
            ),
            title: Text(
              widget.viewModel.journal.createdAt.formatted(
                AppLocalizations.of(context)!,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: [
              IconButton(
                onPressed: widget.viewModel.changeAlign,
                icon: Icon(widget.viewModel.currentAlign.icon),
              ),
              IconButton(
                onPressed: () => widget.viewModel.handleDelete(context),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: ListView(
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MoodBar(moodType: widget.viewModel.journal.moodType),
                    _ContentBox(
                      viewModel: widget.viewModel,
                      currentAlign: widget.viewModel.currentAlign,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MoodBar extends StatelessWidget {
  final MoodType moodType;

  const _MoodBar({required this.moodType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Color(moodType.colorValue),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
    );
  }
}

class _ContentBox extends StatelessWidget {
  final JournalViewModel viewModel;
  final SimpleTextAlign currentAlign;

  _ContentBox({required this.viewModel, required this.currentAlign});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isVisibleImage = viewModel.journal.imageUri?.isNotEmpty ?? false;
    return Expanded(
      child: Column(
        spacing: 20,
        children: [
          SizedBox(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: viewModel.journal.moodType.name,
                style: Theme.of(context).textTheme.titleLarge,
                children: [TextSpan(text: viewModel.journal.moodType.emoji)],
              ),
            ),
          ),
          Offstage(
            offstage: !isVisibleImage,
            child: SizedBox(
              height: MediaQuery.of(context).size.width - 32,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: [
                  ...viewModel.journal.imageUri?.map(
                        (image) => CoverImage(image: image),
                      ) ??
                      [],
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                viewModel.journal.content ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: currentAlign.textAlign,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
