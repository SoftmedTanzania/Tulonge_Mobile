class OrganisationUnitModel {
  String id;
  String name;

  OrganisationUnitModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'];

  OrganisationUnitModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
    };
  }
}
