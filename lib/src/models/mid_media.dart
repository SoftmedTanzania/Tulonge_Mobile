import 'package:chw/src/models/session.dart';

class MidMedia {
  String reference;
  String community_leader_name;
  String community_leader_phone;
  String cso;
  String cso_name;
  String end_time;
  String start_time;
  String facilitator_phone_number;
  String facilitator_name;
  String facilitator_type;
  String health_education_provided; // used for family planning
  String gps_cordinator_s;
  String gps_cordinator_e;
  String gps_tool_used;
  String hiv_health_education_provided;
  String malaria_health_education_provided;
  String mnhc_health_education_provided;
  String tb_health_education_provided;

  int cap_distributed;
  int jersey_distributed;
  int key_holder_distributed;
  int leaflet_distributed;
  int other_materials_distributed;
  int pen_distributed;
  int poster_distributed;
  int referral_form_distributed;
  int soccer_balls_distributed;
  int tire_cover_distributed;
  int tshirt_distributed;
  int umbrella_distributed;

  int attendance_female_10_14;
  int attendance_female_15_17;
  int attendance_female_18_24;
  int attendance_female_25_30;
  int attendance_female_31_49;
  int attendance_female_50;
  int attendance_male_10_14;
  int attendance_male_15_17;
  int attendance_male_18_24;
  int attendance_male_25_30;
  int attendance_male_31_49;
  int attendance_male_50;

  String matarial_used;
  String event_number;
  String event_type;
  String event_place;
  String specific_message;
  String targets;
  String group_crowd_educated;
  String comments;
  String vennue;
  String region;
  String district;
  String ward;
  String organisation_unit_id;
  String created;
  String act1_date;
  String malaria_specific_message;
  String malaria_specific_message_ids;
  String act2_date;
  String hiv_specific_message;
  String hiv_specific_message_ids;
  String act3_date;
  String tb_specific_message;
  String tb_specific_message_ids;
  String act4_date;
  String mnch_specific_message;
  String mnch_specific_message_ids;
  String act5_date;
  String fp_specific_message;
  String fp_specific_message_ids;
  String households;
  String day1_card;
  String day2_card;
  String day3_card;
  String day4_card;
  String day5_card;
  String day1_game;
  String day2_game;
  String day3_game;
  String day4_game;
  String day5_game;
  String day1_material;
  String day2_material;
  String day3_material;
  String day4_material;
  String day5_material;
  String malaria_tools_provided;
  String malaria_tools_provided_ids;
  String hiv_tools_provided;
  String hiv_tools_provided_ids;
  String tb_tools_provided;
  String tb_tools_provided_ids;
  String mnch_tools_provided;
  String mnch_tools_provided_ids;
  String fp_tools_provided;
  String fp_tools_provided_ids;
  String training_item_used;
  String participants;

