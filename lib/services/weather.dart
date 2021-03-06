import 'package:clima_flutter/secret_consts.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';

const openweathermapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> fetchCity(String cityname) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openweathermapURL?q=$cityname&units=metric&lang=ja&appid=$kMYAPIkey&units=metric');

    var weatherData = await networkHelper.fetchData();
    return weatherData;
  }

  Future<dynamic> fetchLocation() async {
    Location location = Location();
    await location.fetchCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openweathermapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&lang=ja&appid=$kMYAPIkey&units=metric');

    var weatherData = await networkHelper.fetchData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'ใงไปๆฅใฏ๐ฆใๅฟ่ฆใงใใใใ ';
    } else if (temp > 17) {
      return 'ใงใทใงใผใใใณใใจ๐ใฎๅบ็ชใงใใ';
    } else if (temp < 10) {
      return 'ใง๐งฃใจ๐งคใๅฟ่ฆใงใใใใ';
    } else {
      return 'ใงๅฟตใฎ็บใซ๐งฅใ็จๆใใใจใใใงใใใใ ';
    }
  }
}
