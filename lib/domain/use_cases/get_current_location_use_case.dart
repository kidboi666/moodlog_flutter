import '../../core/utils/result.dart';
import '../entities/journal/location_info.dart';
import '../repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase({required LocationRepository locationRepository})
    : _locationRepository = locationRepository;

  Future<Result<LocationInfo>> call() async {
    final permissionResult = await _locationRepository
        .checkLocationPermission();

    return switch (permissionResult) {
      Ok<bool>() => await _proceedWithLocationAccess(permissionResult.value),
      Failure<bool>() => Result.failure(permissionResult.error),
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
            : Result.failure(Exception('Location permission denied')),
      Failure<bool>() => Result.failure(requestResult.error),
    };
  }
}
