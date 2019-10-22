class CSOModel {
  String id;
  String name;
  String status;

  CSOModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        status = parseJson['status'];

  CSOModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        status = parseJson['status'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "status": status,
    };
  }
}
