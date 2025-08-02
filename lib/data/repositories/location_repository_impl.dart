import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/utils/result.dart';
import '../../domain/entities/location_info.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Result<bool>> checkLocationPermission() async {
    try {
      final status = await Permission.location.status;
      return Result.ok(status.isGranted);
    } catch (e) {
      return Result.failure(
        Exception('Failed to check location permission: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      return Result.ok(status.isGranted);
    } catch (e) {
      return Result.failure(
        Exception('Failed to request location permission: $e'),
      );
    }
  }

  @override
  Future<Result<LocationInfo>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Result.failure(Exception('Location services are disabled'));
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Result.failure(Exception('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Result.failure(
          Exception('Location permissions are permanently denied'),
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final addressResult = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final address = switch (addressResult) {
        Ok<String>() => addressResult.value,
        Failure<String>() => null,
      };

      return Result.ok(
        LocationInfo(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address,
        ),
      );
    } catch (e) {
      return Result.failure(Exception('Failed to get current location: $e'));
    }
  }

  @override
  Future<Result<String>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final address = [
          placemark.street,
          placemark.subLocality,
          placemark.locality,
          placemark.administrativeArea,
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        return Result.ok(address.isNotEmpty ? address : 'Unknown location');
      }
      return Result.failure(Exception('No address found'));
    } catch (e) {
      return Result.failure(Exception('Failed to get address: $e'));
    }
  }
}
