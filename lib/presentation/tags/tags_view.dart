import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/routing/routes.dart';
import '../../domain/entities/journal/tag.dart';
import '../../domain/use_cases/tag_use_case.dart';
import 'tags_view_model.dart';

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
