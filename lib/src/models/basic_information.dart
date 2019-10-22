class BasicInformationModel {
  final String reference;
  final String community_leader_name;
  final String community_leader_phone;
  final String cso;
  final String cso_name;
  final String event_place;
  final String facilitator_phone_number;
  final String facilitator_name;
  final String facilitator_type;
  final String gps_cordinator_s;
  final String gps_cordinator_e;
  final String gps_tool_used;
  final String venue;
  final String ward;
  final String district;
  final String region;

  BasicInformationModel(
      {this.reference,
      this.community_leader_name,
      this.community_leader_phone,
      this.cso,
      this.cso_name,
      this.event_place,
      this.facilitator_phone_number,
      this.facilitator_name,
      this.facilitator_type,
      this.gps_cordinator_s,
      this.gps_cordinator_e,
      this.gps_tool_used,
      this.venue,
      this.ward,
      this.district,
      this.region});

  factory BasicInformationModel.fromJson(Map<String, dynamic> data) =>
      BasicInformationModel(
          reference: data['reference'],
          community_leader_name: data['community_leader_name'],
          community_leader_phone: data['community_leader_phone'],
          cso: data['cso'],
          cso_name: data['cso_name'],
          event_place: data['event_place'],
          facilitator_phone_number: data['facilitator_phone_number'],
          facilitator_name: data['facilitator_name'],
          facilitator_type: data['facilitator_type'],
          gps_cordinator_s: data['gps_cordinator_s'],
          gps_cordinator_e: data['gps_cordinator_e'],
          gps_tool_used: data['gps_tool_used'],
          venue: data['venue'],
          ward: data['ward'],
          district: data['district'],
          region: data['region']);

  Map<String, String> toJson() => {
        'reference': this.reference,
        'community_leader_name': this.community_leader_name,
        'community_leader_phone': this.community_leader_phone,
        'cso': this.cso,
        'cso_name': this.cso_name,
        'event_place': this.event_place,
        'facilitator_phone_number': this.facilitator_phone_number,
        'facilitator_name': this.facilitator_name,
        'facilitator_type': this.facilitator_type,
        'gps_cordinator_s': this.gps_cordinator_s,
        'gps_cordinator_e': this.gps_cordinator_e,
        'venue': this.venue,
        'ward': this.ward,
        'district': this.district,
        'region': this.region,
      };
}
