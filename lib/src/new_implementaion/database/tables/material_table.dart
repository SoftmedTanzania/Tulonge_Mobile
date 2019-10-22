final String tableName = "material";
final String columnId = "id";
final String columnName = "name";
final String columnSwahiliName = "swahili_name";
final String columnStatus = "status";
final String columnCanDistribute = "can_distribute";
final String columnUsedForTraining = "used_for_training";

final List<String> columns =[
  columnId,
  columnName,
  columnSwahiliName,
  columnStatus,
  columnCanDistribute,
  columnUsedForTraining,
];

final Map<String, dynamic> columnsDefinition = {
  columnId: 'TEXT',
  columnName: 'TEXT',
  columnSwahiliName: 'TEXT',
  columnStatus: 'TEXT',
  columnCanDistribute: 'INTEGER',
  columnUsedForTraining: 'INTEGER',
};