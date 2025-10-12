import 'package:moodlog/domain/repositories/settings_repository.dart';

class CheckAiUsageUseCase {
  final SettingsRepository _settingsRepository;

  CheckAiUsageUseCase({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  Future<bool> call() async {
    final usage = await _settingsRepository.getAiUsage();
    final now = DateTime.now();

    if (usage == null) {
      return true;
    }

    final isSameDay =
        usage.date.year == now.year &&
        usage.date.month == now.month &&
        usage.date.day == now.day;

    if (isSameDay) {
      return usage.count < 3;
    } else {
      return true;
    }
  }
}
