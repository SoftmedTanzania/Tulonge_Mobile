class LearningGroupModel {
  String id;
  String name;
  String status;
  String description;

  LearningGroupModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        status = parseJson['status'],
        description = parseJson['description'];

  LearningGroupModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        status = parseJson['status'],
        description = parseJson['description'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "status": status,
      "description": description,
    };
  }
}
