class LearningMaterialModel {
  String id;
  String title;
  String description;
  String topicId;
  String mediaPath;

  LearningMaterialModel.fromJson(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        title = parseJson['title'],
        description = parseJson['description'],
        topicId = parseJson['topicId'],
        mediaPath = parseJson['mediaPath'];

  LearningMaterialModel.fromDb(Map<String, dynamic> parseJson)
      : id = parseJson['id'],
        title = parseJson['title'],
        description = parseJson['description'],
        mediaPath = parseJson['mediaPath'],
        topicId = parseJson['topicId'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "description": description,
      "mediaPath": mediaPath
    };
  }
}