  MidMedia.fromJson(Map<String, dynamic> parseJson)
      : reference = parseJson['reference'],
        community_leader_name = parseJson['community_leader_name'],
        community_leader_phone = parseJson['community_leader_phone'],
        cso = parseJson['cso'],
        cso_name = parseJson['cso_name'],
        end_time = parseJson['end_time'],
        start_time = parseJson['start_time'],
        facilitator_phone_number = parseJson['facilitator_phone_number'],
        facilitator_name = parseJson['facilitator_name'],
        facilitator_type = parseJson['facilitator_type'],
        health_education_provided = parseJson['health_education_provided'],
        gps_cordinator_s = parseJson['gps_cordinator_s'],
        gps_cordinator_e = parseJson['gps_cordinator_e'],
        gps_tool_used = parseJson['gps_tool_used'],
        hiv_health_education_provided =
        parseJson['hiv_health_education_provided'],
        malaria_health_education_provided =
        parseJson['malaria_health_education_provided'],
        mnhc_health_education_provided =
        parseJson['mnhc_health_education_provided'],
        tb_health_education_provided =
        parseJson['tb_health_education_provided'],
        cap_distributed = parseJson['cap_distributed'],
        jersey_distributed = parseJson['jersey_distributed'],
        key_holder_distributed = parseJson['key_holder_distributed'],
        leaflet_distributed = parseJson['leaflet_distributed'],
        other_materials_distributed = parseJson['other_materials_distributed'],
        pen_distributed = parseJson['pen_distributed'],
        poster_distributed = parseJson['poster_distributed'],
        referral_form_distributed = parseJson['referral_form_distributed'],
        soccer_balls_distributed = parseJson['soccer_balls_distributed'],
        tire_cover_distributed = parseJson['tire_cover_distributed'],
        tshirt_distributed = parseJson['tshirt_distributed'],
        umbrella_distributed = parseJson['umbrella_distributed'],
        attendance_female_10_14 = parseJson['attendance_female_10_14'],
        attendance_female_15_17 = parseJson['attendance_female_15_17'],
        attendance_female_18_24 = parseJson['attendance_female_18_24'],
        attendance_female_25_30 = parseJson['attendance_female_25_30'],
        attendance_female_31_49 = parseJson['attendance_female_31_49'],
        attendance_female_50 = parseJson['attendance_female_50'],
        attendance_male_10_14 = parseJson['attendance_male_10_14'],
        attendance_male_15_17 = parseJson['attendance_male_15_17'],
        attendance_male_18_24 = parseJson['attendance_male_18_24'],
        attendance_male_25_30 = parseJson['attendance_male_25_30'],
        attendance_male_31_49 = parseJson['attendance_male_31_49'],
        attendance_male_50 = parseJson['attendance_male_50'],
        matarial_used = parseJson['matarial_used'],
        event_number = parseJson['event_number'],
        event_type = parseJson['event_type'],
        event_place = parseJson['event_place'],
        specific_message = parseJson['specific_message'],
        targets = parseJson['targets'],
        group_crowd_educated = parseJson['group_crowd_educated'],
        comments = parseJson['comments'],
        vennue = parseJson['vennue'],
        region = parseJson['region'],
        district = parseJson['district'],
        ward = parseJson['ward'],
        organisation_unit_id = parseJson['organisation_unit_id'],
        created = parseJson['created'],
        act1_date = parseJson['act1_date'],
        malaria_specific_message = parseJson['malaria_specific_message'],
        malaria_specific_message_ids =
        parseJson['malaria_specific_message_ids'],
        act2_date = parseJson['act2_date'],
        hiv_specific_message = parseJson['hiv_specific_message'],
        hiv_specific_message_ids = parseJson['hiv_specific_message_ids'],
        act3_date = parseJson['act3_date'],
        tb_specific_message = parseJson['tb_specific_message'],
        tb_specific_message_ids = parseJson['tb_specific_message_ids'],
        act4_date = parseJson['act4_date'],
        mnch_specific_message = parseJson['mnch_specific_message'],
        mnch_specific_message_ids = parseJson['mnch_specific_message_ids'],
        act5_date = parseJson['act5_date'],
        fp_specific_message = parseJson['fp_specific_message'],
        fp_specific_message_ids = parseJson['fp_specific_message_ids'],
        households = parseJson['households'],
        day1_card = parseJson['day1_card'],
        day2_card = parseJson['day2_card'],
        day3_card = parseJson['day3_card'],
        day4_card = parseJson['day4_card'],
        day5_card = parseJson['day5_card'],
        day1_game = parseJson['day1_game'],
        day2_game = parseJson['day2_game'],
        day3_game = parseJson['day3_game'],
        day4_game = parseJson['day4_game'],
        day5_game = parseJson['day5_game'],
        day1_material = parseJson['day1_material'],
        day2_material = parseJson['day2_material'],
        day3_material = parseJson['day3_material'],
        day4_material = parseJson['day4_material'],
        day5_material = parseJson['day5_material'],
        malaria_tools_provided = parseJson['malaria_tools_provided'],
        malaria_tools_provided_ids = parseJson['malaria_tools_provided_ids'],
        hiv_tools_provided = parseJson['hiv_tools_provided'],
        hiv_tools_provided_ids = parseJson['hiv_tools_provided_ids'],
        tb_tools_provided = parseJson['tb_tools_provided'],
        tb_tools_provided_ids = parseJson['tb_tools_provided_ids'],
        mnch_tools_provided = parseJson['mnch_tools_provided'],
        mnch_tools_provided_ids = parseJson['mnch_tools_provided_ids'],
        fp_tools_provided = parseJson['fp_tools_provided'],
        fp_tools_provided_ids = parseJson['fp_tools_provided_ids'],
        training_item_used = parseJson['training_item_used'],
        participants = parseJson['participants'];


