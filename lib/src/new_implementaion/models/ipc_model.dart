import 'dart:convert';
import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/new_implementaion/database/tables/ipc_table.dart' as table;

class Ipc {
  String enrollmentId;
  String id;
  String communityLeaderName;
  String communityLeaderPhone;
  String cso;
  String csoName;
  String endTime;
  String startTime;
  String facilitatorPhoneNumber;
  String facilitatorName;
  bool healthEducationProvided;
  String gpsCordinateS;
  String gpsCordinatorE;
  String gpsToolUsed;
  bool hivHealthEducationProvided;
  bool malariaHealthEducationProvided;
  bool mnhcHealthEducationProvided;
  bool tbHealthEducationProvided;
  num attendanceFemale_10_14;
  num attendanceFemale_15_17;
  num attendanceFemale_18_24;
  num attendanceFemale_25_30;
  num attendanceFemale_31_49;
  num attendanceFemale_50;
  num attendanceMale_10_14;
  num attendanceMale_15_17;
  num attendanceMale_18_24;
  num attendanceMale_25_30;
  num attendanceMale_31_49;
  num attendanceMale_50;
  String materialUsed;
  String eventNumber;
  String eventType;
  String eventPlace;
  String specificMessage;
  String targets;
  String groupCrowdEducated;
  String comments;
  String region;
  String district;
  String ward;
  String organisationUnitId;
  String created;
  String act1Date;
  String malariaSpecificMessage;
  String malariaSpecificMessageIds;
  String act2Date;
  String hivSpecificMessage;
  String hivSpecificMessageIds;
  String act3Date;
  String tbSpecificMessage;
  String tbSpecificMessageIds;
  String act4Date;
  String mnchSpecificMessage;
  String mnchSpecificMessageIds;
  String act5Date;
  String fpSpecificMessage;
  String fpSpecificMessageIds;
  String households;
  String day1Card;
  String day2Card;
  String day3Card;
  String day4Card;
  String day5Card;
  String day1Game;
  String day2Game;
  String day3Game;
  String day4Game;
  String day5Game;
  String day1Material;
  String day2Material;
  String day3Material;
  String day4Material;
  String day5Material;
  String malariaToolsProvided;
  String malariaToolsProvidedIds;
  String hivToolsProvided;
  String hivToolsProvidedIds;
  String tbToolsProvided;
  String tbToolsProvidedIds;
  String mnchToolsProvided;
  String mnchToolsProvidedIds;
  String fpToolsProvided;
  String fpToolsProvidedIds;
  String trainingItemUsed;
  bool isSynchronized;
  bool isCompleted;

  Ipc({
    this.enrollmentId,
    this.id,
    this.communityLeaderName,
    this.communityLeaderPhone,
    this.cso,
    this.csoName,
    this.endTime,
    this.startTime,
    this.facilitatorPhoneNumber,
    this.facilitatorName,
    this.healthEducationProvided,
    this.gpsCordinateS,
    this.gpsCordinatorE,
    this.gpsToolUsed,
    this.hivHealthEducationProvided,
    this.malariaHealthEducationProvided,
    this.mnhcHealthEducationProvided,
    this.tbHealthEducationProvided,
    this.attendanceFemale_10_14,
    this.attendanceFemale_15_17,
    this.attendanceFemale_18_24,
    this.attendanceFemale_25_30,
    this.attendanceFemale_31_49,
    this.attendanceFemale_50,
    this.attendanceMale_10_14,
    this.attendanceMale_15_17,
    this.attendanceMale_18_24,
    this.attendanceMale_25_30,
    this.attendanceMale_31_49,
    this.attendanceMale_50,
    this.materialUsed,
    this.eventNumber,
    this.eventType,
    this.eventPlace,
    this.specificMessage,
    this.targets,
    this.groupCrowdEducated,
    this.comments,
    this.region,
    this.district,
    this.ward,
    this.organisationUnitId,
    this.created,
    this.act1Date,
    this.malariaSpecificMessage,
    this.malariaSpecificMessageIds,
    this.act2Date,
    this.hivSpecificMessage,
    this.hivSpecificMessageIds,
    this.act3Date,
    this.tbSpecificMessage,
    this.tbSpecificMessageIds,
    this.act4Date,
    this.mnchSpecificMessage,
    this.mnchSpecificMessageIds,
    this.act5Date,
    this.fpSpecificMessage,
    this.fpSpecificMessageIds,
    this.households,
    this.day1Card,
    this.day2Card,
    this.day3Card,
    this.day4Card,
    this.day5Card,
    this.day1Game,
    this.day2Game,
    this.day3Game,
    this.day4Game,
    this.day5Game,
    this.day1Material,
    this.day2Material,
    this.day3Material,
    this.day4Material,
    this.day5Material,
    this.malariaToolsProvided,
    this.malariaToolsProvidedIds,
    this.hivToolsProvided,
    this.hivToolsProvidedIds,
    this.tbToolsProvided,
    this.tbToolsProvidedIds,
    this.mnchToolsProvided,
    this.mnchToolsProvidedIds,
    this.fpToolsProvided,
    this.fpToolsProvidedIds,
    this.trainingItemUsed,
    this.isSynchronized,
    this.isCompleted,
  });

