import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);
  static const String routeName = '/MyMap';

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final _initialCameraPosition = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 25.5,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GoogleMap(
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    ));
  }
}
