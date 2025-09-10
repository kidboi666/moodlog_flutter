import 'package:flutter_test/flutter_test.dart';
import 'package:moodlog/core/constants/enum.dart';
import 'package:moodlog/domain/entities/journal/journal.dart';

void main() {
  group('Journal', () {
    test('Journal 생성자 테스트', () {
      final now = DateTime.now();
      final journal = Journal(
        id: 1,
        content: '오늘의 일기 내용',
        moodType: MoodType.happy,
        imageUri: ['image1.jpg', 'image2.jpg'],
        createdAt: now,
        aiResponseEnabled: true,
        aiResponse: 'AI 응답 내용',
        latitude: 37.7749,
        longitude: -122.4194,
        address: '서울시 강남구 역삼동',
        temperature: 25.5,
        weatherIcon: 'sunny',
        weatherDescription: '맑음',
      );

      expect(journal.id, 1);
      expect(journal.content, '오늘의 일기 내용');
      expect(journal.moodType, MoodType.happy);
      expect(journal.imageUri, ['image1.jpg', 'image2.jpg']);
    });
  });
}
