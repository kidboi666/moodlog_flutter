import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';

abstract class LocationRepository {
  Future<Result<LocationInfo>> getCurrentLocation();

  Future<Result<String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  );

  Future<Result<bool>> checkLocationPermission();

  Future<Result<bool>> requestLocationPermission();
}
