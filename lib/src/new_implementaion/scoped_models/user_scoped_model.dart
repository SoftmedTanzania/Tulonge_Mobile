import 'package:chw/src/new_implementaion/database/database_providers/user_database_provider.dart';
import 'package:chw/src/new_implementaion/database/tables/user_table.dart'
    as table;
import 'package:chw/src/new_implementaion/models/user_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/connected.dart';

mixin UserScopedModel on ConnectedModel {
  bool _isLoading = false;
  bool _successful = false;

  bool get isLoading => this._isLoading;

  bool get successful => this._successful;

  void setIsLoading(bool val) {
    this._isLoading = val;
    notifyListeners();
  }

  void setIsSuccessful(bool val) {
    this._successful = val;
    notifyListeners();
  }

  initiateUser(Map<String, dynamic> userDetails) async {
    var user = {
      table.columnId: userDetails['user']['id'],
      table.columnName: userDetails['user']['name'],
      table.columnUsername: userDetails['user']['username'],
      table.columnPhoneNumber: userDetails['user']['phoneNumber'],
      table.columnCsoId: _getAttributeValue(
          userDetails['user']['attributeValues'], 'GvaOMI0hY5A'),
      table.columnGender: _getAttributeValue(
          userDetails['user']['attributeValues'], 'DouTl1mbtEn'),
      table.columnChwType: _getAttributeValue(
          userDetails['user']['attributeValues'], 'd6HhBsnCWCF'),
      table.columnVolunteerId: _getAttributeValue(
          userDetails['user']['attributeValues'], 'WANdA0ZEUhU'),
      table.columnDefaultVillage: _getAttributeValue(
          userDetails['user']['attributeValues'], 'KGdjceoAC2G'),
      table.columnDistrictName: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['district_name'],
      table.columnDistrictId: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['district_id'],
      table.columnRegionName: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['region_name'],
      table.columnWardName: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['ou_name'],
      table.columnWardId: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['ou_id'],
      table.columnOrganisationUnits: _getOrganisationUnitDetails(
          userDetails['user']['organisationUnits'][0])['ou_id'],
      table.columnToken: userDetails['token'],
    };
    User dataUser = User.fromServer(user);
    var DBProvider = UserDataProvider();
    var result = await DBProvider.addOrUpdateUser(dataUser);
    this.initilizeUsers();
    print(this.dataReady);
    notifyListeners();
  }

  deleteUser(User user) async {
    var DBProvider = UserDataProvider();
    var result = await DBProvider.deleteUser(user.id);
    this.initilizeUsers();
  }

  dynamic _getAttributeValue(List<dynamic> attributes, attributeId) {
    if (attributes != null) {
      var attribute = attributes
          .firstWhere((attr) => attr['attribute']['id'] == attributeId);
      if (attribute != null) {
        return attribute['value'];
      }
    }
    return '';
  }

  dynamic _getOrganisationUnitDetails(orgunit) {
    var data = {
      "ou_id": '',
      "ou_name": '',
      "district_id": '',
      "district_name": '',
      "region_id": '',
      "region_name": ''
    };
    if (orgunit != null) {
      data['ou_id'] = orgunit['id'];
      data['ou_name'] = orgunit['name'];
      if (orgunit['parent'] != null) {
        final parent = orgunit['parent'];
        data['district_id'] = parent['id'];
        data['district_name'] = parent['name'];
        if (parent['parent'] != null) {
          final region = parent['parent'];
          data['region_id'] = region['id'];
          data['region_name'] = region['name'];
        }
      }
    }
    return data;
  }
}
