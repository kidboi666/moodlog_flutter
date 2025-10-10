import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/date_time.dart';
import '../../core/extensions/widget.dart';
import '../../core/routing/routes.dart';
import '../../core/ui/widgets/fade_in.dart';
import '../../core/ui/widgets/pop_button.dart';
import 'journal_view_model.dart';
import 'widgets/ai_response_box.dart';
import 'widgets/content_box.dart';
import 'widgets/dialog/delete_confirm_dialog.dart';
import 'widgets/mood_bar.dart';

part 'journal_content.dart';

class JournalScreen extends StatelessWidget {
  final JournalSource source;
  final int id;

  const JournalScreen({super.key, required this.source, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => JournalViewModel(
            journalUseCase: context.read(),
            aiGenerationProvider: context.read(),
            appStateProvider: context.read(),
            source: source,
            id: id,
          ),
        ),
      ],
      child: _JournalScreenContent(),
    );
  }
}
