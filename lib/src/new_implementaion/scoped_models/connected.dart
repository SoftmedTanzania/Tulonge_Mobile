import 'package:chw/src/new_implementaion/api_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/cso_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/education_group_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/education_type_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/ipc_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/material_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/participant_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/referral_type_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/specific_message_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/target_audience_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/user_database_provider.dart';
import 'package:chw/src/new_implementaion/database/database_providers/village_database_provider.dart';
import 'package:chw/src/new_implementaion/models/cso_model.dart';
import 'package:chw/src/new_implementaion/models/educated_group_model.dart';
import 'package:chw/src/new_implementaion/models/educated_type_model.dart';
import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/models/material_model.dart';
import 'package:chw/src/new_implementaion/models/participant_model.dart';
import 'package:chw/src/new_implementaion/models/refferal_type_model.dart';
import 'package:chw/src/new_implementaion/models/session_model.dart';
import 'package:chw/src/new_implementaion/models/specific_message_model.dart';
import 'package:chw/src/new_implementaion/models/target_audience_model.dart';
import 'package:chw/src/new_implementaion/models/user_model.dart';
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/ui/shared/custom_exceptions.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ConnectedModel on Model {
  List<Cso> csos = [];
  List<EducatedGroup> educatedGroups = [];
  List<EducationType> educationTypes = [];
  List<Ipc> ipcs = [];
  List<Participant> participants = [];
  List<ReferralType> referralTypes = [];
  List<SpecificMessage> specificMessages = [];
  List<TargetAudience> targetAudiences = [];
  List<User> users = [];
  List<Village> villages = [];
  List<MaterialModel> materials = [];
  User user;
  bool dataReady = false;
  Ipc selectedIpc;

  //  get data
  List<Cso> get getCsos => csos;
  List<EducatedGroup> get getEducatedGroups => educatedGroups;
  List<EducationType> get getEducationTypes => educationTypes;
  List<Ipc> get geIpcs => ipcs;
  List<Participant> get geParticipants => participants;
  List<ReferralType> get getReferralTypes => referralTypes;
  List<SpecificMessage> get geSpecificMessages => specificMessages;
  List<TargetAudience> get geTargetAudiences => targetAudiences;
  List<User> get geUsers => users;
  List<Village> get getVillages => villages;
  List<MaterialModel> get getMaterials => materials;
  User get currentUser => user;

  initilizeUsers() async {
    UserDataProvider UserDbProvider = UserDataProvider();
    this.users = await UserDbProvider.getAllUsers();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (this.users.length > 0) {
      this.user = this.users[0];
      await prefs.setString('chwToken', this.user.tokenId);
      this.initializeCso();
      this.initializeEducationGroups();
      this.initializeEducationTypes();
      this.initializeReferralTypes();
      this.initializeSpecificMessage();
      this.initializetargetAudience();
      this.initializeMaterials();
      this.initializeVillage();
      this.initilizeIpcs();
      this.initializeParticipants();
    } else {
      this.user = null;
      await prefs.remove('chwToken');
    }
    this.dataReady = true;
    notifyListeners();
  }

  getUpdates() async {
    await this.initializeCso(true);
    await this.initializeEducationGroups(true);
    await this.initializeEducationTypes(true);
    await this.initializeReferralTypes(true);
    await this.initializeSpecificMessage(true);
    await this.initializetargetAudience(true);
    await this.initializeMaterials(true);
  }

  initializeCso([fromServer = false]) async {
    CsoDataProvider csoDataProvider = new CsoDataProvider();
    this.csos = await csoDataProvider.initiateCso(fromServer);
    notifyListeners();
  }

  initializeEducationGroups([fromServer = false]) async {
    EducatedGroupDataProvider dbProvider = EducatedGroupDataProvider();
    this.educatedGroups = await dbProvider.initiateEducatedGroup(fromServer);
    notifyListeners();
  }

  initializeEducationTypes([fromServer = false]) async {
    EducationTypeDataProvider dbProvider = EducationTypeDataProvider();
    this.educationTypes = await dbProvider.initiateEducationType(fromServer);
    notifyListeners();
  }

  initializeReferralTypes([fromServer = false]) async {
    ReferralTypeDataProvider dbProvider = ReferralTypeDataProvider();
    this.referralTypes = await dbProvider.initiateReferralType(fromServer);
    notifyListeners();
  }

  initializeSpecificMessage([fromServer = false]) async {
    SpecificMessageDataProvider dbProvider = SpecificMessageDataProvider();
    this.specificMessages =
        await dbProvider.initiateSpecificMessage(fromServer);
    notifyListeners();
  }

  initializeMaterials([fromServer = false]) async {
    MaterialDataProvider dbProvider = MaterialDataProvider();
    this.materials = await dbProvider.initiateMaterialModel(fromServer);
    notifyListeners();
  }

  initializetargetAudience([fromServer = false]) async {
    TargetAudienceDataProvider dbProvider = TargetAudienceDataProvider();
    this.targetAudiences = await dbProvider.initiateTargetAudience(fromServer);
    notifyListeners();
  }

  initializeVillage() async {
    VillageDataProvider dbProvider = VillageDataProvider();
    this.villages = await dbProvider.initiateVillage();
    notifyListeners();
  }

  initilizeIpcs() async {
    IpcDataProvider dbProvider = IpcDataProvider();
    this.ipcs = await dbProvider.initiateIpc();
    notifyListeners();
  }

  initializeParticipants() async {
    ParticipantDataProvider dbProvider = ParticipantDataProvider();
    this.participants = await dbProvider.initiateParticipant();
    notifyListeners();
  }

  String getCsoName(String id) {
    Cso selectedCso = csos.firstWhere((cso) => cso.id == id);
    if (selectedCso != null) {
      return selectedCso.name;
    }
    return '';
  }

  num getNumberOfSessions(Ipc ipc) {
    var counter = 0;
    if (ipc.act1Date != '') {
      counter += 1;
    }
    if (ipc.act2Date != '') {
      counter += 1;
    }
    if (ipc.act3Date != '') {
      counter += 1;
    }
    if (ipc.act4Date != '') {
      counter += 1;
    }
    if (ipc.act5Date != '') {
      counter += 1;
    }
    return counter;
  }

  num getNumberOfParticipant(Ipc ipc) {
    List<Participant> items = participants
        .where((participant) => participant.eventNumber == ipc.eventNumber)
        .toList();
    return items.length;
  }

  setSelectedIPc(Ipc ipc) {
    this.selectedIpc = ipc;
    notifyListeners();
  }

  num numberOfSessionMemberAttended(Participant participant) {
    var counter = 0;
    if (participant.act1Attendance) {
      counter += 1;
    }
    if (participant.act2Attendance) {
      counter += 1;
    }
    if (participant.act3Attendance) {
      counter += 1;
    }
    if (participant.act4Attendance) {
      counter += 1;
    }
    if (participant.act5Attendance) {
      counter += 1;
    }
    return counter;
  }

  String sessionMemberParicipated(Participant participant) {
    var counter = [];
    if (participant.act1Attendance) {
      counter.add('1');
    }
    if (participant.act2Attendance) {
      counter.add('2');
    }
    if (participant.act3Attendance) {
      counter.add('3');
    }
    if (participant.act4Attendance) {
      counter.add('4');
    }
    if (participant.act5Attendance) {
      counter.add('5');
    }
    return counter.join(', ');
  }

  List<Participant> getIpcMembers() {
    return participants
        .where((participant) =>
            participant.eventNumber == this.selectedIpc.eventNumber)
        .toList();
  }

  setUnsychronized() async {
    this.selectedIpc.isSynchronized = false;
    IpcDataProvider ipcDataProvider = IpcDataProvider();
    await ipcDataProvider.updateIpc(this.selectedIpc);
    this.initilizeIpcs();
  }

  List<SessionModel> getIpcSessions() {
    List<SessionModel> sessions = [];
    Ipc ipc = this.selectedIpc;
    if (ipc.act1Date != '') {
      sessions.add(SessionModel(
          sessionDate: ipc.act1Date,
          kadi: ipc.day1Card,
          game: ipc.day1Game,
          sessionNumber: 1,
          material: ipc.day1Material,
          toolUsed: ipc.trainingItemUsed,
          participants: this
              .getIpcMembers()
              .where((participant) => participant.act1Attendance)
              .toList()));
    }
    if (ipc.act2Date != '') {
      sessions.add(SessionModel(
          sessionDate: ipc.act2Date,
          kadi: ipc.day2Card,
          game: ipc.day2Game,
          sessionNumber: 2,
          material: ipc.day2Material,
          toolUsed: ipc.trainingItemUsed,
          participants: this
              .getIpcMembers()
              .where((participant) => participant.act2Attendance)
              .toList()));
    }
    if (ipc.act3Date != '') {
      sessions.add(SessionModel(
          sessionDate: ipc.act3Date,
          kadi: ipc.day3Card,
          game: ipc.day3Game,
          sessionNumber: 3,
          material: ipc.day3Material,
          toolUsed: ipc.trainingItemUsed,
          participants: this
              .getIpcMembers()
              .where((participant) => participant.act3Attendance)
              .toList()));
    }
    if (ipc.act4Date != '') {
      sessions.add(SessionModel(
          sessionDate: ipc.act4Date,
          kadi: ipc.day4Card,
          game: ipc.day4Game,
          sessionNumber: 4,
          material: ipc.day4Material,
          toolUsed: ipc.trainingItemUsed,
          participants: this
              .getIpcMembers()
              .where((participant) => participant.act4Attendance)
              .toList()));
    }
    if (ipc.act5Date != '') {
      sessions.add(SessionModel(
          sessionDate: ipc.act5Date,
          kadi: ipc.day5Card,
          game: ipc.day5Game,
          sessionNumber: 5,
          material: ipc.day5Material,
          toolUsed: ipc.trainingItemUsed,
          participants: this
              .getIpcMembers()
              .where((participant) => participant.act5Attendance)
              .toList()));
    }

    return sessions;
  }

  SessionModel getSessionByNumber(num sessionNumber) {
    SessionModel session = this.getIpcSessions().firstWhere(
        (sess) => sess.sessionNumber == sessionNumber,
        orElse: () => null);
    return session;
  }

  getOneParticipant(String participantId) {
    Participant participant = this
        .participants
        .firstWhere((p) => p.id == participantId, orElse: () => null);
    return participant;
  }

  num getNextSession(Ipc ipc) {
    if (ipc.act5Date != '') {
      return null;
    } else if (ipc.act4Date != '') {
      return 5;
    } else if (ipc.act3Date != '') {
      return 4;
    } else if (ipc.act2Date != '') {
      return 3;
    } else if (ipc.act1Date != '') {
      return 2;
    } else {
      return 1;
    }
  }

  List<Ipc> get unsyncedSessions => this
      .ipcs
      .where((ipc) => !ipc.isSynchronized && ipc.act1Date != '')
      .toList();

  completeSession(Ipc ipc) async {
    IpcDataProvider dbDataProvider = IpcDataProvider();
    ipc.isCompleted = true;
    ipc.isSynchronized = false;
    await dbDataProvider.addOrUpdateIpc(ipc);
    initilizeIpcs();
  }

  sendSession() async {
    IpcDataProvider ipcDataProvider = IpcDataProvider();
    for (var i = 0; i < this.unsyncedSessions.length; i++) {
      Ipc ipc = this.unsyncedSessions[i];
      Map<dynamic, dynamic> session = ipc.toMap();
      List<Map<dynamic, dynamic>> ipcParticipants = participants
          .where((participant) {
            return participant.eventNumber == ipc.eventNumber;
          })
          .map((participant) => participant.toMap())
          .toList();
      Map<dynamic, dynamic> sessionWithParticipant = {
        ...session,
        'participants': ipcParticipants
      };
      ApiProvider apiProvider = ApiProvider();
      var sent = await apiProvider.addUpdateIPCData(
          data: sessionWithParticipant, ipc: ipc, user: this.currentUser);
      if (sent != null) {
        ipc.isSynchronized = true;
        await ipcDataProvider.updateIpc(ipc);
        this.initilizeIpcs();
      } else {
        throw new NetworkErrorException();
      }
    }
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chwUserId');
    await prefs.remove('chwToken');
    UserDataProvider userDataProvider = UserDataProvider();
    await userDataProvider.deleteUser(this.user.id);
    this.user = null;
    notifyListeners();
  }
}
