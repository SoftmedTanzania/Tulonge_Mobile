import 'dart:convert';

import 'package:chw/src/new_implementaion/models/user_model.dart';
import 'package:chw/src/resources/networ_layer/http_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/ipc_model.dart';

final mainRoot = 'https://testtulonge.com/dhis/api';
final dataStoreRoot = '$mainRoot/dataStore';

class ApiProvider {
  var baseUrl = "";
  TulongeClient client = new TulongeClient();
  static final ApiProvider _instance = new ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() {
    return _instance;
  }

  Future<Map<String, dynamic>> userLogin(username, password) async {
    var client =
        await this.client.clientAuthenticationObject(username, password);
    final url =
        '$mainRoot/me.json?fields=id,name,username,phoneNumber,code,userCredentials[username,name,userRoles[id,name]],organisationUnits[id,name,level,parent[id,name,parent[id,name]]],attributeValues[value,attribute[id,name]]';
    try {
      final response = await client.get(url);

      final parsedJson = response.data;
      var status = false;
      if (parsedJson.toString().indexOf('loginPage') >= 0) {
        throw new Exception('NOT_AUTHENTICATED');
      } else {
        if (isCSO(parsedJson['organisationUnits']) == true) {
          final token = await getToken(username, password);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('chwUserId', parsedJson['id']);
          await prefs.setString('chwToken', token);
          return {'user': parsedJson, 'token': token};
        } else {
          throw new Exception('USER_NOT_CSO');
        }
      }
    } catch (e) {
      print(e.message);
      e.message == 'Http status error [401]'
          ? throw new Exception('NOT_AUTHENTICATED')
          : throw new Exception(e.message);
    }
  }

  Future<List<dynamic>> getCSOList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response = await client
          .get('$dataStoreRoot/tulonge_basic_data/cso_organizations');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getEducationGroupsList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/educatedGroups');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getMaterialList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/material');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getEducationTypeList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/educationTypes');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getReferralList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/referral_types');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getTargetAudience() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/targetAudience');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
//      print(e.message);
      return null;
    }
  }

  Future<List<dynamic>> getSpecificMessageList() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/specificMessage');
      final parsedJson = response.data;
      return parsedJson;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<dynamic> addUpdateIPCData(
      {Map<dynamic, dynamic> data, User user, Ipc ipc}) async {
    var client = await this.client.clientAuthenticationObject();
    try {
      print('nafika');
      var response = await client.put(
          '$dataStoreRoot/mobile_data_${user.districtId}/${ipc.id}',
          data: data);
      return response;
    } on DioError catch (e) {
      try {
        var response = await client.post(
            '$dataStoreRoot/mobile_data_${user.districtId}/${ipc.id}',
            data: data);
        return response;
      } on DioError catch (e) {
        return null;
      }
    }
  }

  getToken([username = null, password = null]) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return 'Basic ' + base64Encode(utf8.encode('${username}:${password}'));
  }

  isCSO(roles) {
    // checking if user is at ward level
    bool valid = false;
    for (var role in roles) {
      role['level'] == 4 ? valid = true : valid = false;
    }
    return valid;
  }

  logout() {}
}
