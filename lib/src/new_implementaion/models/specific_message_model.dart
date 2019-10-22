import 'package:chw/src/new_implementaion/database/tables/specific_message_table.dart'
    as table;

class SpecificMessage {
  final String id;
  final String name;
  final String swahiliName;
  final String educationTypeId;
  final String educationType;
  final String identifier;
  final String status;

  SpecificMessage({
    this.id,
    this.name,
    this.swahiliName,
    this.educationTypeId,
    this.educationType,
    this.identifier,
    this.status,
  });

  factory SpecificMessage.fromDatabase(Map<dynamic, dynamic> map) {
    return new SpecificMessage(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      educationTypeId: map[table.columnEducationTypeId],
      educationType: map[table.columnEducationType],
      identifier: map[table.columnIdentifier],
      status: map[table.columnStatus],
    );
  }

  factory SpecificMessage.fromServer(Map<dynamic, dynamic> map) {
    return new SpecificMessage(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      educationTypeId: map[table.columnEducationTypeId],
      educationType: map[table.columnEducationType],
      identifier: map[table.columnIdentifier],
      status: map[table.columnStatus],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnSwahiliName: swahiliName,
      table.columnEducationTypeId: educationTypeId,
      table.columnEducationType: educationType,
      table.columnIdentifier: identifier,
      table.columnStatus: status,
    };
  }

  @override
  String toString() {
    return '${swahiliName}';
  }
}
