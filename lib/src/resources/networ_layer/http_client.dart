import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TulongeClient {
  static final TulongeClient _instance = new TulongeClient.internal();

  TulongeClient.internal();

  factory TulongeClient() {
    return _instance;
  }

  void initState() {}

  clientAuthenticationObject([username = null, password = null]) async {
    var token = username != null && password != null
        ? await getToken(username, password)
        : await getToken();

    var dio = new Dio(new BaseOptions(
      connectTimeout: 100000,
      receiveTimeout: 100000,
      headers: {
        HttpHeaders.userAgentHeader: "dio",
        "api": "1.0.0",
        HttpHeaders.authorizationHeader: token,
        "Content-Type": 'json',
      },
      contentType: ContentType.json,
      responseType: ResponseType.json,
    ));

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (client) {
      client.badCertificateCallback=(X509Certificate cert, String host, int port){
        return true;
      };
    };
    return dio;
  }

  get(url) async {
    var client = await clientAuthenticationObject();
    return client.get(url);
  }

  post(url, data) async {
    var client = await clientAuthenticationObject();
    return client.post(url, data: data);
  }

  put(url, data) async {
    var client = await clientAuthenticationObject();
    return client.put(url, data: data);
  }

  delete(url) async {
    var client = await clientAuthenticationObject();
    return client.delete(url);
  }

  getToken([username = null, password = null]) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return username != null && password != null
        ? 'Basic ' + base64Encode(utf8.encode('${username}:${password}'))
        : prefs.getString('chwToken');
  }

  setToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tulonge_user_token', token);
  }

  removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('chwToken');
  }
}