  MidMedia.fromObjects(Session session)
      : reference = session.reference,
        community_leader_name = session.community_leader_name,
        community_leader_phone = session.community_leader_phone,
        cso = session.cso,
        cso_name = session.cso_name,
        end_time = session.end_time,
        start_time = session.start_time,
        facilitator_phone_number = session.facilitator_phone_number,
        facilitator_name = session.facilitator_name,
        facilitator_type = session.facilitator_type,
        health_education_provided = null,
  // TODO waiting for education provided
        gps_cordinator_s = session.gps_cordinator_s,
        gps_cordinator_e = session.gps_cordinator_e,
        gps_tool_used = session.gps_tool_used,
        hiv_health_education_provided = null,
  // TODO: waiting for hiv education provided
        malaria_health_education_provided = null,
  // TODO: waiting for malaria education provided
        mnhc_health_education_provided = null,
  // TODO: waiting for mnhc education provided
        tb_health_education_provided = null,
  // TODO: waiting for tb education provided
        cap_distributed = null,
  // TODO: waiting for cap education provided
        jersey_distributed = null,
  // TODO: waiting for jersey education provided
        key_holder_distributed = null,
  // TODO: waiting for key holder education provided
        leaflet_distributed = null,
  // TODO: waiting for leaflet education provided
        other_materials_distributed = null,
  // TODO: waiting for other materials education provided
        pen_distributed = null,
  // TODO: waiting for hiv education provided
        poster_distributed = null,
  // TODO: waiting for hiv education provided
        referral_form_distributed = null,
  // TODO: waiting for hiv education provided
        soccer_balls_distributed = null,
  // TODO: waiting for hiv education provided
        tire_cover_distributed = null,
  // TODO: waiting for hiv education provided
        tshirt_distributed = null,
  // TODO: waiting for hiv education provided
        umbrella_distributed = null,
  // TODO: waiting for hiv education provided
        attendance_female_10_14 = null,
  // TODO: waiting for hiv education provided
        attendance_female_15_17 = null,
  // TODO: waiting for hiv education provided
        attendance_female_18_24 = null,
  // TODO: waiting for hiv education provided
        attendance_female_25_30 = null,
  // TODO: waiting for hiv education provided
        attendance_female_31_49 = null,
  // TODO: waiting for hiv education provided
        attendance_female_50 = null,
  // TODO: waiting for hiv education provided
        attendance_male_10_14 = null,
  // TODO: waiting for hiv education provided
        attendance_male_15_17 = null,
  // TODO: waiting for hiv education provided
        attendance_male_18_24 = null,
  // TODO: waiting for hiv education provided
        attendance_male_25_30 = null,
  // TODO: waiting for hiv education provided
        attendance_male_31_49 = null,
  // TODO: waiting for hiv education provided
        attendance_male_50 = null,
  // TODO: waiting for hiv education provided
        matarial_used = null,
  // TODO: waiting for hiv education provided
        event_number = null,
  // TODO: waiting for hiv education provided
        event_type = null,
  // TODO: waiting for hiv education provided
        event_place = null,
  // TODO: waiting for hiv education provided
        specific_message = null,
  // TODO: waiting for hiv education provided
        targets = null,
  // TODO: waiting for hiv education provided
        group_crowd_educated = null,
  // TODO: waiting for hiv education provided
        comments = null,
  // TODO: waiting for hiv education provided
        vennue = null,
  // TODO: waiting for hiv education provided
        region = null,
  // TODO: waiting for hiv education provided
        district = null,
  // TODO: waiting for hiv education provided
        ward = null,
  // TODO: waiting for hiv education provided
        organisation_unit_id = null,
  // TODO: waiting for hiv education provided
        created = null,
  // TODO: waiting for hiv education provided
        act1_date = null,
  // TODO: waiting for hiv education provided
        malaria_specific_message = null,
  // TODO: waiting for hiv education provided
        malaria_specific_message_ids = null,
  // TODO: waiting for hiv education provided
        act2_date = null,
  // TODO: waiting for hiv education provided
        hiv_specific_message = null,
  // TODO: waiting for hiv education provided
        hiv_specific_message_ids = null,
  // TODO: waiting for hiv education provided
        act3_date = null,
  // TODO: waiting for hiv education provided
        tb_specific_message = null,
  // TODO: waiting for hiv education provided
        tb_specific_message_ids = null,
  // TODO: waiting for hiv education provided
        act4_date = null,
  // TODO: waiting for hiv education provided
        mnch_specific_message = null,
  // TODO: waiting for hiv education provided
        mnch_specific_message_ids = null,
  // TODO: waiting for hiv education provided
        act5_date = null,
  // TODO: waiting for hiv education provided
        fp_specific_message = null,
  // TODO: waiting for hiv education provided
        fp_specific_message_ids = null,
  // TODO: waiting for hiv education provided
        households = null,
  // TODO: waiting for hiv education provided
        day1_card = null,
  // TODO: waiting for hiv education provided
        day2_card = null,
  // TODO: waiting for hiv education provided
        day3_card = null,
  // TODO: waiting for hiv education provided
        day4_card = null,
  // TODO: waiting for hiv education provided
        day5_card = null,
  // TODO: waiting for hiv education provided
        day1_game = null,
  // TODO: waiting for hiv education provided
        day2_game = null,
  // TODO: waiting for hiv education provided
        day3_game = null,
  // TODO: waiting for hiv education provided
        day4_game = null,
  // TODO: waiting for hiv education provided
        day5_game = null,
  // TODO: waiting for hiv education provided
        day1_material = null,
  // TODO: waiting for hiv education provided
        day2_material = null,
  // TODO: waiting for hiv education provided
        day3_material = null,
  // TODO: waiting for hiv education provided
        day4_material = null,
  // TODO: waiting for hiv education provided
        day5_material = null,
  // TODO: waiting for hiv education provided
        malaria_tools_provided = null,
  // TODO: waiting for hiv education provided
        malaria_tools_provided_ids = null,
  // TODO: waiting for hiv education provided
        hiv_tools_provided = null,
  // TODO: waiting for hiv education provided
        hiv_tools_provided_ids = null,
  // TODO: waiting for hiv education provided
        tb_tools_provided = null,
  // TODO: waiting for hiv education provided
        tb_tools_provided_ids = null,
  // TODO: waiting for hiv education provided
        mnch_tools_provided = null,
  // TODO: waiting for hiv education provided
        mnch_tools_provided_ids = null,
  // TODO: waiting for hiv education provided
        fp_tools_provided = null,
  // TODO: waiting for hiv education provided
        fp_tools_provided_ids = null,
  // TODO: waiting for hiv education provided
        training_item_used = null,
  // TODO: waiting for hiv education provided
        participants = null; // TODO: waiting for hiv education provided

