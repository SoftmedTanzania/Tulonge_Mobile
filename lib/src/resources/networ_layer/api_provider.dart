import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/cso.dart';
import 'package:chw/src/models/education_group.dart';
import 'package:chw/src/models/education_type.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/resources/networ_layer/http_client.dart';

final mainRoot = 'https://tulongeafya.com/dhis/api';
final dataStoreRoot = 'https://tulongeafya.com/dhis/api/dataStore';

class ApiProvider {
  var baseUrl = "";
  TulongeClient client = new TulongeClient();
  static final ApiProvider _instance = new ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() {
    return _instance;
  }

  void initState() {}

  getStructure() async {
    var client = await this.client.clientAuthenticationObject();
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> tree = {
      "ward": {
        "id":"",
        "name":""
      },
      "district": {
        "id":"",
        "name":""
      },
      "region": {
        "id":"",
        "name":""
      }
    };
    try {

      var uid = prefs.getString('user_organisationunit_id');
      final response = await client.get(
          '$mainRoot/organisationUnits/$uid.json?fields=id,name,level,parent[id,name,level,parent[id,name,level,parent[id,name,level]]]');
      final parsedJson = response.data;
      tree['ward'] = {
        "id":parsedJson["id"],
        "name":parsedJson["name"],
      };

      tree['district'] = {
        "id":parsedJson["parent"]["id"],
        "name":parsedJson["parent"]["name"],
      };

      tree['region'] = {
        "id":parsedJson["parent"]["parent"]["id"],
        "name":parsedJson["parent"]["parent"]["name"],
      };
      prefs.setString('organisationunit_tree', jsonEncode(tree));
    } on DioError catch (e) {
      prefs.setString('organisationunit_tree', jsonEncode(tree));
      print(e.message);
    }
  }

