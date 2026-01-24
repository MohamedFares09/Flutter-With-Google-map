import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late CameraPosition cameraPosition;
  late GoogleMapController googleMapController;
  late Location location;

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: LatLng(30.049162629627705, 31.341898108869827),
      zoom: 12,
    );
    location = Location();
    checkAndRequestLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(31.201102892124847, 29.935677445323787),
                zoom: 14,
              ),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.location_history),
      ),
    );
  }

  void checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // Todo: handle the case when service is not enabled
      }
    }
    checkAndRequestLocationPermission();
  }

  void checkAndRequestLocationPermission() async {
    var hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      hasPermission = await location.requestPermission();
      if (hasPermission != PermissionStatus.granted) {
        // Todo: handle the case when permission is not granted
      }
    }
  }

  void getLocationData() {
    location.onLocationChanged.listen((locationDate) {});
  }
  
}