  Map<String, dynamic> toJson() =>
      {
        'reference': this.reference,
        'community_leader_name': this.community_leader_name,
        'community_leader_phone': this.community_leader_phone,
        'cso': this.cso,
        'cso_name': this.cso,
        'end_time': this.end_time,
        'start_time': this.start_time,
        'facilitator_phone_number': this.facilitator_phone_number,
        'facilitator_name': this.facilitator_name,
        'facilitator_type': this.facilitator_type,
        'health_education_provided':this.health_education_provided,
        'gps_cordinator_s': this.gps_cordinator_s,
        'gps_cordinator_e': this.gps_cordinator_e,
        'gps_tool_used': this.gps_tool_used,
        'hiv_health_education_provided': this.hiv_health_education_provided,
        'malaria_health_education_provided': this
            .malaria_health_education_provided,
        'mnhc_health_education_provided': this.mnhc_health_education_provided,
        'tb_health_education_provided': this.tb_health_education_provided,
        'cap_distributed': this.cap_distributed,
        'jersey_distributed': this.jersey_distributed,
        'key_holder_distributed': this.key_holder_distributed,
        'leaflet_distributed': this.other_materials_distributed,
        'other_materials_distributed': this.other_materials_distributed,
        'pen_distributed': this.pen_distributed,
        'poster_distributed': this.poster_distributed,
        'referral_form_distributed': this.referral_form_distributed,
        'soccer_balls_distributed': this.soccer_balls_distributed,
        'tire_cover_distributed': this.tire_cover_distributed,
        'tshirt_distributed': this.tshirt_distributed,
        'umbrella_distributed': this.umbrella_distributed,
        'attendance_female_10_14': this.attendance_female_10_14,
        'attendance_female_15_17': this.attendance_female_15_17,
        'attendance_female_18_24': this.attendance_female_18_24,
        'attendance_female_25_30': this.attendance_female_25_30,
        'attendance_female_31_49': this.attendance_female_31_49,
        'attendance_female_50': this.attendance_female_50,
        'attendance_male_10_14': this.attendance_male_15_17,
        'attendance_male_15_17': this.attendance_male_15_17,
        'attendance_male_18_24': this.attendance_male_18_24,
        'attendance_male_25_30': this.attendance_male_25_30,
        'attendance_male_31_49': this.attendance_male_31_49,
        'attendance_male_50': this.attendance_male_50,
        'matarial_used': this.matarial_used,
        'event_number': this.event_number,
        'event_type': this.event_type,
        'event_place': this.event_place,
        'specific_message': this.specific_message,
        'targets': this.targets,
        'group_crowd_educated': this.group_crowd_educated,
        'comments': this.comments,
        'vennue': this.vennue,
        'region': this.region,
        'district': this.district,
        'ward': this.ward,
        'organisation_unit_id': this.organisation_unit_id,
        'created': this.created,
        'act1_date': this.act1_date,
        'malaria_specific_message': this.malaria_specific_message,
        'malaria_specific_message_ids': this.malaria_specific_message_ids,
        'act2_date': this.act2_date,
        'hiv_specific_message': this.hiv_specific_message,
        'hiv_specific_message_ids': this.hiv_specific_message_ids,
        'act3_date': this.act3_date,
        'tb_specific_message': this.tb_specific_message,
        'tb_specific_message_ids': this.tb_specific_message_ids,
        'act4_date': this.act4_date,
        'mnch_specific_message': this.mnch_specific_message,
        'mnch_specific_message_ids': this.mnch_specific_message_ids,
        'act5_date': this.act5_date,
        'fp_specific_message': this.fp_specific_message,
        'fp_specific_message_ids': this.fp_specific_message_ids,
        'households': this.households,
        'day1_card': this.day1_card,
        'day2_card': this.day2_card,
        'day3_card': this.day3_card,
        'day4_card': this.day4_card,
        'day5_card': this.day5_card,
        'day1_game': this.day1_game,
        'day2_game': this.day2_game,
        'day3_game': this.day3_game,
        'day4_game': this.day4_game,
        'day5_game': this.day5_game,
        'day1_material': this.day1_material,
        'day2_material': this.day2_material,
        'day3_material': this.day3_material,
        'day4_material': this.day4_material,
        'day5_material': this.day5_material,
        'malaria_tools_provided': this.malaria_tools_provided,
        'malaria_tools_provided_ids': this.malaria_tools_provided_ids,
        'hiv_tools_provided': this.hiv_tools_provided,
        'hiv_tools_provided_ids': this.hiv_tools_provided_ids,
        'tb_tools_provided': this.tb_tools_provided,
        'tb_tools_provided_ids': this.tb_tools_provided_ids,
        'mnch_tools_provided': this.mnch_tools_provided,
        'mnch_tools_provided_ids': this.mnch_tools_provided_ids,
        'fp_tools_provided': this.fp_tools_provided,
        'fp_tools_provided_ids': this.fp_tools_provided_ids,
        'training_item_used': this.training_item_used,
        'participants': this.participants
      };

}