  Future<List<dynamic>> getSpecificMessage() async {
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

  Future<List<EducationType>> getEducationType() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/educationTypes');
      final specificResponse =
          await client.get('$dataStoreRoot/tulonge_basic_data/specificMessage');
      final specificMessageData = specificResponse.data;
      final parsedJson = response.data;
      List<EducationType> csos = [];

      for (var csoCounter = 0; csoCounter < parsedJson.length; csoCounter++) {
        EducationType educationType =
            EducationType.fromJson(parsedJson[csoCounter]);
        List<Map<String, dynamic>> specificMessage = [];
        for (var specCounter = 0;
            specCounter < specificMessageData.length;
            specCounter++) {
          if (educationType.english_name ==
              specificMessageData[specCounter]['education_type']) {
            specificMessage.add(specificMessageData[specCounter]);
          }
        }
        educationType.specificMessage = specificMessage;
        csos.add(educationType);
      }
      ;

      return csos;
    } on DioError catch (e) {
//      print(e.message);
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getIPCData() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/ipc_mobile');
      final parsedJson = response.data;
      List<Map<String, dynamic>> ipc = [];
      List<dynamic> type = [];
      if (parsedJson.runtimeType == type.runtimeType) {
        for (var elementIndex = 0;
            elementIndex < parsedJson.length;
            elementIndex++) {
          Map<String, dynamic> element = parsedJson[elementIndex];
          ipc.add(element);
        }
      }
      return ipc;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<dynamic> addUpdateIPCData(data) async {
    var client = await this.client.clientAuthenticationObject();
    try {
      var response = await client
          .put('$dataStoreRoot/tulonge_basic_data/ipc_mobile', data: data);
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<MaterialModel>> getMaterialSupplied() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/material');
      final parsedJson = response.data;
      List<MaterialModel> csos = [];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('materialSupplied', jsonEncode(parsedJson));
      for (var csoCounter = 0; csoCounter < parsedJson.length; csoCounter++) {
        csos.add(MaterialModel.fromJson(parsedJson[csoCounter]));
      }
      ;

      return csos;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<List<EducationGroup>> getEducationGroups() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response =
          await client.get('$dataStoreRoot/tulonge_basic_data/educatedGroups');
      final parsedJson = response.data;
      List<EducationGroup> csos = [];

      for (var csoCounter = 0; csoCounter < parsedJson.length; csoCounter++) {
        csos.add(EducationGroup.fromJson(parsedJson[csoCounter]));
      }
      ;

      return csos;
    } on DioError catch (e) {
//      print(e.message);
      return null;
    }
  }

  Future<List<Map<dynamic, dynamic>>> getEducationGroupsList() async {
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

  Future<List<Map<dynamic, dynamic>>> getEducationTypeList() async {
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

  Future<List<Map<dynamic, dynamic>>> getSpecificMessageList() async {
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

  Future<List<Map<dynamic, dynamic>>> getReferralList() async {
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

  Future<List<Cso>> getCSO() async {
    var client = await this.client.clientAuthenticationObject();
    try {
      final response = await client
          .get('$dataStoreRoot/tulonge_basic_data/cso_organizations');
      final parsedJson = response.data;
      List<Cso> csos = [];

      for (var csoCounter = 0; csoCounter < parsedJson.length; csoCounter++) {
        csos.add(Cso.fromJson(parsedJson[csoCounter]));
      }
      ;

      return csos;
    } on DioError catch (e) {
//      print(e.message);
      return null;
    }
  }

  Future<List<Map<dynamic, dynamic>>> getCSOList() async {
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

  Future<bool> updateContact(
      List<Map<String, dynamic>> data, String contactId) async {
    var client = await this.client.clientAuthenticationObject();
    try {
      var response =
          await client.put('$mainRoot/api/events/${contactId}', data);
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<bool> deleteContact(String contactId) async {
    var client = await this.client.clientAuthenticationObject();
    try {
      var response = await client.delete('$mainRoot/api/events/${contactId}');
      return true;
    } on DioError catch (e) {
      return false;
    }
  }

  Future<bool> userLogin(username, password) async {
    var client =
        await this.client.clientAuthenticationObject(username, password);
    try {
      final response = await client.get(
          '$mainRoot/me.json?fields=id,name,username,phoneNumber,code,userCredentials[username,name,userRoles[id,name]],organisationUnits[id,name,level,parent[id,name,parent[id,name]]],attributeValues[value,attribute[id,name]]');

      final parsedJson = response.data;
      var status = false;
      if (parsedJson.toString().indexOf('loginPage') >= 0) {
        status = false;
      } else {
        // check if user is at ward level
        if (isCSO(parsedJson['organisationUnits']) == true) {
          var userIsSaved = await saveLoginUser(parsedJson);
          if (parsedJson['userCredentials']['username'] == username) {
            setToken(await getToken(username, password));
            status = true;
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('user_organisationunit_id', parsedJson['organisationUnits'][0]['id']);
            getStructure();
          } else {
            status = false;
          }
        } else {
          throw new Exception('USER_NOT_CSO');
        }
      }

      return false;
    } catch (e) {
      e.message == 'Http status error [401]'
          ? throw new Exception('NOT_AUTHENTICATED')
          : throw new Exception(e.message);
    }
  }

  getToken([username = null, password = null]) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    return username != null && password != null
        ? 'Basic ' + base64Encode(utf8.encode('${username}:${password}'))
        : prefs.getString('tulonge_user_token');
  }

  setToken(token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tulonge_user_token', token);
  }

  saveLoginUser(user) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      var userS = prefs.setString('currentUser', jsonEncode(user));
      print(prefs.get('currentUser'));
      return true;
    } catch (e) {
      return false;
    }
  }

  retrieveLoginUser() async {
    final prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('currentUser');
    return user == null ? user : jsonDecode(user);
  }

  removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('tolonge_user_token');
  }

  isCSO(roles) {
    // checking if user is at ward level
    bool valid = false;
    for (var role in roles) {
      role['level'] == 4 ? valid = true : valid = false;
    }
    return valid;
  }

}
