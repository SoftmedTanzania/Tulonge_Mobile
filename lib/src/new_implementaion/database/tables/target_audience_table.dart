final String tableName = "target_audience";
final String columnId = "id";
final String columnName = "name";
final String columnSwahiliName = "swahili_name";
final String columnMainGroup = "main_group";
final String columnStatus = "status";

final List<String> columns = [
  columnId,
  columnName,
  columnSwahiliName,
  columnMainGroup,
  columnStatus
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnStatus: 'TEXT',
  columnSwahiliName : 'TEXT',
  columnMainGroup : 'TEXT'
};