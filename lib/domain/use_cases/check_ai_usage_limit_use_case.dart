import '../../core/utils/result.dart';
import '../repositories/settings_repository.dart';

class CheckAiUsageLimitUseCase {
  final SettingsRepository _settingsRepository;

  CheckAiUsageLimitUseCase({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository;

  Future<Result<bool>> call() async {
    try {
      final lastUsageDate = await _settingsRepository.getLastAiUsageDate();
      final now = DateTime.now();

      if (lastUsageDate == null) {
        return Result.ok(true);
      }

      final isSameDay =
          lastUsageDate.year == now.year &&
          lastUsageDate.month == now.month &&
          lastUsageDate.day == now.day;

      return Result.ok(!isSameDay);
    } catch (e) {
      return Result.error(Exception('Failed to check AI usage limit: $e'));
    }
  }
}
