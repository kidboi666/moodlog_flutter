import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/presentation/screens/tags/tags_view_model.dart';
import 'package:provider/provider.dart';

part 'tags_content.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TagsViewModel(context.read<TagUseCase>()),
      child: const _TagsScreenContent(),
    );
  }
}
