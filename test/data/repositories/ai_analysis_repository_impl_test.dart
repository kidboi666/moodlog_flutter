import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/data/repositories/ai_analysis_repository_impl.dart';
import 'package:moodlog/domain/entities/ai_analysis_report.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/exceptions/not_enough_data_exception.dart';
import 'package:moodlog/domain/repositories/gemini_repository.dart';
import 'package:moodlog/domain/repositories/journal_repository.dart';

// Mocks
class MockJournalRepository extends Mock implements JournalRepository {}

class MockGeminiRepository extends Mock implements GeminiRepository {}

void main() {
  late AiAnalysisRepositoryImpl aiAnalysisRepository;
  late MockJournalRepository mockJournalRepository;
  late MockGeminiRepository mockGeminiRepository;

  setUpAll(() {
    registerFallbackValue(MoodType.happy); // Register a fallback for MoodType
  });

  setUp(() {
    mockJournalRepository = MockJournalRepository();
    mockGeminiRepository = MockGeminiRepository();
    aiAnalysisRepository = AiAnalysisRepositoryImpl(
      journalRepository: mockJournalRepository,
      geminiRepository: mockGeminiRepository,
    );
  });

  final testJournals = List.generate(
    15,
    (index) => Journal(
      id: index,
      moodType: MoodType.happy,
      entryType: EntryType.fullJournal,
      createdAt: DateTime.now().subtract(Duration(days: index)),
      aiResponseEnabled: false,
      content: 'Test journal content $index',
    ),
  );

  group('AiAnalysisRepositoryImpl', () {
    test('should return report when there is enough data', () async {
      // Arrange
      final aiResponse = {
        "summary": "Summary text",
        "positiveKeywords": ["positive"],
        "negativeKeywords": ["negative"],
        "emotionalPattern": "Pattern text",
        "tagCorrelation": "Correlation text",
      };
      when(
        () => mockJournalRepository.getJournals(),
      ).thenAnswer((_) async => Result.ok(testJournals));
      when(
        () => mockGeminiRepository.generateResponse(
          prompt: any(named: 'prompt'),
          moodType: any(named: 'moodType'),
        ),
      ).thenAnswer((_) async => Result.ok(jsonEncode(aiResponse)));

      // Act
      final result = await aiAnalysisRepository.getAnalysisReport();

      // Assert
      expect(result, isA<AiAnalysisReport>());
      expect(result.summary, "Summary text");
      expect(result.positiveKeywords, ["positive"]);
    });

    test(
      'should throw NotEnoughDataException when journals are less than 10',
      () async {
        // Arrange
        final notEnoughJournals = testJournals.sublist(0, 5);
        when(
          () => mockJournalRepository.getJournals(),
        ).thenAnswer((_) async => Result.ok(notEnoughJournals));

        // Act & Assert
        expect(
          () => aiAnalysisRepository.getAnalysisReport(),
          throwsA(isA<NotEnoughDataException>()),
        );
      },
    );

    test('should throw exception when journal repository fails', () async {
      // Arrange
      when(
        () => mockJournalRepository.getJournals(),
      ).thenAnswer((_) async => Result.error(Exception('DB Error')));

      // Act & Assert
      expect(
        () => aiAnalysisRepository.getAnalysisReport(),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when gemini repository fails', () async {
      // Arrange
      when(
        () => mockJournalRepository.getJournals(),
      ).thenAnswer((_) async => Result.ok(testJournals));
      when(
        () => mockGeminiRepository.generateResponse(
          prompt: any(named: 'prompt'),
          moodType: any(named: 'moodType'),
        ),
      ).thenAnswer((_) async => Result.error(Exception('AI Error')));

      // Act & Assert
      expect(
        () => aiAnalysisRepository.getAnalysisReport(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
