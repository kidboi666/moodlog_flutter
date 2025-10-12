import 'package:moodlog/domain/entities/ai/ai_usage.dart';
import 'package:moodlog/domain/repositories/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository;

  SettingsUseCase({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  Future<AiUsage?> getAiUsage() async {
    return await _settingsRepository.getAiUsage();
  }

  Future<void> updateAiUsage(AiUsage usage) async {
    return await _settingsRepository.updateAiUsage(usage);
  }
}
