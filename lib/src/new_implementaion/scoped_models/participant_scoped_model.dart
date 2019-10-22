import 'package:chw/src/new_implementaion/database/database_providers/ipc_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/participant_database_provider.dart';
import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/models/participant_model.dart';
import 'package:chw/src/new_implementaion/models/session_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/connected.dart';
import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:flutter/cupertino.dart';

mixin ParticipantScopedModel on ConnectedModel {
  Participant newParticipant;
  SessionModel newSession;

  var gameList = [
    {'display': 'Na 1', 'value': '1'},
    {'display': 'Na 2', 'value': '2'},
    {'display': 'Na 3', 'value': '3'},
    {'display': 'Na 4', 'value': '4'},
    {'display': 'Na 5', 'value': '5'}
  ];
  var kadiList = [
    {'display': 'Na 1', 'value': '1'},
    {'display': 'Na 2', 'value': '2'},
    {'display': 'Na 3', 'value': '3'},
    {'display': 'Na 4', 'value': '4'},
    {'display': 'Na 5', 'value': '5'},
    {'display': 'Na 6', 'value': '6'},
    {'display': 'Na 7', 'value': '7'},
    {'display': 'Na 8', 'value': '8'},
    {'display': 'Na 9', 'value': '9'},
    {'display': 'Na 10', 'value': '10'}
  ];

  Map<String, String> maritalStatusDefinition = {
    'M': 'Ameoa/Ameolewa',
    'S': 'Hajaoa/Hajaolewa',
    'C': 'Anaishi na mwenza bila ndoa',
    'A': 'Ameachika'
  };

  Map<String, String> genderDefinition = {
    'M': 'Male',
    'F': 'Female',
  };

  bool editingSession = false;

  setHaliYaNdoa(value) {
    this.newParticipant.maritalStatus = value;
    notifyListeners();
  }

  setGender(value) {
    this.newParticipant.gender = value;
    notifyListeners();
  }

  setIsPregnant() {
    this.newParticipant.isPregnant = !this.newParticipant.isPregnant;
    notifyListeners();
  }

  setTaarifaNyingineZaParticipant(
      {String name,
      String age,
      String phone,
      String gender,
      String maritalStatus}) {
    this.newParticipant.name = name;
    this.newParticipant.age = age;
    this.newParticipant.phoneNumber = phone;
    this.newParticipant.maritalStatus = maritalStatus;
    this.newParticipant.gender = gender;
    notifyListeners();
  }

  saveParticipant() async {
    ParticipantDataProvider participantDataProvider = ParticipantDataProvider();
    await participantDataProvider.addOrUpdateParticipant(this.newParticipant);
    if (this.selectedIpc.isSynchronized) {
      await this.setUnsychronized();
    }
    this.initializeParticipants();
  }

  deleteParticipant(String participantId) async {
    ParticipantDataProvider participantDataProvider = ParticipantDataProvider();
    await participantDataProvider.deleteParticipant(participantId);
    this.initializeParticipants();
  }

  setSessionKadi(List values) {
    this.newSession.kadi = values.join(', ');
    notifyListeners();
  }

  setSessionKGame(List values) {
    this.newSession.game = values.join(', ');
    notifyListeners();
  }

  setSessionDate(DateTime value) {
    this.newSession.sessionDate = value.toString();
    print(value.toString());
    notifyListeners();
  }

  setVifaaVilivyotumika(bool value) {
    if (!value) {
      this.newSession.material = '';
    }
  }

  List<String> kadiZilizotumika() {
    List<String> cards = [];
    if (this.editingSession) {
      if (this.newSession.sessionNumber != 1) cards.addAll(selectedIpc.day1Card.split(', '));
      if (this.newSession.sessionNumber != 2) cards.addAll(selectedIpc.day2Card.split(', '));
      if (this.newSession.sessionNumber != 3) cards.addAll(selectedIpc.day3Card.split(', '));
      if (this.newSession.sessionNumber != 4) cards.addAll(selectedIpc.day4Card.split(', '));
      if (this.newSession.sessionNumber != 5) cards.addAll(selectedIpc.day5Card.split(', '));
    } else {
      cards.addAll(selectedIpc.day1Card.split(', '));
      cards.addAll(selectedIpc.day2Card.split(', '));
      cards.addAll(selectedIpc.day3Card.split(', '));
      cards.addAll(selectedIpc.day4Card.split(', '));
      cards.addAll(selectedIpc.day5Card.split(', '));
    }
    return cards;
  }

  List<String> gameZilizotumika() {
    List<String> cards = [];
    if (this.editingSession) {
      if (this.newSession.sessionNumber != 1) cards.addAll(selectedIpc.day1Game.split(', '));
      if (this.newSession.sessionNumber != 2) cards.addAll(selectedIpc.day2Game.split(', '));
      if (this.newSession.sessionNumber != 3) cards.addAll(selectedIpc.day3Game.split(', '));
      if (this.newSession.sessionNumber != 4) cards.addAll(selectedIpc.day4Game.split(', '));
      if (this.newSession.sessionNumber != 5) cards.addAll(selectedIpc.day5Game.split(', '));
    } else {
      cards.addAll(selectedIpc.day1Game.split(', '));
      cards.addAll(selectedIpc.day2Game.split(', '));
      cards.addAll(selectedIpc.day3Game.split(', '));
      cards.addAll(selectedIpc.day4Game.split(', '));
      cards.addAll(selectedIpc.day5Game.split(', '));
    }
    return cards;
  }

  DateTime getInitialSessionDate({SessionModel session}) {
     DateTime date;
     if (session == null) {
       num sessions = this.getIpcSessions().length;
       SessionModel sess =  getSessionByNumber(sessions);
       if (sess != null) {
         print(sess.sessionDate);
         date = DateTime.parse(sess.sessionDate);
       } else {
         date = DateTime.now();
       }
     } else {
       date = DateTime.parse(session.sessionDate);
     }
     return date;
  }

  DateTime getMinimumSessionDate(num sessionNumber) {
    num lastSessionNumber = sessionNumber - 1;
    SessionModel lastSession = getSessionByNumber(lastSessionNumber);
    if (lastSession == null) {
      return null;
    } else {
      return DateTime.parse(lastSession.sessionDate);
    }

  }

  DateTime getMaxmumSessionDate(num sessionNumber) {
    num nextSessionNumber = sessionNumber + 1;
    SessionModel nextSession = getSessionByNumber(nextSessionNumber);
    if (nextSession == null) {
      return null;
    } else {
      return DateTime.parse(nextSession.sessionDate);
    }
  }

  deleteSession(SessionModel session) async {
    switch (this.newSession.sessionNumber) {
      case (1):
        this.selectedIpc.act1Date = '';
        this.selectedIpc.day1Material = '';
        this.selectedIpc.day1Card = '';
        this.selectedIpc.day1Game = '';
        this.selectedIpc.created = '';
        break;
      case (2):
        this.selectedIpc.act2Date = '';
        this.selectedIpc.day2Material = '';
        this.selectedIpc.day2Card = '';
        this.selectedIpc.day2Game = '';
        this.selectedIpc.created = getSessionByNumber(1).sessionDate;
        break;
      case (3):
        this.selectedIpc.act3Date = '';
        this.selectedIpc.day3Material = '';
        this.selectedIpc.day3Card = '';
        this.selectedIpc.day3Game = '';
        this.selectedIpc.created = getSessionByNumber(2).sessionDate;
        break;
      case (4):
        this.selectedIpc.act4Date = '';
        this.selectedIpc.day4Material = '';
        this.selectedIpc.day4Card = '';
        this.selectedIpc.day4Game = '';
        this.selectedIpc.created = getSessionByNumber(3).sessionDate;
        break;
      case (5):
        this.selectedIpc.act5Date = '';
        this.selectedIpc.day5Material = '';
        this.selectedIpc.day5Card = '';
        this.selectedIpc.day5Game = '';
        this.selectedIpc.created = getSessionByNumber(4).sessionDate;
        break;
    }
    this.selectedIpc.isSynchronized = false;
    IpcDataProvider ipcDataProvider = IpcDataProvider();
    await ipcDataProvider.updateIpc(this.selectedIpc);
    this.initilizeIpcs();
  }

  clearMemberSessionData(num sessionNumber) async {
    ParticipantDataProvider participantDataProvider =
    ParticipantDataProvider();
    this.getIpcMembers().forEach((participant) async {
        switch (sessionNumber) {
          case (1):
          participant.act1Attendance = false;
          break;
          case (2):
          participant.act2Attendance = false;
          break;
          case (3):
          participant.act3Attendance = false;
          break;
          case (4):
          participant.act4Attendance = false;
          break;
          case (5):
          participant.act5Attendance = false;
          break;
        }
        await participantDataProvider.updateParticipant(participant);
        this.initializeParticipants();
    });
  }


  saveSession({Map<dynamic, dynamic> mahudhurio, Map<dynamic, dynamic> referral, Map<dynamic, dynamic> referralType, Map<dynamic, dynamic> referralReason, String material}) async {
    switch (this.newSession.sessionNumber) {
      case (1):
        this.selectedIpc.act1Date = this.newSession.sessionDate;
        this.selectedIpc.day1Material = material;
        if (this.selectedIpc.trainingItemUsed == 'Kadi') {
          this.selectedIpc.day1Card = this.newSession.kadi;
        } else {
          this.selectedIpc.day1Game = this.newSession.game;
        }
        if (this.getIpcSessions().length >= 0) {
          this.selectedIpc.created = this.newSession.sessionDate;
        }
        break;
      case (2):
        this.selectedIpc.act2Date = this.newSession.sessionDate;
        this.selectedIpc.day2Material = material;
        if (this.selectedIpc.trainingItemUsed == 'Kadi') {
          this.selectedIpc.day2Card = this.newSession.kadi;
        } else {
          this.selectedIpc.day2Game = this.newSession.game;
        }
        if (this.getIpcSessions().length >= 1) {
          this.selectedIpc.created = this.newSession.sessionDate;
        }
        break;
      case (3):
        this.selectedIpc.act3Date = this.newSession.sessionDate;
        this.selectedIpc.day3Material = material;
        if (this.selectedIpc.trainingItemUsed == 'Kadi') {
          this.selectedIpc.day3Card = this.newSession.kadi;
        } else {
          this.selectedIpc.day3Game = this.newSession.game;
        }
        if (this.getIpcSessions().length >= 2) {
          this.selectedIpc.created = this.newSession.sessionDate;
        }
        break;
      case (4):
        this.selectedIpc.act4Date = this.newSession.sessionDate;
        this.selectedIpc.day4Material = material;
        if (this.selectedIpc.trainingItemUsed == 'Kadi') {
          this.selectedIpc.day4Card = this.newSession.kadi;
        } else {
          this.selectedIpc.day4Game = this.newSession.game;
        }
        if (this.getIpcSessions().length >= 3) {
          this.selectedIpc.created = this.newSession.sessionDate;
        }
        break;
      case (5):
        this.selectedIpc.act5Date = this.newSession.sessionDate;
        this.selectedIpc.day5Material = material;
        if (this.selectedIpc.trainingItemUsed == 'Kadi') {
          this.selectedIpc.day5Card = this.newSession.kadi;
        } else {
          this.selectedIpc.day5Game = this.newSession.game;
        }
        if (this.getIpcSessions().length >= 4) {
          this.selectedIpc.created = this.newSession.sessionDate;
        }
        break;
    }
    this.selectedIpc.isSynchronized = false;
    IpcDataProvider ipcDataProvider = IpcDataProvider();
    await ipcDataProvider.updateIpc(this.selectedIpc);
    this.initilizeIpcs();

    ParticipantDataProvider participantDataProvider =
    ParticipantDataProvider();

    mahudhurio.forEach((key, value) async {
      Participant participant = getOneParticipant(key);
      if (participant != null) {
        switch (this.newSession.sessionNumber) {
          case (1):
            participant.act1Attendance = value;
            break;
          case (2):
            participant.act2Attendance = value;
            break;
          case (3):
            participant.act3Attendance = value;
            break;
          case (4):
            participant.act4Attendance = value;
            break;
          case (5):
            participant.act5Attendance = value;
            break;
        }
      }
      await participantDataProvider.updateParticipant(participant);
      this.initializeParticipants();
    });

    referral.forEach((key, value) async {
      Participant participant = getOneParticipant(key);
      if (participant != null) {
        participant.referred = value ?? false;
      }
      await participantDataProvider.updateParticipant(participant);
      this.initializeParticipants();
    });

    referralReason.forEach((key, value) async {
      Participant participant = getOneParticipant(key);
      if (participant != null) {
        participant.referralReason = value ?? '';
      }
      await participantDataProvider.updateParticipant(participant);
      this.initializeParticipants();
    });

    referralType.forEach((key, value) async {
      Participant participant = getOneParticipant(key);
      if (participant != null) {
        participant.referredTo = value ?? '';
      }
      await participantDataProvider.updateParticipant(participant);
      this.initializeParticipants();
    });
  }

  setNewSession(Ipc ipc, {num sessionNumber}) {
    if (sessionNumber == null) {
      this.editingSession = false;
      var nextSession = getNextSession(ipc);
      this.newSession = SessionModel(
          sessionDate: this.getInitialSessionDate().toIso8601String(),
          toolUsed: ipc.trainingItemUsed,
          game: '',
          kadi: '',
          material: '',
          participants: [],
          minDate: this.getInitialSessionDate(),
          maxDate: null,
          sessionNumber: nextSession);
    } else {
      this.editingSession = true;
      switch (sessionNumber) {
        case (1):
          this.newSession = SessionModel(
              sessionDate: ipc.act1Date,
              kadi: ipc.day1Card,
              game: ipc.day1Game,
              sessionNumber: 1,
              minDate: this.getMinimumSessionDate(1),
              maxDate: this.getMaxmumSessionDate(1),
              material: ipc.day1Material,
              toolUsed: ipc.trainingItemUsed,
              participants: this
                  .getIpcMembers()
                  .where((participant) => participant.act1Attendance)
                  .toList());
          break;
        case (2):
          this.newSession = SessionModel(
              sessionDate: ipc.act2Date,
              kadi: ipc.day2Card,
              game: ipc.day2Game,
              sessionNumber: 2,
              minDate: this.getMinimumSessionDate(2),
              maxDate: this.getMaxmumSessionDate(2),
              material: ipc.day2Material,
              toolUsed: ipc.trainingItemUsed,
              participants: this
                  .getIpcMembers()
                  .where((participant) => participant.act2Attendance)
                  .toList());
          break;
        case (3):
          this.newSession = SessionModel(
              sessionDate: ipc.act3Date,
              kadi: ipc.day3Card,
              game: ipc.day3Game,
              sessionNumber: 3,
              minDate: this.getMinimumSessionDate(3),
              maxDate: this.getMaxmumSessionDate(3),
              material: ipc.day3Material,
              toolUsed: ipc.trainingItemUsed,
              participants: this
                  .getIpcMembers()
                  .where((participant) => participant.act3Attendance)
                  .toList());
          break;
        case (4):
          this.newSession = SessionModel(
              sessionDate: ipc.act4Date,
              kadi: ipc.day4Card,
              game: ipc.day4Game,
              sessionNumber: 4,
              minDate: this.getMinimumSessionDate(4),
              maxDate: this.getMaxmumSessionDate(4),
              material: ipc.day4Material,
              toolUsed: ipc.trainingItemUsed,
              participants: this
                  .getIpcMembers()
                  .where((participant) => participant.act4Attendance)
                  .toList());
          break;
        case (5):
          this.newSession = SessionModel(
              sessionDate: ipc.act5Date,
              kadi: ipc.day5Card,
              game: ipc.day5Game,
              sessionNumber: 5,
              minDate: this.getMinimumSessionDate(5),
              maxDate: this.getMaxmumSessionDate(5),
              material: ipc.day5Material,
              toolUsed: ipc.trainingItemUsed,
              participants: this
                  .getIpcMembers()
                  .where((participant) => participant.act5Attendance)
                  .toList());
          break;
      }
    }
  }

  setNewParticipant({Participant participant}) {
    if (participant == null) {
      this.newParticipant = Participant(
          id: makeid(),
          name: '',
          age: null,
          gender: '',
          phoneNumber: '',
          referred: false,
          maritalStatus: '',
          eventNumber: selectedIpc.eventNumber,
          organisationUnitId: user != null ? user.wardId : '',
          isPregnant: false,
          created: selectedIpc.created,
          referralReason: '',
          referredTo: '',
          act1Attendance: false,
          act2Attendance: false,
          act3Attendance: false,
          act4Attendance: false,
          act5Attendance: false);
    } else {
      this.newParticipant = participant;
    }
  }
}
