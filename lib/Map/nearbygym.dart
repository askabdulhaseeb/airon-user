import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NearbyGYm extends StatefulWidget {
  const NearbyGYm({Key? key}) : super(key: key);

  @override
  State<NearbyGYm> createState() => _NearbyGYmState();
}

class _NearbyGYmState extends State<NearbyGYm> {
  static final _initialCameraPosition = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 25.5,
  );
  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(31.5189006, 74.3234204),
      infoWindow: InfoWindow(title: 'Gym'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialCameraPosition,
      markers: Set<Marker>.of(_markers),
    );
  }
}

class MyMapgyms extends StatelessWidget {
  const MyMapgyms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _initialCameraPosition = CameraPosition(
      target: LatLng(31.5204, 74.3587),
      zoom: 25.5,
    );
    final List<Marker> _markers = <Marker>[
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(31.5189006, 74.3234204),
        infoWindow: InfoWindow(title: 'Gym'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    ];
    return GoogleMap(
      initialCameraPosition: _initialCameraPosition,
      markers: Set<Marker>.of(_markers),
    );
  }
}
