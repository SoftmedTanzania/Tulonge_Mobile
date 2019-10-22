final String tableName = "specific_message";
final String columnId = "id";
final String columnName = "name";
final String columnSwahiliName = "swahili_name";
final String columnEducationTypeId = "educationTypeId";
final String columnIdentifier = "identifier";
final String columnEducationType = "education_type";
final String columnStatus = "status";

final List<String> columns = [
  columnId,
  columnName,
  columnSwahiliName,
  columnEducationTypeId,
  columnEducationType,
  columnIdentifier,
  columnStatus
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnStatus: 'TEXT',
  columnSwahiliName : 'TEXT',
  columnEducationTypeId : 'TEXT',
  columnIdentifier : 'TEXT',
  columnEducationType : 'TEXT'
};