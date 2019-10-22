import 'package:chw/src/new_implementaion/database/tables/participant_table.dart'
    as table;

class Participant {
  String id;
  String name;
  String age;
  String gender;
  String phoneNumber;
  bool referred;
  String maritalStatus;
  String eventNumber;
  String organisationUnitId;
  String referralReason;
  String referredTo;
  String created;
  bool act1Attendance;
  bool act2Attendance;
  bool act3Attendance;
  bool act4Attendance;
  bool act5Attendance;
  bool isPregnant;

  Participant({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.phoneNumber,
    this.referred,
    this.maritalStatus,
    this.eventNumber,
    this.organisationUnitId,
    this.referralReason,
    this.referredTo,
    this.created,
    this.act1Attendance,
    this.act2Attendance,
    this.act3Attendance,
    this.act4Attendance,
    this.act5Attendance,
    this.isPregnant,
  });

  factory Participant.fromServer(Map<String, dynamic> map) {
    return new Participant(
      id: map[table.columnId],
      name: map[table.columnName],
      age: map[table.columnAge],
      gender: map[table.columnGender],
      phoneNumber: map[table.columnPhoneNumber],
      referred: map[table.columnReferred],
      maritalStatus: map[table.columnMaritalStatus],
      eventNumber: map[table.columnEventNumber],
      organisationUnitId: map[table.columnOrganisationUnitId],
      referralReason: map[table.columnReferralReason],
      referredTo: map[table.columnReferredTo],
      created: map[table.columnCreated],
      act1Attendance: map[table.columnAct1Attendance],
      act2Attendance: map[table.columnAct2Attendance],
      act3Attendance: map[table.columnAct3Attendance],
      act4Attendance: map[table.columnAct4Attendance],
      act5Attendance: map[table.columnAct5Attendance],
      isPregnant: map[table.columnIsPregnant],
    );
  }

  factory Participant.fromDatabase(Map<String, dynamic> map) {
    return new Participant(
      id: map[table.columnId],
      name: map[table.columnName],
      age: map[table.columnAge],
      gender: map[table.columnGender],
      phoneNumber: map[table.columnPhoneNumber],
      referred: map[table.columnReferred] == 1,
      maritalStatus: map[table.columnMaritalStatus],
      eventNumber: map[table.columnEventNumber],
      organisationUnitId: map[table.columnOrganisationUnitId],
      referralReason: map[table.columnReferralReason],
      referredTo: map[table.columnReferredTo],
      created: map[table.columnCreated],
      act1Attendance: map[table.columnAct1Attendance] == 1,
      act2Attendance: map[table.columnAct2Attendance] == 1,
      act3Attendance: map[table.columnAct3Attendance] == 1,
      act4Attendance: map[table.columnAct4Attendance] == 1,
      act5Attendance: map[table.columnAct5Attendance] == 1,
      isPregnant: map[table.columnIsPregnant] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnAge: age,
      table.columnGender: gender,
      table.columnPhoneNumber: phoneNumber,
      table.columnReferred: referred == true ? 1 : 0,
      table.columnMaritalStatus: maritalStatus,
      table.columnEventNumber: eventNumber,
      table.columnOrganisationUnitId: organisationUnitId,
      table.columnReferralReason: referralReason,
      table.columnReferredTo: referredTo,
      table.columnCreated: created,
      table.columnAct1Attendance: act1Attendance == true ? 1 : 0,
      table.columnAct2Attendance: act2Attendance == true ? 1 : 0,
      table.columnAct3Attendance: act3Attendance == true ? 1 : 0,
      table.columnAct4Attendance: act4Attendance == true ? 1 : 0,
      table.columnAct5Attendance: act5Attendance == true ? 1 : 0,
      table.columnIsPregnant: isPregnant == true ? 1 : 0,
    };
  }

  @override
  String toString() {
    return '${name}';
  }
}
