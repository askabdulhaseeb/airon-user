import 'dart:async';

import 'package:airon/Model/eth/ethdata.dart';
import 'package:airon/screens/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_manager/nfc_manager.dart';

class MyMap extends StatefulWidget {
  final String metamaskaddress;
  const MyMap({Key? key, required this.metamaskaddress}) : super(key: key);
  static const String routeName = '/MyMap';

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Completer<GoogleMapController> _controller = Completer();
  static double currentlat = 40.7128;
  static double currentlng = -74.0060;
  static List<double> currentlat1 = [];
  static List<double> currentlng1 = [];
  static double gym1lat = 0;
  static double gym1long = 0;
  static String Gym1_Name = 'h';
  double Ethamount = 0;
  bool _isloading = false;
  int size = 0;
  String gymcoonectname = '';
  late final String Metamaskwallet;

  List<LatLng> _listt = <LatLng>[LatLng(currentlat, currentlng)];
  void initState() {
    super.initState();
    Metamaskwallet = widget.metamaskaddress;
    GetEtherum();
    currentlocationget();
    Nearbygym();
  }

  void GetEtherum() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('ethamount')
        .doc(widget.metamaskaddress)
        .get();
    setState(() {
      Ethamount = (snapshot.data() as Map<String, dynamic>)['amount'];
    });
    print("Current Eth amount");
    print(Ethamount);
  }

  currentlocationget() {
    _determinePosition().then((value) async {
      print('current location');
      print(value.latitude.toString() + ' ' + value.longitude.toString());

      _markers.add(
        Marker(
          markerId: MarkerId('52'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'Current Location'),
        ),
      );

      setState(() {
        currentlat = value.latitude;
        currentlng = value.longitude;
      });

      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Nearbygym() async {
    var api =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=Gym&location=${currentlat},${currentlng}&radius=15000&type=gym&key=AIzaSyBywB79y2hvYvNlztwLtwkGDqGT-uqDK84';

    var responce = await http.get(Uri.parse(api));
    dynamic list = jsonDecode(responce.body);
    print(list['results'.length]);
    print('Usman afzal');
    print(list['results']);
    print(list['results'].length);
    print(list['results'][0]['name']);
    print(list['results'][0]['geometry']['location']['lat']);
    print(list['results'][0]['geometry']['location']['lng']);
    setState(() {
      size = list['results'].length;
      Gym1_Name = list['results'][0]['name'];
      gym1lat = list['results'][0]['geometry']['location']['lat'];
      gym1long = list['results'][0]['geometry']['location']['lng'];
    });
    for (int i = 0; i < list['results'].length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: LatLng(list['results'][i]['geometry']['location']['lat'],
                list['results'][i]['geometry']['location']['lng']),
            infoWindow: InfoWindow(title: list['results'][i]['name']),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            onTap: () {
              setState(() {
                gymcoonectname = list['results'][i]['name'];
                _isloading = true;
              });

              print('ontap hova ha ');
              print(list['results'][i]['name']);
            }),
      );
      setState(() {});
    }
  }

  static final _initialCameraPosition = CameraPosition(
    target: LatLng(currentlat, currentlng),
    zoom: 25.5,
  );
  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('45'),
      position: LatLng(currentlat, currentlng),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 189, 187, 187),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                gymcoonectname,
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Ready To Scan',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          // onTap: () async =>
                          //     FlutterNfcReader.onTagDiscovered().listen((onData) {
                          //   setState(() {
                          //     nfcLocated = !nfcLocated;
                          //   });
                          //   print(onData.id);
                          //   print(onData.content);
                          // }),
                          onTap: () async {
                            var availability =
                                await FlutterNfcKit.nfcAvailability;
                            print(availability);
                            if (availability == NFCAvailability.available) {
                              print('here');
                              // handleTag;
                              var tag = await FlutterNfcKit.poll(
                                  timeout: Duration(seconds: 20));
                              print(tag);
                              if (tag != null) {
                                Ethdata().UploadEth(
                                    metamaskid: Metamaskwallet,
                                    amount: Ethamount);

                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Congratulation'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text(gymcoonectname),
                                            Text('You Earned 0.011123 ETH'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Ok'),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen(),
                                                ));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              setState(() {
                                _isloading = !_isloading;
                              });
                            }
                          },
                          child: Container(
                              width: 150,
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: ExactAssetImage('assets/nfc.png'),
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Approch an NFC Tag',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Center(
            //   child: GestureDetector(
            //     // onTap: () async =>
            //     //     FlutterNfcReader.onTagDiscovered().listen((onData) {
            //     //   setState(() {
            //     //     nfcLocated = !nfcLocated;
            //     //   });
            //     //   print(onData.id);
            //     //   print(onData.content);
            //     // }),
            //     onTap: () async {
            //       var availability = await FlutterNfcKit.nfcAvailability;
            //       print(availability);
            //       if (availability == NFCAvailability.available) {
            //         print('here');
            //         // handleTag;
            //         var tag = await FlutterNfcKit.poll(
            //             timeout: Duration(seconds: 20));
            //         print(tag);
            //         setState(() {
            //           if (tag != null) {
            //             Ethdata().MinusEth(
            //                 metamaskid: Metamaskwallet, amount: Ethamount);
            //             _isloading = !_isloading;
            //           }
            //         });
            //       }
            //     },
            //     child: Container(
            //         padding: const EdgeInsets.all(8),
            //         margin: const EdgeInsets.all(8),
            //         color: Colors.orange,
            //         child: const Text(
            //           'connect nfc',
            //           style: TextStyle(
            //             color: Colors.white,
            //           ),
            //         )),
            //   ),
            // ),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Gyms Near Me',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: SafeArea(
              child: GoogleMap(
                myLocationButtonEnabled: true,
                zoomControlsEnabled: true,
                initialCameraPosition: _initialCameraPosition,
                markers: Set<Marker>.of(_markers),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _determinePosition().then((value) async {
                  print('current location');
                  print(value.latitude.toString() +
                      ' ' +
                      value.longitude.toString());

                  _markers.add(
                    Marker(
                      markerId: MarkerId('45'),
                      position: LatLng(value.latitude, value.longitude),
                      infoWindow: InfoWindow(title: 'Current Location'),
                    ),
                  );

                  setState(() {
                    currentlat = value.latitude;
                    currentlng = value.longitude;
                  });
                  print('yar war gy be');
                  print(currentlat);
                  print(currentlng);
                  Nearbygym();
                  CameraPosition cameraPosition = CameraPosition(
                      zoom: 14,
                      target: LatLng(value.latitude, value.longitude));

                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(cameraPosition));
                  setState(() {});
                });
              },
              child: Icon(Icons.location_searching_rounded),
            ),
          );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
