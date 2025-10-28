import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/widget.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/presentation/screens/journal/journal_view_model.dart';
import 'package:moodlog/presentation/screens/journal/widgets/content_box.dart';
import 'package:moodlog/presentation/screens/journal/widgets/dialog/delete_confirm_dialog.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:provider/provider.dart';

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
