class EducatedGroupModel {
  String id;
  String name;
  String swahili_name;
  String status;

  EducatedGroupModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        swahili_name = parseJson['swahili_name'],
        status = parseJson['status'],
        name = parseJson['name'];

  EducatedGroupModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        status = parseJson['status'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "swahili_name": swahili_name,
      "status": status,
    };
  }
}
