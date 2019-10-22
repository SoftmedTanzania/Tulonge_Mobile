class TargetAudience {
  final String id;
  final String reference;
  final String name;
  final String value;

  TargetAudience({this.id, this.reference, this.name, this.value});

  factory TargetAudience.fromJson(Map<String, dynamic> data) => TargetAudience(
        id: data['id'],
        reference: data['reference'],
        name: data['name'],
        value: data['value'],
      );

  Map<String, String> toJson() => {
    'id': this.id,
    'reference': this.reference,
    'name': this.name,
    'value': this.value,
  };

}
