class EducationType {
  String id;
  String name;
  String english_name;
  String status;
  String description;
  List<Map<String,dynamic>> specificMessage;

  EducationType({this.id, this.name,this.english_name, this.status, this.description, this.specificMessage});

  factory EducationType.fromJson(Map<String, dynamic> data) => EducationType(
      id: data['id'],
      name: data['swahili_name'],
      english_name: data['name'],
      status: data['status'],
      description: data['description'],
      specificMessage: data['specificMessage']);
}
