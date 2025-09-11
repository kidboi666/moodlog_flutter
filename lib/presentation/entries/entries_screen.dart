import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/extensions/date_time.dart';
import '../../core/extensions/routing.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/ui/widgets/empty_entries_box.dart';
import '../../core/ui/widgets/fade_in.dart';
import '../../core/ui/widgets/glower.dart';
import '../../core/ui/widgets/journal_card.dart';
import '../../domain/entities/journal/journal.dart';
import 'entries_viewmodel.dart';
import 'widgets/entries_calendar_view.dart';
import 'widgets/tag_filter_section.dart';

part 'entries_screen_content.dart';

class EntriesScreen extends StatelessWidget {
  const EntriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EntriesViewModel(
        observeJournalListUseCase: context.read(),
        journalUseCase: context.read(),
        tagUseCase: context.read(),
      ),
      child: _EntriesScreenContent(),
    );
  }
}
