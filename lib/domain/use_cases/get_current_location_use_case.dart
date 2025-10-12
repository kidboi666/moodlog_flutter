import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase({required LocationRepository locationRepository})
    : _locationRepository = locationRepository;

  Future<Result<LocationInfo>> call() async {
    final permissionResult = await _locationRepository
        .checkLocationPermission();

    return switch (permissionResult) {
      Ok<bool>() => await _proceedWithLocationAccess(permissionResult.value),
      Error<bool>() => Result.error(permissionResult.error),
    };
  }

  Future<Result<LocationInfo>> _proceedWithLocationAccess(
    bool hasPermission,
  ) async {
    if (hasPermission) {
      return await _locationRepository.getCurrentLocation();
    }

    final requestResult = await _locationRepository.requestLocationPermission();

    return switch (requestResult) {
      Ok<bool>() =>
        requestResult.value
            ? await _locationRepository.getCurrentLocation()
            : Result.error(Exception('Location permission denied')),
      Error<bool>() => Result.error(requestResult.error),
    };
  }
}
