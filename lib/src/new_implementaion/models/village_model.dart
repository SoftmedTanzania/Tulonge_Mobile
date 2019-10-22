import 'package:chw/src/new_implementaion/database/tables/village_table.dart' as table;

class Village {
  final String id;
  final String name;
  final String leaderName;
  final String leaderPhone;

  Village({this.id, this.name, this.leaderName, this.leaderPhone});

  factory Village.fromDatabase(Map<dynamic, dynamic> map) {
    return new Village(
      id: map[table.columnId],
      name: map[table.columnName],
      leaderName: map[table.columnLeaderName],
      leaderPhone: map[table.columnLeaderPhone],
    );
  }

  factory Village.fromServer(Map<dynamic, dynamic> map) {
    return new Village(
      id: map[table.columnId],
      name: map[table.columnName],
      leaderName: map[table.columnLeaderName],
      leaderPhone: map[table.columnLeaderPhone],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnLeaderName: leaderName,
      table.columnLeaderPhone: leaderPhone,
    };
  }

  @override
  String toString() {
    return '${name}';
  }

}