class Cso {
  final String id;
  final String name;

  Cso({this.id, this.name});

  factory Cso.fromJson(Map<String, dynamic> data) =>
      Cso(id: data['id'], name: data['name']);
}
