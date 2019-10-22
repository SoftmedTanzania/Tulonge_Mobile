final String tableName = "cso";
final String columnId = "id";
final String columnName = "name";
final String columnOrganisationUnitId = "organisation_unit_id";
final String columnStatus = "status";

final List<String> columns = [
  columnId,
  columnName,
  columnOrganisationUnitId,
  columnStatus
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnStatus: 'TEXT',
  columnOrganisationUnitId : 'TEXT'
};