import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/view/route_tracker_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RouteTrakerApp(),
    );
  }
}

// Location Service
// required permissions
// get Location
// display Location
