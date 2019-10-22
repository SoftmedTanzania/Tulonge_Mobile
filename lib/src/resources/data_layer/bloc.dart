import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:chw/src/models/basic_information.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/models/cso.dart';
import 'package:chw/src/models/education_group.dart';
import 'package:chw/src/models/education_type.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/models/target_audience.dart';
import 'repository.dart';

class Bloc extends Object {
  final _synchronizedSessions = PublishSubject<int>();
  final _isSynched = PublishSubject<Map<String, bool>>();
  final _specificMessage = PublishSubject<Map<String, dynamic>>();
  final _targetAudience = PublishSubject<Map<String, dynamic>>();
  final _mazoezi = PublishSubject<List<CardGameModel>>();
  final _materialSupplied = PublishSubject<List<MaterialModel>>();
  final _participants = PublishSubject<List<ParticipantModel>>();
  final _sessions = PublishSubject<List<Session>>();
  final _educationGroup = PublishSubject<List<EducationGroup>>();
  final _educationType = PublishSubject<List<EducationType>>();
  final _csos = PublishSubject<List<Cso>>();
  final _repository = Repository();

  Observable<int> get synchronizedSessions => _synchronizedSessions.stream;

  Observable<Map<String, bool>> get isSynchronized => _isSynched.stream;

  Observable<Map<String, dynamic>> get specificMessage =>
      _specificMessage.stream;

  Observable<Map<String, dynamic>> get targetAudience => _targetAudience.stream;

  Observable<List<CardGameModel>> get mazoezi => _mazoezi.stream;

  Observable<List<ParticipantModel>> get participants => _participants.stream;

  Observable<List<EducationGroup>> get educationGroups =>
      _educationGroup.stream;

  Observable<List<EducationType>> get educationTypes => _educationType.stream;

  Observable<List<Session>> get sessions => _sessions.stream;

  Observable<List<Cso>> get csos => _csos.stream;

  Observable<List<MaterialModel>> get materialSupplied =>
      _materialSupplied.stream;

  /**
   * Application online processes
   */

  getSpecificMessage() async {
    final response = await _repository.getSpecificMessage();
    _specificMessage.sink.add(response);
  }

  getTargetAudience() async {
    final response = await _repository.getTargetAudience();
    _targetAudience.sink.add(response);
  }

  getMazoezi(reference) async {
    final response = await _repository.getMazoezi(reference);
    _mazoezi.sink.add(response);
  }

  getMaterialSupplied() async {
    final response = await _repository.getMaterialSupplied();
    _materialSupplied.sink.add(response);
  }

  getParticipants(reference) async {
    final response = await _repository.getParticipants(reference);
    _participants.sink.add(response);
  }


  getEducationGroups() async {
    final response = await _repository.getEducationGroups();
    _educationGroup.sink.add(response);
  }

  getEducationType() async {
    final response = await _repository.getEducationType();
    _educationType.sink.add(response);
  }

  getCSOs() async {
    final response = await _repository.getCSOs();
    _csos.sink.add(response);
  }

  /**
   * Application local operations to save ,update and retrieve resources
   * loclly
   */

  saveUpdateParticipants(
      ParticipantModel participant, sessionId, participantId) async {
    final response = await _repository.saveUpdateParticipants(
        participant, sessionId, participantId);
    return response;
  }

  deleteParticipants(sessionId, participantId) async {
    final session =
        await _repository.deleteParticipant(sessionId, participantId);
    getParticipants(sessionId);
    return session;
  }

  saveUpdateSession(Session session, sessionId, bool isUpdating) async {
    final response =
        await _repository.saveUpdateSession(session, sessionId, isUpdating);
    return response;
  }

  saveUpdateBasicInformation(
      BasicInformationModel basicInformation, String referenceId) async {
    final response = await _repository.saveUpdateBasicInformation(
        basicInformation, referenceId);
    return response;
  }

  saveUpdateMazoezi(
      CardGameModel mazoezi, String referenceId, String mazoeziId) async {
    final response =
        await _repository.saveUpdateMazoezi(mazoezi, referenceId, mazoeziId);
    return response;
  }

  deleteMazoezi(String referenceId, String zoeziId) async {
    final response = await _repository.deleteMazoezi(referenceId, zoeziId);
    getMazoezi(referenceId);
    return response;
  }

  saveUpdateTargetAudience(TargetAudience target, String referenceId) async {
    final response =
        await _repository.saveUpdateTargetAudience(target, referenceId);
    return response;
  }


  getSessions() async {
    int synced = 0;
    final session = await _repository.getAllSessions();
    print(session);
    print("All sessions");
    session.forEach((session) {
      print(session);
      if (session.isSynchronized == true) {
        synced += 1;
        _synchronizedSessions.add(synced);
      }
    });
    _sessions.sink.add(session);
  }

  deleteSession(reference) async {
    final session = await _repository.deleteSession(reference);
    this.getSessions();
  }

  dataSynchronization(reference) async {
    final response = await _repository.dataSynchronization(reference);
    Map<String, bool> testing = {};
    testing[reference] = response;
    _isSynched.add(testing);
    return response;
  }

  disposeEducationType() {
    _educationType.close();
  }

  disposeTargetAudience() {
    _targetAudience.close();
  }

  disposeSession() {
    _sessions.close();
  }

  disposeEducatedGroup() {
    _educationGroup.close();
  }

  disposeParticipant() {
    _participants.close();
  }

  disposeSpecificMessage() {
    _participants.close();
  }

  disposeCSO() {
    _csos.close();
  }
}
