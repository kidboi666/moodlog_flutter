import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/date_time.dart';
import '../../core/extensions/routing.dart';
import '../../core/ui/widgets/fade_in.dart';
import '../../core/ui/widgets/pop_button.dart';
import 'widgets/ai_enable_card.dart';
import 'widgets/bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'widgets/content_input.dart';
import 'widgets/editor_bottom_panel.dart';
import 'widgets/image_preview_section.dart';
import 'write_view_model.dart';

part 'write_content.dart';

class WriteScreen extends StatelessWidget {
  final DateTime date;
  final int? editJournalId;

  const WriteScreen({super.key, required this.date, this.editJournalId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteViewModel(
        geminiUseCase: context.read(),
        appStateProvider: context.read(),
        settingsUseCase: context.read(),
        aiGenerationProvider: context.read(),
        pickImageUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
        journalUseCase: context.read(),
        checkAiUsageLimitUseCase: context.read(),
        logMoodEntryUseCase: context.read(),
        tagUseCase: context.read(),
        selectedDate: date,
        editJournalId: editJournalId,
      ),
      child: _WriteScreenContent(),
    );
  }
}
