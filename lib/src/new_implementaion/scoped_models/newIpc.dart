import 'package:device_info/device_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:io';

import 'package:chw/src/new_implementaion/database/database_providers/ipc_database_provider.dart';
import 'package:chw/src/new_implementaion/models/educated_group_model.dart';
import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/models/material_model.dart';
import 'package:chw/src/new_implementaion/models/specific_message_model.dart';
import 'package:chw/src/new_implementaion/models/target_audience_model.dart';
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/connected.dart';
import 'package:chw/src/new_implementaion/ui/select_drop_down.dart';
import 'package:chw/src/new_implementaion/database/database_helper.dart';

mixin newIpcScopedModel on ConnectedModel {
  Ipc newIpc;
  List<TargetAudience> currentTargetList = [];
  var ainaYaWalengwa = [
    SelectInputModel(id: 'VIJANA', name: 'VIJANA'),
    SelectInputModel(id: 'WATU WAZIMA', name: 'WATU WAZIMA')
  ];
  var ainaYaMaterial = [
    SelectInputModel(id: 'Kadi', name: 'Tumia Kadi'),
    SelectInputModel(id: 'Game', name: 'Tumia Zoezi')
  ];

  bool doneSaving = false;
  bool isSaving = false;
  bool isError = false;
  String gpsCordinateS = '';
  String gpsCordinatorE = '';
  String gpsToolUsed = '';

  Ipc get getNewIpc => newIpc;

  void setIpc(Ipc ipc) {
    this.newIpc = ipc;
    notifyListeners();
  }

  void setLocation(LocationData locationData) {
    if (locationData != null) {
      this.newIpc.gpsCordinateS = '${locationData.latitude}';
      this.gpsCordinateS = '${locationData.latitude}';
      this.newIpc.gpsCordinatorE = '${locationData.longitude}';
      this.gpsCordinatorE = '${locationData.longitude}';
      print(this.newIpc.gpsCordinatorE);
      print(this.newIpc.gpsCordinateS);
      print(this.newIpc.eventNumber);
      notifyListeners();
    }
  }

  void setLocationFromMap(LatLng locationData) {
    if (locationData != null) {
      this.newIpc.gpsCordinateS = '${locationData.latitude.toStringAsFixed(7)}';
      this.gpsCordinateS = '${locationData.latitude.toStringAsFixed(7)}';
      this.newIpc.gpsCordinatorE = '${locationData.longitude.toStringAsFixed(7)}';
      this.gpsCordinatorE = '${locationData.longitude.toStringAsFixed(7)}';
      print(this.newIpc.gpsCordinatorE);
      print(this.newIpc.gpsCordinateS);
      print(this.newIpc.eventNumber);
      notifyListeners();
    }
  }

  getDeviceName() async {
    if (Platform.isAndroid) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          this.newIpc.gpsToolUsed = androidInfo.brand;
          this.gpsToolUsed = androidInfo.brand;
          this.notifyListeners();
        }
      } catch (e) {}
    }
  }

  prepareSessionReference() {
    var year = new DateTime.now().year;
    var month = new DateTime.now().month;
    var monthDetailed = month.toString().length == 1
        ? '0' + month.toString()
        : month.toString();
    return year.toString() +
        monthDetailed +
//        '/' +
//        this.user.regionName.toUpperCase().substring(0, 3) +
//        '/' +
//        this.user.districtName.toUpperCase().substring(0, 3) +
//        '/' +
//        this.user.wardName.toUpperCase().substring(0, 3) +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString();
  }

  bool get educationSelected => this.newIpc.malariaHealthEducationProvided || this.newIpc.tbHealthEducationProvided || this.newIpc.hivHealthEducationProvided || this.newIpc.mnhcHealthEducationProvided || this.newIpc.healthEducationProvided;

  setIpcVillage(Village village) {
    this.newIpc.eventPlace = village.name;
    this.newIpc.endTime = village.id;
    this.newIpc.communityLeaderName = village.leaderName;
    this.newIpc.communityLeaderPhone = village.leaderPhone;
    notifyListeners();
  }

  setWalengwa(value) {
    this.newIpc.materialUsed = value;
    this.currentTargetList = targetAudiences.where((target) {
      final String val = (value == 'VIJANA') ? 'YOUTH' : 'ADULTS';
      return target.mainGroup == val;
    }).toList();
    notifyListeners();
  }

  setTargetGroup(List values) {
     this.newIpc.targets = values.join(', ');
     notifyListeners();
  }

  setHouseHold(String value) {
     this.newIpc.households = value;
     notifyListeners();
  }

  setAinaYaMaterial(String value) {
     this.newIpc.trainingItemUsed = value;
     notifyListeners();
  }

  setEventDate(DateTime value) {
     this.newIpc.created = value.toString();
     print(value.toString());
     notifyListeners();
  }

  setEduGroup(value) {
    EducatedGroup educationGroup = educatedGroups.firstWhere((eduGroup) => eduGroup.id == value, orElse: () => null);
     this.newIpc.groupCrowdEducated = educationGroup.swahiliName;
     notifyListeners();
  }

  // Malaria specific issues
  setMalarialHealthProvided() {
    this.newIpc.malariaHealthEducationProvided = !this.newIpc.malariaHealthEducationProvided;
    if (!this.newIpc.malariaHealthEducationProvided) {
      this.newIpc.malariaSpecificMessage = '';
      this.newIpc.malariaSpecificMessageIds = '';
      this.newIpc.malariaToolsProvided = '';
      this.newIpc.malariaToolsProvidedIds = '';
    }
    notifyListeners();
  }

  setMalarialSpecificMessage(List<dynamic> values) {
    List<SpecificMessage> messages = values.map((value) => specificMessages.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.malariaSpecificMessage = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.malariaSpecificMessageIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }

  setMalariaTrainingTools(List<dynamic> values) {
    List<MaterialModel> messages = values.map((value) => materials.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.malariaToolsProvided = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.malariaToolsProvidedIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }


  // HIV Specific Issues
  setHIVHealthProvided() {
    this.newIpc.hivHealthEducationProvided = !this.newIpc.hivHealthEducationProvided;
    if (!this.newIpc.hivHealthEducationProvided) {
      this.newIpc.hivSpecificMessage = '';
      this.newIpc.hivSpecificMessageIds = '';
      this.newIpc.hivToolsProvided = '';
      this.newIpc.hivToolsProvidedIds = '';
    }
    notifyListeners();
  }

  setHIVSpecificMessage(List<dynamic> values) {
    List<SpecificMessage> messages = values.map((value) => specificMessages.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.hivSpecificMessage = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.hivSpecificMessageIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }

  setHIVTrainingTools(List<dynamic> values) {
    List<MaterialModel> messages = values.map((value) => materials.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.hivToolsProvided = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.hivToolsProvidedIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }


  // Kifua Kikuu Specific Issues
  setTBHealthProvided() {
    this.newIpc.tbHealthEducationProvided = !this.newIpc.tbHealthEducationProvided;
    if (!this.newIpc.tbHealthEducationProvided) {
      this.newIpc.tbSpecificMessage = '';
      this.newIpc.tbSpecificMessageIds = '';
      this.newIpc.tbToolsProvided = '';
      this.newIpc.tbToolsProvidedIds = '';
    }
    notifyListeners();
  }

  setTBSpecificMessage(List<dynamic> values) {
    List<SpecificMessage> messages = values.map((value) => specificMessages.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.tbSpecificMessage = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.tbSpecificMessageIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }

  setTBTrainingTools(List<dynamic> values) {
    List<MaterialModel> messages = values.map((value) => materials.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.tbToolsProvided = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.tbToolsProvidedIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }


  // Afya ya mama na mtoto Specific Issues
  setMNCHHealthProvided() {
    this.newIpc.mnhcHealthEducationProvided = !this.newIpc.mnhcHealthEducationProvided;
    if (!this.newIpc.mnhcHealthEducationProvided) {
      this.newIpc.mnchSpecificMessage = '';
      this.newIpc.mnchSpecificMessageIds = '';
      this.newIpc.mnchToolsProvided = '';
      this.newIpc.mnchToolsProvidedIds = '';
    }
    notifyListeners();
  }

  setMNCHSpecificMessage(List<dynamic> values) {
    List<SpecificMessage> messages = values.map((value) => specificMessages.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.mnchSpecificMessage = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.mnchSpecificMessageIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }

  setMNCHTrainingTools(List<dynamic> values) {
    List<MaterialModel> messages = values.map((value) => materials.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.mnchToolsProvided = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.mnchToolsProvidedIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }


  // Uzazi wa mpango Specific Issues
  setFPHealthProvided() {
    this.newIpc.healthEducationProvided = !this.newIpc.healthEducationProvided;
    if (!this.newIpc.healthEducationProvided) {
      this.newIpc.fpSpecificMessage = '';
      this.newIpc.fpSpecificMessageIds = '';
      this.newIpc.fpToolsProvided = '';
      this.newIpc.fpToolsProvidedIds = '';
    }
    notifyListeners();
  }

  setFPSpecificMessage(List<dynamic> values) {
    List<SpecificMessage> messages = values.map((value) => specificMessages.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.fpSpecificMessage = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.fpSpecificMessageIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }

  setFPTrainingTools(List<dynamic> values) {
    List<MaterialModel> messages = values.map((value) => materials.firstWhere((message) => message.swahiliName == value, orElse: () => null)).toList();
    this.newIpc.fpToolsProvided = messages.map((message) => message.swahiliName).toList().join(', ');
    this.newIpc.fpToolsProvidedIds = messages.map((message) => message.id).toList().join(';');
    notifyListeners();
  }



  List<SpecificMessage> getSpecificMessage(String educationType) => specificMessages.where((message) => message.educationType == educationType).toList();

  List<MaterialModel> getCanBeUsedForTraining() => materials.where((material) => material.usedForTraining).toList();

  saveInitialIpc() async {
    IpcDataProvider dbDataProvider = IpcDataProvider();
    await dbDataProvider.addOrUpdateIpc(this.newIpc);
    initilizeIpcs();
  }

  initilizeIpc([Ipc ipc]) {
    if (ipc != null) {
      setIpc(ipc);
      this.setWalengwa(ipc.materialUsed);
    } else {
      if (this.user != null)
        this.setIpc(new Ipc(
          enrollmentId: makeid(),
          id: makeid(),
          communityLeaderName: '',
          communityLeaderPhone: '',
          cso: this.user != null ? this.user.csoId : '',
          csoName: this.user != null ? getCsoName(this.user.csoId) : '',
          endTime: '',
          startTime: this.user != null ? this.user.chwType : '',
          facilitatorPhoneNumber:
              this.user != null ? this.user.phoneNumber : '',
          facilitatorName: this.user != null ? this.user.name : '',
          healthEducationProvided: false,
          gpsCordinateS: this.gpsCordinateS ?? '',
          gpsCordinatorE: this.gpsCordinatorE ?? '',
          gpsToolUsed: this.gpsToolUsed ?? '',
          hivHealthEducationProvided: false,
          malariaHealthEducationProvided: false,
          mnhcHealthEducationProvided: false,
          tbHealthEducationProvided: false,
          attendanceFemale_10_14: 0,
          attendanceFemale_15_17: 0,
          attendanceFemale_18_24: 0,
          attendanceFemale_25_30: 0,
          attendanceFemale_31_49: 0,
          attendanceFemale_50: 0,
          attendanceMale_10_14: 0,
          attendanceMale_15_17: 0,
          attendanceMale_18_24: 0,
          attendanceMale_25_30: 0,
          attendanceMale_31_49: 0,
          attendanceMale_50: 0,
          materialUsed: '',
          eventNumber: this.prepareSessionReference(),
          eventType: 'IPCC',
          eventPlace: '',
          specificMessage: '',
          targets: '',
          groupCrowdEducated: '',
          comments: '',
          region: this.user != null ? this.user.regionName : '',
          district: this.user != null ? this.user.districtName : '',
          ward: this.user != null ? this.user.wardName : '',
          organisationUnitId: this.user != null ? this.user.wardId : '',
          created: DateTime.now().toIso8601String(),
          act1Date: '',
          malariaSpecificMessage: '',
          malariaSpecificMessageIds: '',
          act2Date: '',
          hivSpecificMessage: '',
          hivSpecificMessageIds: '',
          act3Date: '',
          tbSpecificMessage: '',
          tbSpecificMessageIds: '',
          act4Date: '',
          mnchSpecificMessage: '',
          mnchSpecificMessageIds: '',
          act5Date: '',
          fpSpecificMessage: '',
          fpSpecificMessageIds: '',
          households: '',
          day1Card: '',
          day2Card: '',
          day3Card: '',
          day4Card: '',
          day5Card: '',
          day1Game: '',
          day2Game: '',
          day3Game: '',
          day4Game: '',
          day5Game: '',
          day1Material: '',
          day2Material: '',
          day3Material: '',
          day4Material: '',
          day5Material: '',
          malariaToolsProvided: '',
          malariaToolsProvidedIds: '',
          hivToolsProvided: '',
          hivToolsProvidedIds: '',
          tbToolsProvided: '',
          tbToolsProvidedIds: '',
          mnchToolsProvided: '',
          mnchToolsProvidedIds: '',
          fpToolsProvided: '',
          fpToolsProvidedIds: '',
          trainingItemUsed: '',
          isSynchronized: false,
          isCompleted: false
        ));
    }
  }
}
