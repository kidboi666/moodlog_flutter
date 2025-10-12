import 'package:flutter/material.dart';
import 'package:moodlog/core/ui/widgets/journal_card.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/presentation/tag_detail/tag_detail_view_model.dart';
import 'package:provider/provider.dart';

class TagDetailScreen extends StatelessWidget {
  final int tagId;
  const TagDetailScreen({super.key, required this.tagId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TagDetailViewModel(
        journalUseCase: context.read<JournalUseCase>(),
        tagUseCase: context.read<TagUseCase>(),
        tagId: tagId,
      ),
      child: const _TagDetailScreenContent(),
    );
  }
}

class _TagDetailScreenContent extends StatelessWidget {
  const _TagDetailScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TagDetailViewModel>();
    final journals = viewModel.journals;

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.tag?.name ?? '...'),
      ),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.hasError) {
            return Center(child: Text('Error: ${viewModel.error}'));
          }
          if (journals.isEmpty) {
            return const Center(child: Text('No journals found for this tag.'));
          }
          return ListView.builder(
            itemCount: journals.length,
            itemBuilder: (context, index) {
              final journal = journals[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: JournalCard(
                  id: journal.id,
                  content: journal.content ?? '',
                  moodType: journal.moodType,
                  createdAt: journal.createdAt,
                  tags: journal.tags,
                  coverImg: journal.imageUri?.isNotEmpty == true
                      ? journal.imageUri!.first
                      : null,
                  onTap: () {
                    // Navigate to journal detail
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
