import 'package:location/location.dart';

class LocationModel {
  double latitude;
  double longitude;

  LocationModel.fromJson(Map<String, dynamic> parseJson)
      : latitude = parseJson['latitude'],
        longitude = parseJson['longitude'];

  LocationModel.toDouble(LocationData location)
      : latitude = location.latitude,
        longitude = location.longitude;

  LocationModel.fromDb(LocationData location)
      : latitude = location.latitude,
        longitude = location.longitude;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
