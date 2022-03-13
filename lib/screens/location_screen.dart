
import 'package:clima_flutter/screens/city_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherData;

  // ignore: use_key_in_widget_constructors
  const LocationScreen({required this.weatherData});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature = 0;
  String weatherIcon = '';

  String cityName = '';
  String weatherMessage = '';
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    //widget==LocationScreen
    updataUI(widget.weatherData);
  }

  void updataUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'error';
        cityName = '';
        weatherMessage = '取得できませんでした';
        return;
      }
      temperature = weatherData['main']['temp'].toInt();
      weatherMessage = weatherModel.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:   <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.fetchLocation();
                        updataUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 40.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${temperature.toString()}°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    '$cityName$weatherMessage',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // double temperature = decodeData['main']['temp'];
  // int conditionId = decodeData['weather'][0]['id'];
  // String cityname = decodeData['name'];