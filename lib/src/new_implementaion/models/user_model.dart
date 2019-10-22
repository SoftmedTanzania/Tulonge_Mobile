import 'dart:convert';

import 'package:chw/src/new_implementaion/database/tables/user_table.dart'
    as table;

class User {
  final String id;
  final String name;
  final String username;
  final String phoneNumber;
  final String csoId;
  final String gender;
  final String chwType;
  final String volunteerId;
  final String defaultVillage;
  final String districtName;
  final String districtId;
  final String regionName;
  final String wardName;
  final String wardId;
  final String organisationUnits;
  final String tokenId;
  final String communityLeaderName;
  final String communityLeaderPhone;

  User({
    this.id,
    this.name,
    this.username,
    this.phoneNumber,
    this.csoId,
    this.gender,
    this.chwType,
    this.volunteerId,
    this.defaultVillage,
    this.districtName,
    this.districtId,
    this.regionName,
    this.wardName,
    this.wardId,
    this.organisationUnits,
    this.tokenId,
    this.communityLeaderName,
    this.communityLeaderPhone,
  });

  factory User.fromDatabase(Map<String, dynamic> map) {
    return new User(
      id: map[table.columnId],
      name: map[table.columnName],
      username: map[table.columnUsername],
      phoneNumber: map[table.columnPhoneNumber],
      csoId: map[table.columnCsoId],
      gender: map[table.columnGender],
      chwType: map[table.columnChwType],
      volunteerId: map[table.columnVolunteerId],
      defaultVillage: map[table.columnDefaultVillage],
      districtName: map[table.columnDistrictName],
      districtId: map[table.columnDistrictId],
      regionName: map[table.columnRegionName],
      wardName: map[table.columnWardName],
      wardId: map[table.columnWardId],
      organisationUnits: map[table.columnOrganisationUnits],
      tokenId: map[table.columnToken],
      communityLeaderPhone: map[table.columnCommunityLeaderPhone],
      communityLeaderName: map[table.columnCommunityLeaderName],
    );
  }

  factory User.fromServer(Map<String, dynamic> map) {

    return new User(
      id: map[table.columnId],
      name: map[table.columnName],
      username: map[table.columnUsername],
      phoneNumber: map[table.columnPhoneNumber],
      csoId: map[table.columnCsoId],
      gender: map[table.columnGender],
      chwType: map[table.columnChwType],
      volunteerId: map[table.columnVolunteerId],
      defaultVillage: map[table.columnDefaultVillage],
      districtName: map[table.columnDistrictName],
      districtId: map[table.columnDistrictId],
      regionName: map[table.columnRegionName],
      wardName: map[table.columnWardName],
      wardId: map[table.columnWardId],
      organisationUnits: map[table.columnOrganisationUnits],
      tokenId: map[table.columnToken],
      communityLeaderPhone: '',
      communityLeaderName: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      table.columnId: id,
      table.columnName: name,
      table.columnUsername: username,
      table.columnPhoneNumber: phoneNumber,
      table.columnCsoId: csoId,
      table.columnGender: gender,
      table.columnChwType: chwType,
      table.columnVolunteerId: volunteerId,
      table.columnDefaultVillage: defaultVillage,
      table.columnDistrictName: districtName,
      table.columnDistrictId: districtId,
      table.columnRegionName: regionName,
      table.columnWardName: wardName,
      table.columnWardId: wardId,
      table.columnOrganisationUnits: organisationUnits,
      table.columnToken: tokenId,
      table.columnCommunityLeaderPhone: communityLeaderPhone,
      table.columnCommunityLeaderName: communityLeaderName,
    };
  }

  dynamic _getAttributeValue(List<dynamic>attributes, attributeId) {
    if (attributes != null) {
      var attribute = attributes.firstWhere((attr) => attr['attribute']['id'] == attributeId);
      if (attribute != null) {
        return attribute['value'];
      }
    }
    return '';
  }


  @override
  String toString() {
    return '${name}, ';
  }
}
