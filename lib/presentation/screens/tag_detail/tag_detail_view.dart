import 'package:flutter/material.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/core/ui/widgets/journal_card.dart';
import 'package:moodlog/domain/use_cases/journal_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/presentation/screens/tag_detail/tag_detail_view_model.dart';
import 'package:provider/provider.dart';

part 'tag_detail_content.dart';

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
