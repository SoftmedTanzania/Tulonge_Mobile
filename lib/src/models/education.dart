class Education {
  final String reference;
  final bool hiv_health_education_provided;
  final bool malaria_health_education_provided;
  final bool mnhc_health_education_provided;
  final bool tb_health_education_provided;

  Education({
    this.reference,
    this.hiv_health_education_provided,
    this.malaria_health_education_provided,
    this.mnhc_health_education_provided,
    this.tb_health_education_provided});

  factory Education.fromJson(Map<String, dynamic> data) =>
      Education(
          reference: data['reference'],
          malaria_health_education_provided: data['malaria_health_education_provided'],
          mnhc_health_education_provided: data['mnhc_health_education_provided'],
          tb_health_education_provided: data['tb_health_education_provided']
      );
}
