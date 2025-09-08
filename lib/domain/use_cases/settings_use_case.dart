import '../repositories/settings_repository.dart';

class SettingsUseCase {
  final SettingsRepository _settingsRepository;

  SettingsUseCase({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  Future<DateTime?> getLastAiUsageDate() async {
    return await _settingsRepository.getLastAiUsageDate();
  }

  Future<void> updateLastAiUsageDate(DateTime date) async {
    return await _settingsRepository.updateLastAiUsageDate(date);
  }
}
