import 'package:moodlog/domain/entities/journal/journal.dart';
import 'package:moodlog/domain/entities/journal/tag.dart';

extension JournalExtension on Journal {
  Journal attachTags(List<Tag> tags) {
    return Journal(
      id: id,
      content: content,
      note: note,
      moodType: moodType,
      entryType: entryType,
      imageUri: imageUri,
      aiResponseEnabled: aiResponseEnabled,
      aiResponse: aiResponse,
      createdAt: createdAt,
      latitude: latitude,
      longitude: longitude,
      address: address,
      temperature: temperature,
      tags: tags,
      weatherIcon: weatherIcon,
      weatherDescription: weatherDescription,
      tagNames: tagNames,
      emotions: emotions,
    );
  }
}
