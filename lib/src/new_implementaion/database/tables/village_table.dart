final String tableName = "villages";
final String columnId = "id";
final String columnName = "name";
final String columnLeaderName = "leader_name";
final String columnLeaderPhone = "leader_phone";

final List<String> columns = [
  columnId,
  columnName,
  columnLeaderName,
  columnLeaderPhone
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnLeaderName: 'TEXT',
  columnLeaderPhone : 'TEXT'
};