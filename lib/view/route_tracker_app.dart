import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteTrakerApp extends StatefulWidget {
  const RouteTrakerApp({super.key});

  @override
  State<RouteTrakerApp> createState() => _RouteTrakerAppState();
}

class _RouteTrakerAppState extends State<RouteTrakerApp> {
  late CameraPosition initCameraPostion;
  late LocationService locationService;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    initCameraPostion = CameraPosition(target: LatLng(0, 0));
    locationService = LocationService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      zoomControlsEnabled: false,
      initialCameraPosition: initCameraPostion,
      onMapCreated: (controller) {
        googleMapController = controller;
        getCurrentLocation();
      },
    );
  }

  void getCurrentLocation() async {
    try {
      var locationData = await locationService.getLocation();
      var currentPostion = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      Marker currentMarker = Marker(
        markerId: MarkerId("marker id"),
        position: currentPostion,
      );
      markers.add(currentMarker);
      setState(() {});
      CameraPosition cameraPosition = CameraPosition(
        target: currentPostion,
        zoom: 15,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    } on LocationServerException catch (e) {
      // TODO
    } on LocationPermesstionException catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }
}

// create text field 
// listen to the text field 
// search place 
// display result 
