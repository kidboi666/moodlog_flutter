import '../entities/journal/journal.dart';
import '../entities/journal/tag.dart';

extension JournalExtension on Journal {
  Journal attachTags(List<Tag> tags) {
    return Journal(
      id: id,
      content: content,
      moodType: moodType,
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
    );
  }
}
