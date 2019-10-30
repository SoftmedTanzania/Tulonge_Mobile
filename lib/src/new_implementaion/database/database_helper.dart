import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

final String databaseName = 'chw_app_table';
final String googleMapKey = 'AIzaSyDMokINYF0aC5zK7i2fldveKx20hUwEbK81';

getDoubleNumber(number) {
  if (number != null) {
    if (number is num) {
      return number;
    } else {
      return double.parse(number);
    }
  } else {
    return 0;
  }
}

String makeid() {
  var text = '';
  var rng = new Random();
  const possible_combinations =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  for (var i = 0; i < 11; i++) {
    text += possible_combinations[rng.nextInt(possible_combinations.length)];
  }
  return text;
}

generateMapUrl({String latitude, String longitude}) {
  return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=17&size=600x300&maptype=roadmap&markers=color:green%7Clabel:G%7C$latitude,$longitude&key=$googleMapKey";
}

Future<bool> checkNetwork() async {
  try {
    final response = await http.get("https://google.com");
    print(response.statusCode);
    return true;
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
}
