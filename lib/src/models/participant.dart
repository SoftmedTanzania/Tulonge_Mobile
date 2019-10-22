class ParticipantModel {
  final String id;
  final String reference;
  final String name;
  final String age;
  final String gender;
  final String phone_number;
  final String marital_status;

  ParticipantModel(
      {this.id,
        this.reference,
      this.name,
      this.age,
      this.gender,
      this.phone_number,
      this.marital_status
      });

  factory ParticipantModel.fromJson(Map<String, dynamic> data) => ParticipantModel(
      id: data['id'].toString(),
      reference: data['reference'],
      name: data['name'],
      age: data['age'],
      gender: data['gender'],
      phone_number: data['phone_number'],
    marital_status: data['marital_status'],
  );

  Map<String, String> toJson() => {
        "id": this.id,
        "reference": this.reference,
        "name": this.name,
        "age": this.age,
        "gender": this.gender,
        "phone_number": this.phone_number,
        "marital_status": this.marital_status,
      };
}
