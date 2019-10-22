import 'package:chw/src/new_implementaion/database/tables/education_type_table.dart' as table;

class EducationType {
  final String id;
  final String name;
  final String swahiliName;
  final String status;

  EducationType({
    this.id,
    this.name,
    this.swahiliName,
    this.status,
  });

  factory EducationType.fromDatabase(Map<dynamic, dynamic> map) {
    return new EducationType(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      status: map[table.columnStatus],
    );
  }

  factory EducationType.fromServer(Map<dynamic, dynamic> map) {
    return new EducationType(
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