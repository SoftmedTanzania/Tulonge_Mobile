final String tableName = "ipc";
final String columnEnrollmentId = "enrollment_id";
final String columnId = "id";
final String columnCommunityLeaderName = "community_leader_name";
final String columnCommunityLeaderPhone = "community_leader_phone";
final String columnCso = "cso";
final String columnCsoName = "cso_name";
final String columnEndTime = "end_time";
final String columnStartTime = "start_time";
final String columnFacilitatorPhoneNumber = "facilitator_phone_number";
final String columnFacilitatorName = "facilitator_name";
final String columnHealthEducationProvided = "health_education_provided"; // used for family planning
final String columnGpsCordinateS = "gps_cordinator_s";
final String columnGpsCordinatorE = "gps_cordinator_e";
final String columnGpsToolUsed = "gps_tool_used";
final String columnHivHealthEducationProvided = "hiv_health_education_provided";
final String columnMalariaHealthEducationProvided = "malaria_health_education_provided";
final String columnMnhcHealthEducationProvided = "mnhc_health_education_provided";
final String columnTbHealthEducationProvided = "tb_health_education_provided";
final String columnAttendanceFemale_10_14 = "attendance_female_10_14";
final String columnAttendanceFemale_15_17 = "attendance_female_15_17";
final String columnAttendanceFemale_18_24 = "attendance_female_18_24";
final String columnAttendanceFemale_25_30 = "attendance_female_25_30";
final String columnAttendanceFemale_31_49 = "attendance_female_31_49";
final String columnAttendanceFemale_50 = "attendance_female_50";
final String columnAttendanceMale_10_14 = "attendance_male_10_14";
final String columnAttendanceMale_15_17 = "attendance_male_15_17";
final String columnAttendanceMale_18_24 = "attendance_male_18_24";
final String columnAttendanceMale_25_30 = "attendance_male_25_30";
final String columnAttendanceMale_31_49 = "attendance_male_31_49";
final String columnAttendanceMale_50 = "attendance_male_50";
final String columnMaterialUsed = "matarial_used";
final String columnEventNumber = "event_number";
final String columnEventType = "event_type";
final String columnEventPlace = "event_place";
final String columnSpecificMessage = "specific_message";
final String columnTargets = "targets";
final String columnGroupCrowdEducated = "group_crowd_educated";
final String columnComments = "comments";
final String columnRegion = "region";
final String columnDistrict = "district";
final String columnWard = "ward";
final String columnOrganisationUnitId = "organisation_unit_id";
final String columnCreated = "created";
final String columnAct1Date = "act1_date";
final String columnMalariaSpecificMessage = "malaria_specific_message";
final String columnMalariaSpecificMessageIds = "malaria_specific_message_ids";
final String columnAct2Date = "act2_date";
final String columnHivSpecificMessage = "hiv_specific_message";
final String columnHivSpecificMessageIds = "hiv_specific_message_ids";
final String columnAct3Date = "act3_date";
final String columnTbSpecificMessage = "tb_specific_message";
final String columnTbSpecificMessageIds = "tb_specific_message_ids";
final String columnAct4Date = "act4_date";
final String columnMnchSpecificMessage = "mnch_specific_message";
final String columnMnchSpecificMessageIds = "mnch_specific_message_ids";
final String columnAct5Date = "act5_date";
final String columnFpSpecificMessage = "fp_specific_message";
final String columnFpSpecificMessageIds = "fp_specific_message_ids";
final String columnHouseholds = "households";
final String columnDay1Card = "day1_card";
final String columnDay2Card = "day2_card";
final String columnDay3Card = "day3_card";
final String columnDay4Card = "day4_card";
final String columnDay5Card = "day5_card";
final String columnDay1Game = "day1_game";
final String columnDay2Game = "day2_game";
final String columnDay3Game = "day3_game";
final String columnDay4Game = "day4_game";
final String columnDay5Game = "day5_game";
final String columnDay1Material = "day1_material";
final String columnDay2Material = "day2_material";
final String columnDay3Material = "day3_material";
final String columnDay4Material = "day4_material";
final String columnDay5Material = "day5_material";
final String columnMalariaToolsProvided = "malaria_tools_provided";
final String columnMalariaToolsProvidedIds = "malaria_tools_provided_ids";
final String columnHivToolsProvided = "hiv_tools_provided";
final String columnHivToolsProvidedIds = "hiv_tools_provided_ids";
final String columnTbToolsProvided = "tb_tools_provided";
final String columnTbToolsProvidedIds = "tb_tools_provided_ids";
final String columnMnchToolsProvided = "mnch_tools_provided";
final String columnMnchToolsProvidedIds = "mnch_tools_provided_ids";
final String columnFpToolsProvided = "fp_tools_provided";
final String columnFpToolsProvidedIds = "fp_tools_provided_ids";
final String columnTrainingItemUsed = "training_item_used";
final String columnIsSynchronized = "is_synchronized";
final String columnIsCompleted = "is_completed";

