import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/refferal_type_model.dart';
import 'package:chw/src/new_implementaion/database/tables/refferal_type_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class ReferralTypeDataProvider {

  ApiProvider api = new ApiProvider();
  ReferralTypeDataProvider();

  //Insertion
  Future<int> saveReferralType(ReferralType referralType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, referralType);
  }

  //Get Users
  Future<List<ReferralType>> getAllReferralTypes() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => ReferralType.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<ReferralType>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => ReferralType.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<ReferralType> getReferralType(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new ReferralType.fromDatabase(result.first);
  }

  Future<int> deleteReferralType(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateReferralType(ReferralType referralType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, referralType);
  }

  Future<int> addOrUpdateReferralType(ReferralType referralType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, referralType);
  }

  Future<List<ReferralType>> getFromServer() async {
    try {
      var items = await api.getReferralList();
      List<ReferralType> referralTypes = [];
      items.forEach((item) {
        referralTypes.add(ReferralType.fromServer(item));
      });
      return referralTypes;
    } catch(e) {
      return [];
    }
  }

  // a function to initialize referralType details
  Future<List<ReferralType>> initiateReferralType([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<ReferralType> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateReferralType(adjustment);
      });
      return adjustments;
    } else {
      List<ReferralType> adjustments = await getAllReferralTypes();
      return adjustments;
    }
  }
}
