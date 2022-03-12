import 'package:clima_flutter/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http; //パッケージの何を使用するかasでわかりやすくしてる
import 'dart:convert';

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
    print(location.longitude);
  }

  void fetchData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=35.67567567567568&lon=139.7601531564893&units=metric&lang=ja&appid=$kMYAPI'));

    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);

      double temperature = decodeData['main']['temp'];
      int conditionId = decodeData['weather'][0]['id'];
      String cityname = decodeData['name'];
      print(temperature);
      print(conditionId);
      print(cityname);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold();
  }
}