final List<String> columns = [
  columnEnrollmentId,
  columnId,
  columnCommunityLeaderName,
  columnCommunityLeaderPhone,
  columnCso,
  columnCsoName,
  columnEndTime,
  columnStartTime,
  columnFacilitatorPhoneNumber,
  columnFacilitatorName,
  columnHealthEducationProvided, // used for family planning
  columnGpsCordinateS,
  columnGpsCordinatorE,
  columnGpsToolUsed,
  columnHivHealthEducationProvided,
  columnMalariaHealthEducationProvided,
  columnMnhcHealthEducationProvided,
  columnTbHealthEducationProvided,
  columnAttendanceFemale_10_14,
  columnAttendanceFemale_15_17,
  columnAttendanceFemale_18_24,
  columnAttendanceFemale_25_30,
  columnAttendanceFemale_31_49,
  columnAttendanceFemale_50,
  columnAttendanceMale_10_14,
  columnAttendanceMale_15_17,
  columnAttendanceMale_18_24,
  columnAttendanceMale_25_30,
  columnAttendanceMale_31_49,
  columnAttendanceMale_50,
  columnMaterialUsed,
  columnEventNumber,
  columnEventType,
  columnEventPlace,
  columnSpecificMessage,
  columnTargets,
  columnGroupCrowdEducated,
  columnComments,
  columnRegion,
  columnDistrict,
  columnWard,
  columnOrganisationUnitId,
  columnCreated,
  columnAct1Date,
  columnMalariaSpecificMessage,
  columnMalariaSpecificMessageIds,
  columnAct2Date,
  columnHivSpecificMessage,
  columnHivSpecificMessageIds,
  columnAct3Date,
  columnTbSpecificMessage,
  columnTbSpecificMessageIds,
  columnAct4Date,
  columnMnchSpecificMessage,
  columnMnchSpecificMessageIds,
  columnAct5Date,
  columnFpSpecificMessage,
  columnFpSpecificMessageIds,
  columnHouseholds,
  columnDay1Card,
  columnDay2Card,
  columnDay3Card,
  columnDay4Card,
  columnDay5Card,
  columnDay1Game,
  columnDay2Game,
  columnDay3Game,
  columnDay4Game,
  columnDay5Game,
  columnDay1Material,
  columnDay2Material,
  columnDay3Material,
  columnDay4Material,
  columnDay5Material,
  columnMalariaToolsProvided,
  columnMalariaToolsProvidedIds,
  columnHivToolsProvided,
  columnHivToolsProvidedIds,
  columnTbToolsProvided,
  columnTbToolsProvidedIds,
  columnMnchToolsProvided,
  columnMnchToolsProvidedIds,
  columnFpToolsProvided,
  columnFpToolsProvidedIds,
  columnTrainingItemUsed,
  columnIsSynchronized,
  columnIsCompleted
];

