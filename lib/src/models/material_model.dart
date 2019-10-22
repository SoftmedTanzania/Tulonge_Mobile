class MaterialModel {
  String id;
  String name;
  String swahili_name;
  String status;
  bool can_distribute;
  bool used_for_training;

  MaterialModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        swahili_name = parseJson['swahili_name'],
        status = parseJson['status'],
        can_distribute = parseJson['can_distribute'],
        used_for_training = parseJson['used_for_training'];

  MaterialModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        swahili_name = parseJson['swahili_name'],
        status = parseJson['status'],
        can_distribute = parseJson['can_distribute'] == 1? true : false,
        used_for_training = parseJson['used_for_training'] == 1? true : false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "swahili_name": swahili_name,
      "status": status,
      "can_distribute": can_distribute == true ? '1' : '0',
      "used_for_training": used_for_training == true ? '1' : '0'
    };
  }
}
