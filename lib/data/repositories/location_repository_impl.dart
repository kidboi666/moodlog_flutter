import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/location_info.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Future<Result<bool>> checkLocationPermission() async {
    try {
      final status = await Permission.location.status;
      return Result.ok(status.isGranted);
    } catch (e) {
      return Result.failure(Exception('Failed to check location permission: $e'));
    }
  }

  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      return Result.ok(status.isGranted);
    } catch (e) {
      return Result.failure(Exception('Failed to request location permission: $e'));
    }
  }

  @override
  Future<Result<LocationInfo>> getCurrentLocation() async {
    try {
      print('Checking location service...');
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return Result.failure(Exception('Location services are disabled'));
      }

      print('Checking location permission...');
      LocationPermission permission = await Geolocator.checkPermission();
      print('Current permission: $permission');
      
      if (permission == LocationPermission.denied) {
        print('Requesting location permission...');
        permission = await Geolocator.requestPermission();
        print('Permission after request: $permission');
        if (permission == LocationPermission.denied) {
          return Result.failure(Exception('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        return Result.failure(Exception('Location permissions are permanently denied'));
      }

      print('Getting current position...');

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

      return Result.ok(LocationInfo(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ));
    } catch (e) {
      return Result.failure(Exception('Failed to get current location: $e'));
    }
  }

  @override
  Future<Result<String>> getAddressFromCoordinates(double latitude, double longitude) async {
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