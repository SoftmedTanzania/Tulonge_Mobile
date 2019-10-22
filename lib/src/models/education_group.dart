class EducationGroup {
  final String id;
  final String name;
  final String swahili_name;
  final String status;

  EducationGroup({this.id, this.name, this.swahili_name, this.status});

  factory EducationGroup.fromJson(Map<String, dynamic> data) => EducationGroup(
      id: data['id'],
      name: data['name'],
      status: data['status'],
      swahili_name: data['swahili_name']);
}
