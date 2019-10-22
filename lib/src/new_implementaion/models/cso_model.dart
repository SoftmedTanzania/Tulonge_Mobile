import 'dart:convert';
import 'package:chw/src/new_implementaion/database/tables/cso_table.dart'
as table;

class Cso {
  final String id;
  final String name;
  final String organisationUnitId;
  final String status;

  Cso({
    this.id,
    this.name,
    this.organisationUnitId,
    this.status,
  });

  factory Cso.fromDatabase(Map<dynamic, dynamic> map) {
    return new Cso(
      id: map[table.columnId],
      name: map[table.columnName],
      organisationUnitId: map[table.columnOrganisationUnitId],
      status: map[table.columnStatus],
    );
  }

  factory Cso.fromServer(Map<dynamic, dynamic> map) {
    return new Cso(
      id: map[table.columnId],
      name: map[table.columnName],
      organisationUnitId: map[table.columnOrganisationUnitId],
      status: map[table.columnStatus],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnOrganisationUnitId: organisationUnitId,
      table.columnStatus: status,
    };
  }

  @override
  String toString() {
    return '${name}';
  }
}
