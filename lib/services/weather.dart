import 'package:clima_flutter/secret_consts.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';


const openweathermapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
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
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'で今日は🍦が必要でしょう。 ';
    } else if (temp > 17) {
      return 'でショートパンツと👕の出番です。';
    } else if (temp < 10) {
      return 'で🧣と🧤が必要でしょう。';
    } else {
      return 'で念の為に🧥を用意するといいでしょう。 ';
    }
  }
}
