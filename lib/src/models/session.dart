import 'package:chw/src/models/basic_information.dart';

class Session {
  final String reference;
  final String community_leader_name;
  final String community_leader_phone;
  final String cso;
  final String cso_name;
  final String end_time;
  final String start_time;
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
  bool isSynchronized;

  Session(this.reference,
      [this.community_leader_name = '',
      this.community_leader_phone = '',
      this.cso = '',
      this.cso_name = '',
      this.start_time = '',
      this.end_time = '',
      this.event_place = '',
      this.facilitator_phone_number = '',
      this.facilitator_name = '',
      this.facilitator_type = '',
      this.gps_cordinator_s = '',
      this.gps_cordinator_e = '',
      this.gps_tool_used = '',
      this.venue = '',
      this.ward = '',
      this.district = '',
      this.region = '',
      this.isSynchronized]);

  factory Session.fromJson(Map<String, dynamic> data) => Session(
      data['reference'],
      data['community_leader_name'],
      data['community_leader_phone'],
      data['cso'],
      data['cso_name'],
      data['start_time'],
      data['end_time'],
      data['event_place'],
      data['facilitator_phone_number'],
      data['facilitator_name'],
      data['facilitator_type'],
      data['gps_cordinator_s'],
      data['gps_cordinator_e'],
      data['gps_tool_used'],
      data['venue'],
      data['ward'],
      data['district'],
      data['region'],
      data['isSynchronized'] == 1 ? true : false);

  factory Session.fromDb(Map<String, dynamic> data) => Session(
      data['reference'],
      data['community_leader_name'],
      data['community_leader_phone'],
      data['cso'],
      data['cso_name'],
      data['start_time'],
      data['end_time'],
      data['event_place'],
      data['facilitator_phone_number'],
      data['facilitator_name'],
      data['facilitator_type'],
      data['gps_cordinator_s'],
      data['gps_cordinator_e'],
      data['gps_tool_used'],
      data['venue'],
      data['ward'],
      data['district'],
      data['region'],
      data['isSynchronized'] == 1 ? true : false);

  Map<String, dynamic> toJson() => {
        'reference': this.reference,
        'community_leader_name': this.community_leader_name,
        'community_leader_phone': this.community_leader_phone,
        'cso': this.cso,
        'cso_name': this.cso_name,
        'start_time': this.start_time,
        'end_time': this.end_time,
        'event_place': this.event_place,
        'facilitator_phone_number': this.facilitator_phone_number,
        'facilitator_name': this.facilitator_name,
        'facilitator_type': this.facilitator_type,
        'gps_cordinator_s': this.gps_cordinator_s,
        'gps_cordinator_e': this.gps_cordinator_e,
        'gps_tool_used': this.gps_tool_used,
        'venue': this.venue,
        'ward': this.ward,
        'district': this.district,
        'region': this.region,
        'isSynchronized': this.isSynchronized,
      };

  Map<String, String> forInsertion() => {
        'reference': this.reference,
      };

  String toString() {
    return {
      'reference': this.reference,
      'community_leader_name': this.community_leader_name,
      'community_leader_phone': this.community_leader_phone,
      'cso': this.cso,
      'cso_name': this.cso_name,
      'start_time': this.start_time,
      'end_time': this.end_time,
      'event_place': this.event_place,
      'facilitator_phone_number': this.facilitator_phone_number,
      'facilitator_name': this.facilitator_name,
      'facilitator_type': this.facilitator_type,
      'gps_cordinator_s': this.gps_cordinator_s,
      'gps_cordinator_e': this.gps_cordinator_e,
      'gps_tool_used': this.gps_tool_used,
      'venue': this.venue,
      'ward': this.ward,
      'district': this.district,
      'region': this.region,
      'isSynchronized': this.isSynchronized,
    }.toString();
  }
}
