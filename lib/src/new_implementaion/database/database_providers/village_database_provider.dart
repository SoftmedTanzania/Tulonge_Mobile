import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/database/tables/village_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class VillageDataProvider {

  ApiProvider api = new ApiProvider();
  VillageDataProvider();

  //Insertion
  Future<int> saveVillage(Village village) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, village);
  }

  //Get Users
  Future<List<Village>> getAllVillages() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => Village.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<Village>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => Village.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<Village> getVillage(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new Village.fromDatabase(result.first);
  }

  Future<int> deleteVillage(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateVillage(Village village) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, village);
  }

  Future<int> addOrUpdateVillage(Village village) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, village);
  }

  Future<List<Village>> getFromServer() async {
//    try {
//      var items = await api.getVillageList();
//      List<Village> villages = [];
//      items.forEach((item) {
//        villages.add(Village.fromServer(item));
//      });
//      return villages;
//    } catch(e) {
//      return [];
//    }
  return [];
  }

  // a function to initialize village details
  Future<List<Village>> initiateVillage() async {
      List<Village> adjustments = await getAllVillages();
      return adjustments;
  }
}
