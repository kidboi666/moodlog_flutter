import '../entities/location_info.dart';
import '../../core/utils/result.dart';

abstract class LocationRepository {
  Future<Result<LocationInfo>> getCurrentLocation();
  Future<Result<String>> getAddressFromCoordinates(double latitude, double longitude);
  Future<Result<bool>> checkLocationPermission();
  Future<Result<bool>> requestLocationPermission();
}