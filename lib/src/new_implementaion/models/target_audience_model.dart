import 'package:chw/src/new_implementaion/database/tables/target_audience_table.dart' as table;

class TargetAudience {
  final String id;
  final String name;
  final String swahiliName;
  final String mainGroup;
  final String status;

  TargetAudience({
    this.id,
    this.name,
    this.swahiliName,
    this.mainGroup,
    this.status,
  });

  factory TargetAudience.fromDatabase(Map<dynamic, dynamic> map) {
    return new TargetAudience(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      mainGroup: map[table.columnMainGroup],
      status: map[table.columnStatus],
    );
  }

  factory TargetAudience.fromServer(Map<dynamic, dynamic> map) {
    return new TargetAudience(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      mainGroup: map[table.columnMainGroup],
      status: map[table.columnStatus],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnSwahiliName: swahiliName,
      table.columnMainGroup: mainGroup,
      table.columnStatus: status,
    };
  }

  @override
  String toString() {
    return '${swahiliName}';
  }
}