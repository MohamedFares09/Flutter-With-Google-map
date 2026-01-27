import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteTrakerApp extends StatefulWidget {
  const RouteTrakerApp({super.key});

  @override
  State<RouteTrakerApp> createState() => _RouteTrakerAppState();
}

class _RouteTrakerAppState extends State<RouteTrakerApp> {
  late CameraPosition initCameraPostion;
  late LocationService locationService;
  @override
  void initState() {
    initCameraPostion = CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initCameraPostion,
    );
  }

  void getCurrentLocation() async {
    try {
      var currentLocation = await locationService.getLocation();
    } on LocationServerException catch (e) {
      // TODO
    } on LocationPermesstionException catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }
}