final Map<String, dynamic> columnsDefinition = {
  columnEnrollmentId: 'TEXT',
  columnId: 'TEXT',
  columnCommunityLeaderName: 'TEXT',
  columnCommunityLeaderPhone: 'TEXT',
  columnCso: 'TEXT',
  columnCsoName: 'TEXT',
  columnEndTime: 'TEXT',
  columnStartTime: 'TEXT',
  columnFacilitatorPhoneNumber: 'TEXT',
  columnFacilitatorName: 'TEXT',
  columnHealthEducationProvided: 'INTEGER', // used for family planning
  columnGpsCordinateS: 'TEXT',
  columnGpsCordinatorE: 'TEXT',
  columnGpsToolUsed: 'TEXT',
  columnHivHealthEducationProvided: 'INTEGER',
  columnMalariaHealthEducationProvided: 'INTEGER',
  columnMnhcHealthEducationProvided: 'INTEGER',
  columnTbHealthEducationProvided: 'INTEGER',
  columnAttendanceFemale_10_14: 'NUMERIC',
  columnAttendanceFemale_15_17: 'NUMERIC',
  columnAttendanceFemale_18_24: 'NUMERIC',
  columnAttendanceFemale_25_30: 'NUMERIC',
  columnAttendanceFemale_31_49: 'NUMERIC',
  columnAttendanceFemale_50: 'NUMERIC',
  columnAttendanceMale_10_14: 'NUMERIC',
  columnAttendanceMale_15_17: 'NUMERIC',
  columnAttendanceMale_18_24: 'NUMERIC',
  columnAttendanceMale_25_30: 'NUMERIC',
  columnAttendanceMale_31_49: 'NUMERIC',
  columnAttendanceMale_50: 'NUMERIC',
  columnMaterialUsed: 'TEXT',
  columnEventNumber: 'TEXT',
  columnEventType: 'TEXT',
  columnEventPlace: 'TEXT',
  columnSpecificMessage: 'TEXT',
  columnTargets: 'TEXT',
  columnGroupCrowdEducated: 'TEXT',
  columnComments: 'TEXT',
  columnRegion: 'TEXT',
  columnDistrict: 'TEXT',
  columnWard: 'TEXT',
  columnOrganisationUnitId: 'TEXT',
  columnCreated: 'TEXT',
  columnAct1Date: 'TEXT',
  columnMalariaSpecificMessage: 'TEXT',
  columnMalariaSpecificMessageIds: 'TEXT',
  columnAct2Date: 'TEXT',
  columnHivSpecificMessage: 'TEXT',
  columnHivSpecificMessageIds: 'TEXT',
  columnAct3Date: 'TEXT',
  columnTbSpecificMessage: 'TEXT',
  columnTbSpecificMessageIds: 'TEXT',
  columnAct4Date: 'TEXT',
  columnMnchSpecificMessage: 'TEXT',
  columnMnchSpecificMessageIds: 'TEXT',
  columnAct5Date: 'TEXT',
  columnFpSpecificMessage: 'TEXT',
  columnFpSpecificMessageIds: 'TEXT',
  columnHouseholds: 'TEXT',
  columnDay1Card: 'TEXT',
  columnDay2Card: 'TEXT',
  columnDay3Card: 'TEXT',
  columnDay4Card: 'TEXT',
  columnDay5Card: 'TEXT',
  columnDay1Game: 'TEXT',
  columnDay2Game: 'TEXT',
  columnDay3Game: 'TEXT',
  columnDay4Game: 'TEXT',
  columnDay5Game: 'TEXT',
  columnDay1Material: 'TEXT',
  columnDay2Material: 'TEXT',
  columnDay3Material: 'TEXT',
  columnDay4Material: 'TEXT',
  columnDay5Material: 'TEXT',
  columnMalariaToolsProvided: 'TEXT',
  columnMalariaToolsProvidedIds: 'TEXT',
  columnHivToolsProvided: 'TEXT',
  columnHivToolsProvidedIds: 'TEXT',
  columnTbToolsProvided: 'TEXT',
  columnTbToolsProvidedIds: 'TEXT',
  columnMnchToolsProvided: 'TEXT',
  columnMnchToolsProvidedIds: 'TEXT',
  columnFpToolsProvided: 'TEXT',
  columnFpToolsProvidedIds: 'TEXT',
  columnTrainingItemUsed: 'TEXT',
  columnIsSynchronized: 'INTEGER',
  columnIsCompleted: 'INTEGER',
};