import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/basic_information.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/models/cso.dart';
import 'package:chw/src/models/education_group.dart';
import 'package:chw/src/models/education_type.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/models/mid_media.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/models/target_audience.dart';
import 'package:chw/src/resources/networ_layer/api_provider.dart';
import 'package:chw/src/resources/networ_layer/bd_provider.dart';

class Repository {
  DbProvider dbProvider = DbProvider.instance;
  ApiProvider api = new ApiProvider();

  Future<List<EducationGroup>> getEducationGroups() async {
    var csos = await api.getEducationGroups();

    return csos;
  }

  getSpecificMessage() async {
    var data = await api.getSpecificMessage();
    Map<String, dynamic> specificMessage = {
      'Malaria': [],
      'VVU': [],
      'Uzazi wa mpango': [],
      'Mama na Mtoto': [],
      'Kifua Kikuu': []
    };
    if (data != null) {
      data.forEach((item) {
        if (item['education_type'] != null) {
          var mapper = item['education_type'] == "HIV"
              ? "VVU"
              : item['education_type'] == "Family Planning (FP)"
              ? "Uzazi wa mpango"
              : item['education_type'] == "MNCH"
              ? "Mama na Mtoto"
              : item['education_type'] == "TB"
              ? "Kifua Kikuu"
              : item['education_type'];
          specificMessage[mapper].add(item);
        }
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("specificMessage", jsonEncode(specificMessage));
    }

    return specificMessage;
  }

  getTargetAudience() async {
    var data = await api.getTargetAudience();
    Map<String, dynamic> targetAudience = {'ADULTS': [], 'YOUTH': []};
    data.forEach((item) {
      if (item['main_group'] != null) {
        targetAudience[item['main_group']].add(item);
      }
    });
    return targetAudience;
  }

  getMazoezi(reference) async {
    var data = await dbProvider.getMazoezi(reference);
    List<CardGameModel> mazoezi = [];
    data.forEach((item) {
      mazoezi.add(CardGameModel.fromJson(item));
    });
    return mazoezi;
  }

  getParticipants(reference) async {
    var data = await dbProvider.getParticipants(reference);
    List<ParticipantModel> participants = [];
    data.forEach((item) {
      participants.add(ParticipantModel.fromJson(item));
    });
    return participants;
  }

  getStructure() async {
    await api.getStructure();
  }

  Future<List<MaterialModel>> getMaterialSupplied() async {
    var csos = await api.getMaterialSupplied();

    return csos;
  }

  Future<List<EducationType>> getEducationType() async {
    var csos = await api.getEducationType();

    return csos;
  }

  Future<List<Cso>> getCSOs() async {
    var csos = await api.getCSO();
//    this.getSpecificMessage();
    return csos;
  }

  Future<List<Session>> getAllSessions() async {
    var data = await dbProvider.queryAllSessions();
    List<Session> sessions = [];
    for (Map<String, dynamic> session in data) {
      sessions.add(Session.fromJson(session));
    }
    return sessions;
  }

  Future<bool> deleteSession(reference) async {
    bool isDeletable = await _deleteSynchronize(reference);
    if (isDeletable == true) {
      return await dbProvider.deleteSession(reference);
    } else {
      return false;
    }
  }

  Future<bool> _deleteSynchronize(reference) async {
    var sessionReference = reference;
    List<Map<String, dynamic>> availableIPCData = await api.getIPCData();
    List<Map<String, dynamic>> newIPCData = [];
    if (availableIPCData == null){
      return true;
    } else{
      for (int dataIndex = 0; dataIndex < availableIPCData.length; dataIndex++) {
        if (availableIPCData[dataIndex]['reference'] != sessionReference) {
          newIPCData.add(availableIPCData[dataIndex]);
        }
      }
    }

    if (newIPCData.length > 0) {
      try {
        var response = await api.addUpdateIPCData(newIPCData);
        if (response != null) {
          return response.data['httpStatusCode'] == 200 ? true : false;
        }
        return true;
      } catch (e) {
        return false;
      }
    }
  }

  Future<bool> dataSynchronization(reference) async {
    // TODO Preparing Data object for pushing to the server
    var rowSession = await dbProvider.getSession(reference);
    Session session = Session.fromDb(rowSession[0]);
    Map<String, dynamic> midMedia = MidMedia.fromObjects(session).toJson();
    List<Map<String, dynamic>> participants =
        await dbProvider.getSessionParticipants(reference);
    midMedia['participants'] = participants;
    var sessionReference = reference;
    List<Map<String, dynamic>> availableIPCData = await api.getIPCData();
    List<Map<String, dynamic>> newIPCData = [];
    // Checking if data exist and merge with local copy
    bool matchFound = false;
    if ( availableIPCData != null){
      for (int dataIndex = 0; dataIndex < availableIPCData.length; dataIndex++) {
        if (availableIPCData[dataIndex]['reference'] == sessionReference) {
          matchFound = true;
          Map<String, dynamic> data = {
            ...availableIPCData[dataIndex],
            ...midMedia
          };
          availableIPCData[dataIndex] = data;
        } else {
          if (!matchFound && dataIndex == (availableIPCData.length - 1)) {
            availableIPCData.add(midMedia);
          }
        }
      }
      newIPCData = availableIPCData;
    } else{
      newIPCData = [midMedia];
    }

    try {
      var response = await api.addUpdateIPCData(newIPCData);
      if (response != null) {
        return response.data['httpStatusCode'] == 200 ? true : false;
      }
      return false;
    } catch (e) {
//      print(e);
      return false;
    }
  }

  Future<dynamic> saveUpdateParticipants(
      ParticipantModel participant, session_id, participant_id) async {
    var response;
    if (session_id == null) {
      response = await dbProvider.insertParticipant(participant.toJson());
    } else {
      response = await dbProvider.updateParticipant(
          session_id, participant_id, participant.toJson());
    }
    return response;
  }

  Future<dynamic> deleteParticipant(session_id, participant_id) async {
    var response;
    if (session_id != null && participant_id != null) {
      response = await dbProvider.deleteParticipant(session_id, participant_id);
    }
    return response;
  }

  Future<dynamic> saveUpdateSession(
      Session session, session_id, isUpdating) async {
    var response;
    if (session_id == null || isUpdating == false) {
      response = await dbProvider.insertSession(session.forInsertion());
    } else {
      response =
          await dbProvider.updateSession(session.toJson(), session_id);
    }
    return response;
  }

  Future<dynamic> saveUpdateBasicInformation(
      BasicInformationModel basicInformation, String referenceId) async {
    var response = referenceId == null
        ? await dbProvider.insertBasicInformation(basicInformation.toJson())
        : await dbProvider.updateBasicInformation(
            basicInformation, referenceId);

    return response;
  }

  Future<dynamic> saveUpdateTargetAudience(
      TargetAudience target, String referenceId) async {
    var response;
    try {
      response = await dbProvider.updateTargetAudience(target, referenceId);
    } catch (e) {
      response = await dbProvider.insertTargetAudience(target);
    }

    return response;
  }

  Future<dynamic> saveUpdateMazoezi(
      CardGameModel mazoezi, String referenceId, String mazoeziId) async {
    var response;
    if (referenceId == null) {
      response = await dbProvider.insertMazoezi(mazoezi.toJson());
    } else {
      response = await dbProvider.updateMazoezi(
          mazoezi.toJson(), referenceId, mazoeziId);
    }
    return response;
  }

  Future<dynamic> deleteMazoezi(String referenceId, String zoeziId) async {
    var response;
    if (referenceId != null && zoeziId != null) {
      response = await dbProvider.deleteMazoezi(referenceId, zoeziId);
    }
    return response;
  }

  prepareSessionReference() {
    return dbProvider.prepareSessionReference();
  }
}
