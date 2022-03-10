import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    Location location = Location();
  await location.fetchCurrentLocation();
  print('fetchLocation colled');
    print(location.latitude);
    print(location.longitude);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
