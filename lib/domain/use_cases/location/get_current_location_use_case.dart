import '../../../common/utils/result.dart';
import '../../entities/location_info.dart';
import '../../repositories/location_repository.dart';

class GetCurrentLocationUseCase {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase({required LocationRepository locationRepository})
    : _locationRepository = locationRepository;

  Future<Result<LocationInfo>> execute() async {
    final permissionResult = await _locationRepository
        .checkLocationPermission();

    return switch (permissionResult) {
      Ok<bool>() => await _handlePermissionGranted(permissionResult.value),
      Failure<bool>() => Result.failure(permissionResult.error),
    };
  }

  Future<Result<LocationInfo>> _handlePermissionGranted(
    bool hasPermission,
  ) async {
    if (!hasPermission) {
      final requestResult = await _locationRepository
          .requestLocationPermission();
      return switch (requestResult) {
        Ok<bool>() =>
          requestResult.value
              ? await _locationRepository.getCurrentLocation()
              : Result.failure(Exception('Location permission denied')),
        Failure<bool>() => Result.failure(requestResult.error),
      };
    }
    return await _locationRepository.getCurrentLocation();
  }
}
