import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/data_source/local/emotion_local_data_source.dart';
import 'package:moodlog/domain/models/create_journal_request.dart';
import 'package:moodlog/domain/models/create_quick_check_in_request.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';
import 'package:moodlog/domain/use_cases/emotion_use_case.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';

class CreateQuickCheckInUseCase {
  final JournalRepository _journalRepository;
  final TagUseCase _tagUseCase;
  final EmotionUseCase _emotionUseCase;
  final EmotionLocalDataSource _emotionDataSource;

  CreateQuickCheckInUseCase({
    required JournalRepository journalRepository,
    required TagUseCase tagUseCase,
    required EmotionUseCase emotionUseCase,
    required EmotionLocalDataSource emotionDataSource,
  })  : _journalRepository = journalRepository,
        _tagUseCase = tagUseCase,
        _emotionUseCase = emotionUseCase,
        _emotionDataSource = emotionDataSource;

  Future<Result<int>> createQuickCheckIn(CreateQuickCheckInRequest request) async {
    final createJournalRequest = CreateJournalRequest(
      moodType: request.moodType,
      entryType: EntryType.quickCheckIn,
      content: request.content,
      tagNames: request.tagNames,
      aiResponseEnabled: false,
      createdAt: request.createdAt,
      latitude: request.latitude,
      longitude: request.longitude,
      address: request.address,
      temperature: request.temperature,
      weatherIcon: request.weatherIcon,
      weatherDescription: request.weatherDescription,
    );

    final result = await _journalRepository.createJournal(createJournalRequest);

    switch (result) {
      case Ok<Map<String, dynamic>>():
        final journalId = result.value['id'] as int;

        if (request.tagNames != null && request.tagNames!.isNotEmpty) {
          for (final tagName in request.tagNames!) {
            await _tagUseCase.addTag(tagName, null);
          }
        }

        if (request.emotionNames != null && request.emotionNames!.isNotEmpty) {
          for (final emotionName in request.emotionNames!) {
            final emotion = await _emotionUseCase.createEmotion(emotionName);
            await _emotionDataSource.createJournalEmotion(journalId, emotion.id);
          }
        }

        return Result.ok(journalId);

      case Error<Map<String, dynamic>>():
        return Result.error(result.error);
    }
  }
}
