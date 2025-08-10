import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/common.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/date_time.dart';
import '../../core/extensions/routing.dart';
import '../ui/widgets/fade_in.dart';
import '../ui/widgets/pop_button.dart';
import 'widgets/ai_enable_card.dart';
import 'widgets/bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'widgets/content_input.dart';
import 'widgets/editor_bottom_panel.dart';
import 'widgets/image_preview_section.dart';
import 'write_viewmodel.dart';

part 'write_screen_content.dart';

class WriteScreen extends StatelessWidget {
  final DateTime date;
  final int? editJournalId;
  const WriteScreen({super.key, required this.date, this.editJournalId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteViewModel(
        geminiRepository: context.read(),
        appStateProvider: context.read(),
        settingsRepository: context.read(),
        aiGenerationRepository: context.read(),
        pickImageUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        getCurrentWeatherUseCase: context.read(),
        addJournalUseCase: context.read(),
        updateJournalUseCase: context.read(),
        checkAiUsageLimitUseCase: context.read(),
        addTagUseCase: context.read(),
        getAllTagsUseCase: context.read(),
        updateJournalTagsUseCase: context.read(),
        journalRepository: context.read(),
        selectedDate: date,
        editJournalId: editJournalId,
      ),
      child: _WriteScreenContent(),
    );
  }
}
