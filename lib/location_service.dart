import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServerException();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.deniedForever) {
      throw LocationPermesstionException();
    }
    if (hasPermission == PermissionStatus.denied) {
      hasPermission = await location.requestPermission();
      if (hasPermission != PermissionStatus.granted) {
        throw LocationPermesstionException();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}

class LocationServerException implements Exception {}

class LocationPermesstionException implements Exception {}
