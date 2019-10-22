final String tableName = "participants";
final String columnId = "id";
final String columnName = "name";
final String columnAge = "age";
final String columnGender = "gender";
final String columnPhoneNumber = "phone_number";
final String columnReferred = "referred";
final String columnMaritalStatus = "marital_status";
final String columnEventNumber = "event_number";
final String columnOrganisationUnitId = "organisation_unit_id";
final String columnReferralReason = "referral_reason";
final String columnReferredTo = "referred_to";
final String columnCreated = "created";
final String columnAct1Attendance = "act1_attendance";
final String columnAct2Attendance = "act2_attendance";
final String columnAct3Attendance = "act3_attendance";
final String columnAct4Attendance = "act4_attendance";
final String columnAct5Attendance = "act5_attendance";
final String columnIsPregnant = "is_pregnant";

final List<String> columns = [
  columnId,
  columnName,
  columnAge,
  columnGender,
  columnPhoneNumber,
  columnReferred,
  columnMaritalStatus,
  columnEventNumber,
  columnOrganisationUnitId,
  columnReferralReason,
  columnReferredTo,
  columnCreated,
  columnAct1Attendance,
  columnAct2Attendance,
  columnAct3Attendance,
  columnAct4Attendance,
  columnAct5Attendance,
  columnIsPregnant
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnAge: 'TEXT',
  columnGender: 'TEXT',
  columnPhoneNumber: 'TEXT',
  columnReferred: 'INTEGER',
  columnMaritalStatus: 'TEXT',
  columnEventNumber: 'TEXT',
  columnOrganisationUnitId: 'TEXT',
  columnReferralReason: 'TEXT',
  columnReferredTo: 'TEXT',
  columnCreated: 'TEXT',
  columnAct1Attendance: 'INTEGER',
  columnAct2Attendance: 'INTEGER',
  columnAct3Attendance: 'INTEGER',
  columnAct4Attendance: 'INTEGER',
  columnAct5Attendance: 'INTEGER',
  columnIsPregnant: 'INTEGER'
};