  factory Ipc.fromDatabase(Map<dynamic, dynamic> map) {
    return new Ipc(
      enrollmentId: map[table.columnEnrollmentId],
      id: map[table.columnId],
      communityLeaderName: map[table.columnCommunityLeaderName],
      communityLeaderPhone: map[table.columnCommunityLeaderPhone],
      cso: map[table.columnCso],
      csoName: map[table.columnCsoName],
      endTime: map[table.columnEndTime],
      startTime: map[table.columnStartTime],
      facilitatorPhoneNumber: map[table.columnFacilitatorPhoneNumber],
      facilitatorName: map[table.columnFacilitatorName],
      healthEducationProvided: map[table.columnHealthEducationProvided] == 1,
      gpsCordinateS: map[table.columnGpsCordinateS],
      gpsCordinatorE: map[table.columnGpsCordinatorE],
      gpsToolUsed: map[table.columnGpsToolUsed],
      hivHealthEducationProvided: map[table.columnHivHealthEducationProvided] == 1,
      malariaHealthEducationProvided: map[table.columnMalariaHealthEducationProvided] == 1,
      mnhcHealthEducationProvided: map[table.columnMnhcHealthEducationProvided] == 1,
      tbHealthEducationProvided: map[table.columnTbHealthEducationProvided] == 1,
      attendanceFemale_10_14: map[table.columnAttendanceFemale_10_14] is num ? map[table.columnAttendanceFemale_10_14] : getDoubleNumber(map[table.columnAttendanceFemale_10_14]),
      attendanceFemale_15_17: map[table.columnAttendanceFemale_15_17] is num ? map[table.columnAttendanceFemale_15_17] : getDoubleNumber(map[table.columnAttendanceFemale_15_17]),
      attendanceFemale_18_24: map[table.columnAttendanceFemale_18_24] is num ? map[table.columnAttendanceFemale_18_24] : getDoubleNumber(map[table.columnAttendanceFemale_18_24]),
      attendanceFemale_25_30: map[table.columnAttendanceFemale_25_30] is num ? map[table.columnAttendanceFemale_25_30] : getDoubleNumber(map[table.columnAttendanceFemale_25_30]),
      attendanceFemale_31_49: map[table.columnAttendanceFemale_31_49] is num ? map[table.columnAttendanceFemale_31_49] : getDoubleNumber(map[table.columnAttendanceFemale_31_49]),
      attendanceFemale_50: map[table.columnAttendanceFemale_50] is num ? map[table.columnAttendanceFemale_50] : getDoubleNumber(map[table.columnAttendanceFemale_50]),
      attendanceMale_10_14: map[table.columnAttendanceMale_10_14] is num ? map[table.columnAttendanceMale_10_14] : getDoubleNumber(map[table.columnAttendanceMale_10_14]),
      attendanceMale_15_17: map[table.columnAttendanceMale_15_17] is num ? map[table.columnAttendanceMale_15_17] : getDoubleNumber(map[table.columnAttendanceMale_15_17]),
      attendanceMale_18_24: map[table.columnAttendanceMale_18_24] is num ? map[table.columnAttendanceMale_18_24] : getDoubleNumber(map[table.columnAttendanceMale_18_24]),
      attendanceMale_25_30: map[table.columnAttendanceMale_25_30] is num ? map[table.columnAttendanceMale_25_30] : getDoubleNumber(map[table.columnAttendanceMale_25_30]),
      attendanceMale_31_49: map[table.columnAttendanceMale_31_49] is num ? map[table.columnAttendanceMale_31_49] : getDoubleNumber(map[table.columnAttendanceMale_31_49]),
      attendanceMale_50: map[table.columnAttendanceMale_50] is num ? map[table.columnAttendanceMale_50] : getDoubleNumber(map[table.columnAttendanceMale_50]),
      materialUsed: map[table.columnMaterialUsed],
      eventNumber: map[table.columnEventNumber],
      eventType: map[table.columnEventType],
      eventPlace: map[table.columnEventPlace],
      specificMessage: map[table.columnSpecificMessage],
      targets: map[table.columnTargets],
      groupCrowdEducated: map[table.columnGroupCrowdEducated],
      comments: map[table.columnComments],
      region: map[table.columnRegion],
      district: map[table.columnDistrict],
      ward: map[table.columnWard],
      organisationUnitId: map[table.columnOrganisationUnitId],
      created: map[table.columnCreated],
      act1Date: map[table.columnAct1Date],
      malariaSpecificMessage: map[table.columnMalariaSpecificMessage],
      malariaSpecificMessageIds: map[table.columnMalariaSpecificMessageIds],
      act2Date: map[table.columnAct2Date],
      hivSpecificMessage: map[table.columnHivSpecificMessage],
      hivSpecificMessageIds: map[table.columnHivSpecificMessageIds],
      act3Date: map[table.columnAct3Date],
      tbSpecificMessage: map[table.columnTbSpecificMessage],
      tbSpecificMessageIds: map[table.columnTbSpecificMessageIds],
      act4Date: map[table.columnAct4Date],
      mnchSpecificMessage: map[table.columnMnchSpecificMessage],
      mnchSpecificMessageIds: map[table.columnMnchSpecificMessageIds],
      act5Date: map[table.columnAct5Date],
      fpSpecificMessage: map[table.columnFpSpecificMessage],
      fpSpecificMessageIds: map[table.columnFpSpecificMessageIds],
      households: map[table.columnHouseholds],
      day1Card: map[table.columnDay1Card],
      day2Card: map[table.columnDay2Card],
      day3Card: map[table.columnDay3Card],
      day4Card: map[table.columnDay4Card],
      day5Card: map[table.columnDay5Card],
      day1Game: map[table.columnDay1Game],
      day2Game: map[table.columnDay2Game],
      day3Game: map[table.columnDay3Game],
      day4Game: map[table.columnDay4Game],
      day5Game: map[table.columnDay5Game],
      day1Material: map[table.columnDay1Material],
      day2Material: map[table.columnDay2Material],
      day3Material: map[table.columnDay3Material],
      day4Material: map[table.columnDay4Material],
      day5Material: map[table.columnDay5Material],
      malariaToolsProvided: map[table.columnMalariaToolsProvided],
      malariaToolsProvidedIds: map[table.columnMalariaToolsProvidedIds],
      hivToolsProvided: map[table.columnHivToolsProvided],
      hivToolsProvidedIds: map[table.columnHivToolsProvidedIds],
      tbToolsProvided: map[table.columnTbToolsProvided],
      tbToolsProvidedIds: map[table.columnTbToolsProvidedIds],
      mnchToolsProvided: map[table.columnMnchToolsProvided],
      mnchToolsProvidedIds: map[table.columnMnchToolsProvided],
      fpToolsProvided: map[table.columnMnchToolsProvidedIds],
      fpToolsProvidedIds: map[table.columnFpToolsProvided],
      trainingItemUsed: map[table.columnTrainingItemUsed],
      isSynchronized: map[table.columnIsSynchronized] == 1,
      isCompleted: map[table.columnIsCompleted] == 1,
    );
  }


