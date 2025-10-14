import 'package:flutter/material.dart';
import 'package:moodlog/core/constants/common.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/extensions/date_time.dart';
import 'package:moodlog/core/extensions/routing.dart';
import 'package:moodlog/presentation/screens/write/widgets/ai_enable_card.dart';
import 'package:moodlog/presentation/screens/write/widgets/bottom_sheet/mood_slider_selection_bottom_sheet.dart';
import 'package:moodlog/presentation/screens/write/widgets/content_input.dart';
import 'package:moodlog/presentation/screens/write/widgets/editor_bottom_panel.dart';
import 'package:moodlog/presentation/screens/write/widgets/image_preview_section.dart';
import 'package:moodlog/presentation/screens/write/write_view_model.dart';
import 'package:moodlog/presentation/widgets/fade_in.dart';
import 'package:moodlog/presentation/widgets/pop_button.dart';
import 'package:provider/provider.dart';

part 'write_content.dart';

class WriteScreen extends StatelessWidget {
  final DateTime date;
  final int? editJournalId;

  const WriteScreen({super.key, required this.date, this.editJournalId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteViewModel(
        writeJournalUseCase: context.read(),
        journalUseCase: context.read(),
        getCurrentLocationUseCase: context.read(),
        weatherUseCase: context.read(),
        tagUseCase: context.read(),
        aiGenerationProvider: context.read(),
        selectedDate: date,
        editJournalId: editJournalId,
      ),
      child: _WriteScreenContent(),
    );
  }
}
