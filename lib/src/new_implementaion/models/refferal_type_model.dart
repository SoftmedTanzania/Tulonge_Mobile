import 'package:chw/src/new_implementaion/database/tables/refferal_type_table.dart' as table;

class ReferralType {
  final String id;
  final String name;
  final String swahiliName;
  final String status;

  ReferralType({
    this.id,
    this.name,
    this.swahiliName,
    this.status,
  });

  factory ReferralType.fromDatabase(Map<dynamic, dynamic> map) {
    return new ReferralType(
      id: map[table.columnId],
      name: map[table.columnName],
      swahiliName: map[table.columnSwahiliName],
      status: map[table.columnStatus],
    );
  }

  factory ReferralType.fromServer(Map<dynamic, dynamic> map) {
    return new ReferralType(
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