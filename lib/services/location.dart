import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  Future<void> fetchCurrentLocation() async {
    //例外が発生する可能性があるので（例えば現在地の許可がされてない等。。。）
    //Future<Position>
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
