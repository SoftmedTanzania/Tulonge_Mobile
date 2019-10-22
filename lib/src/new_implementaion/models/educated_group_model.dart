import 'package:chw/src/new_implementaion/database/tables/educated_group_table.dart' as table;

class EducatedGroup {
  final String id;
  final String name;
  final String swahiliName;
  final String status;

  EducatedGroup({
    this.id,
    this.name,
    this.swahiliName,
    this.status,
  });

  factory EducatedGroup.fromDatabase(Map<dynamic, dynamic> map) {
    return new EducatedGroup(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      status: map[table.columnStatus],
    );
  }

  factory EducatedGroup.fromServer(Map<dynamic, dynamic> map) {
    return new EducatedGroup(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      status: map[table.columnStatus],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnSwahiliName: swahiliName,
      table.columnStatus: status,
    };
  }

  @override
  String toString() {
    return '${swahiliName}';
  }
}