  factory Ipc.fromServer(Map<dynamic, dynamic> map) {
    return new Ipc(
      enrollmentId: map[table.columnEnrollmentId],
      id: map[table.columnId],
      communityLeaderName: map[table.columnCommunityLeaderName],
      communityLeaderPhone: map[table.columnCommunityLeaderPhone],
      cso: map[table.columnCso],
      csoName: map[table.columnCsoName],
      endTime: map[table.columnEndTime],
      startTime: map[table.columnStartTime],
      facilitatorPhoneNumber: map[table.columnFacilitatorPhoneNumber],
      facilitatorName: map[table.columnFacilitatorName],
      healthEducationProvided: map[table.columnHealthEducationProvided],
      gpsCordinateS: map[table.columnGpsCordinateS].toString(),
      gpsCordinatorE: map[table.columnGpsCordinatorE].toString(),
      gpsToolUsed: map[table.columnGpsToolUsed],
      hivHealthEducationProvided: map[table.columnHivHealthEducationProvided],
      malariaHealthEducationProvided: map[table.columnMalariaHealthEducationProvided],
      mnhcHealthEducationProvided: map[table.columnMnhcHealthEducationProvided],
      tbHealthEducationProvided: map[table.columnTbHealthEducationProvided],
      attendanceFemale_10_14: map[table.columnAttendanceFemale_10_14] is num ? map[table.columnAttendanceFemale_10_14] : getDoubleNumber(map[table.columnAttendanceFemale_10_14]),
      attendanceFemale_15_17: map[table.columnAttendanceFemale_15_17] is num ? map[table.columnAttendanceFemale_15_17] : getDoubleNumber(map[table.columnAttendanceFemale_15_17]),
      attendanceFemale_18_24: map[table.columnAttendanceFemale_18_24] is num ? map[table.columnAttendanceFemale_18_24] : getDoubleNumber(map[table.columnAttendanceFemale_18_24]),
      attendanceFemale_25_30: map[table.columnAttendanceFemale_25_30] is num ? map[table.columnAttendanceFemale_25_30] : getDoubleNumber(map[table.columnAttendanceFemale_25_30]),
      attendanceFemale_31_49: map[table.columnAttendanceFemale_31_49] is num ? map[table.columnAttendanceFemale_31_49] : getDoubleNumber(map[table.columnAttendanceFemale_31_49]),
      attendanceFemale_50: map[table.columnAttendanceFemale_50] is num ? map[table.columnAttendanceFemale_50] : getDoubleNumber(map[table.columnAttendanceFemale_50]),
      attendanceMale_10_14: map[table.columnAttendanceMale_10_14] is num ? map[table.columnAttendanceMale_10_14] : getDoubleNumber(map[table.columnAttendanceMale_10_14]),
      attendanceMale_15_17: map[table.columnAttendanceMale_15_17] is num ? map[table.columnAttendanceMale_15_17] : getDoubleNumber(map[table.columnAttendanceMale_15_17]),
      attendanceMale_18_24: map[table.columnAttendanceMale_18_24] is num ? map[table.columnAttendanceMale_18_24] : getDoubleNumber(map[table.columnAttendanceMale_18_24]),
      attendanceMale_25_30: map[table.columnAttendanceMale_25_30] is num ? map[table.columnAttendanceMale_25_30] : getDoubleNumber(map[table.columnAttendanceMale_25_30]),
      attendanceMale_31_49: map[table.columnAttendanceMale_31_49] is num ? map[table.columnAttendanceMale_31_49] : getDoubleNumber(map[table.columnAttendanceMale_31_49]),
      attendanceMale_50: map[table.columnAttendanceMale_50] is num ? map[table.columnAttendanceMale_50] : getDoubleNumber(map[table.columnAttendanceMale_50]),
      materialUsed: map[table.columnMaterialUsed],
      eventNumber: map[table.columnEventNumber],
      eventType: map[table.columnEventType],
      eventPlace: map[table.columnEventPlace],
      specificMessage: map[table.columnSpecificMessage],
      targets: map[table.columnTargets],
      groupCrowdEducated: map[table.columnGroupCrowdEducated],
      comments: map[table.columnComments],
      region: map[table.columnRegion],
      district: map[table.columnDistrict],
      ward: map[table.columnWard],
      organisationUnitId: map[table.columnOrganisationUnitId],
      created: map[table.columnCreated],
      act1Date: map[table.columnAct1Date].toString(),
      malariaSpecificMessage: map[table.columnMalariaSpecificMessage],
      malariaSpecificMessageIds: map[table.columnMalariaSpecificMessageIds],
      act2Date: map[table.columnAct2Date].toString(),
      hivSpecificMessage: map[table.columnHivSpecificMessage],
      hivSpecificMessageIds: map[table.columnHivSpecificMessageIds],
      act3Date: map[table.columnAct3Date].toString(),
      tbSpecificMessage: map[table.columnTbSpecificMessage],
      tbSpecificMessageIds: map[table.columnTbSpecificMessageIds],
      act4Date: map[table.columnAct4Date].toString(),
      mnchSpecificMessage: map[table.columnMnchSpecificMessage],
      mnchSpecificMessageIds: map[table.columnMnchSpecificMessageIds],
      act5Date: map[table.columnAct5Date].toString(),
      fpSpecificMessage: map[table.columnFpSpecificMessage],
      fpSpecificMessageIds: map[table.columnFpSpecificMessageIds],
      households: map[table.columnHouseholds],
      day1Card: map[table.columnDay1Card],
      day2Card: map[table.columnDay2Card],
      day3Card: map[table.columnDay3Card],
      day4Card: map[table.columnDay4Card],
      day5Card: map[table.columnDay5Card],
      day1Game: map[table.columnDay1Game],
      day2Game: map[table.columnDay2Game],
      day3Game: map[table.columnDay3Game],
      day4Game: map[table.columnDay4Game],
      day5Game: map[table.columnDay5Game],
      day1Material: map[table.columnDay1Material],
      day2Material: map[table.columnDay2Material],
      day3Material: map[table.columnDay3Material],
      day4Material: map[table.columnDay4Material],
      day5Material: map[table.columnDay5Material],
      malariaToolsProvided: map[table.columnMalariaToolsProvided],
      malariaToolsProvidedIds: map[table.columnMalariaToolsProvidedIds],
      hivToolsProvided: map[table.columnHivToolsProvided],
      hivToolsProvidedIds: map[table.columnHivToolsProvidedIds],
      tbToolsProvided: map[table.columnTbToolsProvided],
      tbToolsProvidedIds: map[table.columnTbToolsProvidedIds],
      mnchToolsProvided: map[table.columnMnchToolsProvided],
      mnchToolsProvidedIds: map[table.columnMnchToolsProvided],
      fpToolsProvided: map[table.columnMnchToolsProvidedIds],
      fpToolsProvidedIds: map[table.columnFpToolsProvided],
      trainingItemUsed: map[table.columnTrainingItemUsed],
      isSynchronized: map[table.columnIsSynchronized],
      isCompleted: map[table.columnIsCompleted],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnEnrollmentId: enrollmentId,
      table.columnId: id,
      table.columnCommunityLeaderName: communityLeaderName,
      table.columnCommunityLeaderPhone: communityLeaderPhone,
      table.columnCso: cso,
      table.columnCsoName: csoName,
      table.columnEndTime: endTime,
      table.columnStartTime: startTime,
      table.columnFacilitatorPhoneNumber: facilitatorPhoneNumber,
      table.columnFacilitatorName: facilitatorName,
      table.columnHealthEducationProvided: healthEducationProvided == true ? 1 : 0,
      table.columnGpsCordinateS: gpsCordinateS,
      table.columnGpsCordinatorE: gpsCordinatorE,
      table.columnGpsToolUsed: gpsToolUsed,
      table.columnHivHealthEducationProvided: hivHealthEducationProvided == true ? 1 : 0,
      table.columnMalariaHealthEducationProvided: malariaHealthEducationProvided == true ? 1 : 0,
      table.columnMnhcHealthEducationProvided: mnhcHealthEducationProvided == true ? 1 : 0,
      table.columnTbHealthEducationProvided: tbHealthEducationProvided == true ? 1 : 0,
      table.columnAttendanceFemale_10_14: attendanceFemale_10_14,
      table.columnAttendanceFemale_15_17: attendanceFemale_15_17,
      table.columnAttendanceFemale_18_24: attendanceFemale_18_24,
      table.columnAttendanceFemale_25_30: attendanceFemale_25_30,
      table.columnAttendanceFemale_31_49: attendanceFemale_31_49,
      table.columnAttendanceFemale_50: attendanceFemale_50,
      table.columnAttendanceMale_10_14: attendanceMale_10_14,
      table.columnAttendanceMale_15_17: attendanceMale_15_17,
      table.columnAttendanceMale_18_24: attendanceMale_18_24,
      table.columnAttendanceMale_25_30: attendanceMale_25_30,
      table.columnAttendanceMale_31_49: attendanceMale_31_49,
      table.columnAttendanceMale_50: attendanceMale_50,
      table.columnMaterialUsed: materialUsed,
      table.columnEventNumber: eventNumber,
      table.columnEventType: eventType,
      table.columnEventPlace: eventPlace,
      table.columnSpecificMessage: specificMessage,
      table.columnTargets: targets,
      table.columnGroupCrowdEducated: groupCrowdEducated,
      table.columnComments: comments,
      table.columnRegion: region,
      table.columnDistrict: district,
      table.columnWard: ward,
      table.columnOrganisationUnitId: organisationUnitId,
      table.columnCreated: created,
      table.columnAct1Date: act1Date,
      table.columnMalariaSpecificMessage: malariaSpecificMessage,
      table.columnMalariaSpecificMessageIds: malariaSpecificMessageIds,
      table.columnAct2Date: act2Date,
      table.columnHivSpecificMessage: hivSpecificMessage,
      table.columnHivSpecificMessageIds: hivSpecificMessageIds,
      table.columnAct3Date: act3Date,
      table.columnTbSpecificMessage: tbSpecificMessage,
      table.columnTbSpecificMessageIds: tbSpecificMessageIds,
      table.columnAct4Date: act4Date,
      table.columnMnchSpecificMessage: mnchSpecificMessage,
      table.columnMnchSpecificMessageIds: mnchSpecificMessageIds,
      table.columnAct5Date: act5Date,
      table.columnFpSpecificMessage: fpSpecificMessage,
      table.columnFpSpecificMessageIds: fpSpecificMessageIds,
      table.columnHouseholds: households,
      table.columnDay1Card: day1Card,
      table.columnDay2Card: day2Card,
      table.columnDay3Card: day3Card,
      table.columnDay4Card: day4Card,
      table.columnDay5Card: day5Card,
      table.columnDay1Game: day1Game,
      table.columnDay2Game: day2Game,
      table.columnDay3Game: day3Game,
      table.columnDay4Game: day4Game,
      table.columnDay5Game: day5Game,
      table.columnDay1Material: day1Material,
      table.columnDay2Material: day2Material,
      table.columnDay3Material: day3Material,
      table.columnDay4Material: day4Material,
      table.columnDay5Material: day5Material,
      table.columnMalariaToolsProvided: malariaToolsProvided,
      table.columnMalariaToolsProvidedIds: malariaToolsProvidedIds,
      table.columnHivToolsProvided: hivToolsProvided,
      table.columnHivToolsProvidedIds: hivToolsProvidedIds,
      table.columnTbToolsProvided: tbToolsProvided,
      table.columnTbToolsProvidedIds: tbToolsProvidedIds,
      table.columnMnchToolsProvided: mnchToolsProvided,
      table.columnMnchToolsProvidedIds: mnchToolsProvidedIds,
      table.columnFpToolsProvided: fpToolsProvided,
      table.columnFpToolsProvidedIds: fpToolsProvidedIds,
      table.columnTrainingItemUsed: trainingItemUsed,
      table.columnIsSynchronized: isSynchronized == true ? 1 : 0,
      table.columnIsCompleted: isCompleted == true ? 1 : 0,
    };
  }

