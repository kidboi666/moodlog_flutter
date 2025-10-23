import 'package:moodlog/domain/entities/ai/ai_usage.dart';
import 'package:moodlog/domain/entities/app/settings.dart';
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

  Future<bool> hasPin() async {
    return await _settingsRepository.hasPin();
  }

  Future<void> savePin(String pin) async {
    return await _settingsRepository.savePin(pin);
  }

  Future<bool> verifyPin(String pin) async {
    return await _settingsRepository.verifyPin(pin);
  }

  Future<Settings> loadSettings() async {
    return await _settingsRepository.loadSettings();
  }

  Future<Settings> updateSettings(Settings settings) async {
    return await _settingsRepository.updateSettings(settings);
  }

  Future<void> deletePin() async {
    return await _settingsRepository.deletePin();
  }

  void clearSharedPreferences() {
    _settingsRepository.clearSharedPreferences();
  }
}
