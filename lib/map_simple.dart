import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  CameraPosition? cameraPosition;
  late GoogleMapController googleMapController;
  late LocationService locationService;

  Set<Marker> markers = {};

  @override
  void initState() {
    cameraPosition = CameraPosition(
      target: LatLng(30.049162629627705, 31.341898108869827),
      zoom: 12,
    );
    locationService = LocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition!,
        onMapCreated: (controller) {
          googleMapController = controller;
          updataMyLocation();
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

  void updataMyLocation() async {
    locationService.checkAndRequestLocationService();
    var hasPermision = await locationService
        .checkAndRequestLocationPermission();
    if (hasPermision) {
      locationService.getRealTimeLocationData((locationDate) {
        LatLng latlong = LatLng(
          locationDate.latitude!,
          locationDate.longitude!,
        );
        setMyLocationMarker(latlong);
        setMyCameraPosition(latlong);
      });
    }
  }

  void setMyCameraPosition(LatLng latlong) {
     var cameraPosition = CameraPosition(target: latlong, zoom: 14);
    
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void setMyLocationMarker(LatLng latlong) {
         var myMarker = Marker(
      markerId: MarkerId('My Marker'),
      position: latlong,
    );
    markers.add(myMarker);
    setState(() {});
  }
}
