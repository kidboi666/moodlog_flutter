import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/domain/entities/journal/activity.dart';
import 'package:moodlog/domain/use_cases/activity_use_case.dart';
import 'package:moodlog/presentation/screens/activities/activities_view_model.dart';
import 'package:provider/provider.dart';

part 'activities_content.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivitiesViewModel(context.read<ActivityUseCase>()),
      child: const _TagsScreenContent(),
    );
  }
}
