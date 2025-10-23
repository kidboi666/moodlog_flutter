import 'package:flutter/foundation.dart';
import 'package:moodlog/core/mixins/async_state_mixin.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/check_in.dart';
import 'package:moodlog/domain/use_cases/check_in_use_case.dart';

class CheckInViewModel extends ChangeNotifier with AsyncStateMixin {
  final CheckInUseCase _checkInUseCase;
  final int id;

  CheckInViewModel({
    required CheckInUseCase checkInUseCase,
    required this.id,
  }) : _checkInUseCase = checkInUseCase {
    _load();
  }

  CheckIn? _checkIn;

  CheckIn? get checkIn => _checkIn;

  Future<void> reload() async {
    await _load();
  }

  Future<Result<void>> delete() async {
    setLoading();
    final result = await _checkInUseCase.deleteCheckIn(id);
    switch (result) {
      case Ok<void>():
        debugPrint('Deleted CheckIn $id');
        setSuccess();
        return Result.ok(null);
      case Error<void>():
        debugPrint('Failed to delete CheckIn: ${result.error}');
        setError(result.error);
        return Result.error(result.error);
    }
  }

  Future<Result<void>> _load() async {
    setLoading();
    final result = await _checkInUseCase.getCheckInById(id);
    switch (result) {
      case Ok<CheckIn?>():
        if (result.value == null) {
          final error = Exception('CheckIn not found');
          debugPrint('CheckIn with id $id not found');
          setError(error);
          return Result.error(error);
        }
        _checkIn = result.value;
        debugPrint('Loaded CheckIn ${result.value!.id}');
        setSuccess();
        return Result.ok(null);
      case Error<CheckIn?>():
        debugPrint(
          'Failed to load CheckIn. Error: ${result.error}, Type: ${result.error.runtimeType}',
        );
        setError(result.error);
        return Result.error(result.error);
    }
  }
}