  String getEducationProvidedDetailed() {
    var educationProvided = [];
    if (hivHealthEducationProvided) {
      educationProvided.add('VVU ($hivSpecificMessage) ');
    }
    if (malariaHealthEducationProvided) {
      educationProvided.add('Malaria ($malariaSpecificMessage) ');
    }
    if (tbHealthEducationProvided) {
      educationProvided.add('TB ($tbSpecificMessage) ');
    }
    if (mnhcHealthEducationProvided) {
      educationProvided.add('Afya Ya Mama, Baba na Mtoto ($mnchSpecificMessage) ');
    }
    if (healthEducationProvided) {
      educationProvided.add('Uzazi Wa Mpango ($fpSpecificMessage) ');
    }
    return educationProvided.join(', ');
  }

  String getEducationToolsDetailed() {
    var educationProvided = [];
    if (hivHealthEducationProvided) {
      educationProvided.add('VVU ($hivToolsProvided) ');
    }
    if (malariaHealthEducationProvided) {
      educationProvided.add('Malaria ($malariaToolsProvided) ');
    }
    if (tbHealthEducationProvided) {
      educationProvided.add('TB ($fpToolsProvided) ');
    }
    if (mnhcHealthEducationProvided) {
      educationProvided.add('Afya Ya Mama, Baba na Mtoto ($mnchToolsProvided) ');
    }
    if (healthEducationProvided) {
      educationProvided.add('Uzazi Wa Mpango ($fpToolsProvided) ');
    }
    return educationProvided.join(', ');
  }

  String getEducationProvided() {
    var educationProvided = [];
    if (hivHealthEducationProvided) {
      educationProvided.add('VVU');
    }
    if (malariaHealthEducationProvided) {
      educationProvided.add('Malaria');
    }
    if (tbHealthEducationProvided) {
      educationProvided.add('TB');
    }
    if (mnhcHealthEducationProvided) {
      educationProvided.add('Afya Ya Mama, Baba na Mtoto');
    }
    if (healthEducationProvided) {
      educationProvided.add('Uzazi Wa Mpango');
    }
    return educationProvided.join(', ');
  }



  @override
  String toString() {
    return '${eventNumber}';
  }
}
