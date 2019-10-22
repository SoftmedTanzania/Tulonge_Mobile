class MaterialModel {
  String id;
  String name;
  String swahiliName;
  String status;
  bool canDistribute;
  bool usedForTraining;

  MaterialModel.fromServer(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        swahiliName = parseJson['swahili_name'],
        status = parseJson['status'],
        canDistribute = parseJson['can_distribute'] == null ? false : parseJson['can_distribute'],
        usedForTraining = parseJson['used_for_training'] == null ? false : parseJson['used_for_training'];

  MaterialModel.fromDatabase(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        name = parseJson['name'],
        swahiliName = parseJson['swahili_name'],
        status = parseJson['status'],
        canDistribute = parseJson['can_distribute'] == 1? true : false,
        usedForTraining = parseJson['used_for_training'] == 1? true : false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "swahili_name": swahiliName,
      "status": status,
      "can_distribute": canDistribute == true ? 1 : 0,
      "used_for_training": usedForTraining == true ? 1 : 0
    };
  }
}
