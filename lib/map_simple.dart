import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteTrakerApp extends StatefulWidget {
  const RouteTrakerApp({super.key});

  @override
  State<RouteTrakerApp> createState() => _RouteTrakerAppState();
}

class _RouteTrakerAppState extends State<RouteTrakerApp> {
  late CameraPosition initCameraPostion;
  @override
  void initState() {
    initCameraPostion = CameraPosition(target: LatLng(0, 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: initCameraPostion,
    );
  }
}
