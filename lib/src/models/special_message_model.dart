class SpecialMessageModel {
  String id;
  String name;
  String swahili_name;
  String educationTypeId;
  String education_type;
  String status;
  String identifier;


  SpecialMessageModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        swahili_name = parseJson['swahili_name'],
        status = parseJson['status'],
        educationTypeId = parseJson['educationTypeId'],
        education_type = parseJson['education_type'],
        identifier = parseJson['identifier'],
        name = parseJson['name'];

  SpecialMessageModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        swahili_name = parseJson['swahili_name'],
        educationTypeId = parseJson['educationTypeId'],
        education_type = parseJson['education_type'],
        identifier = parseJson['identifier'],
        status = parseJson['status'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "swahili_name": swahili_name,
      "educationTypeId": educationTypeId,
      "education_type": education_type,
      "identifier": identifier,
      "status": status,
    };
  }
}
