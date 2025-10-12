import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:moodlog/core/utils/result.dart';
import 'package:moodlog/domain/entities/journal/location_info.dart';
import 'package:moodlog/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Result<bool>> checkLocationPermission() async {
    try {
      final permission = await Geolocator.checkPermission();
      return Result.ok(
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always,
      );
    } catch (e) {
      return Result.error(Exception('Failed to check location permission: $e'));
    }
  }

  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      final permission = await Geolocator.requestPermission();
      return Result.ok(
        permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always,
      );
    } catch (e) {
      return Result.error(
        Exception('Failed to request location permission: $e'),
      );
    }
  }

  @override
  Future<Result<LocationInfo>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Result.error(Exception('Location services are disabled'));
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Result.error(Exception('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Result.error(
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
        Error<String>() => null,
      };

      return Result.ok(
        LocationInfo(
          latitude: position.latitude,
          longitude: position.longitude,
          address: address,
        ),
      );
    } catch (e) {
      return Result.error(Exception('Failed to get current location: $e'));
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
      return Result.error(Exception('No address found'));
    } catch (e) {
      return Result.error(Exception('Failed to get address: $e'));
    }
  }
}
