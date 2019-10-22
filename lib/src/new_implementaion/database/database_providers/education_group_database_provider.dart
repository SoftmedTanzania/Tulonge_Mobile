import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/educated_group_model.dart';
import 'package:chw/src/new_implementaion/database/tables/educated_group_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class EducatedGroupDataProvider {

  ApiProvider api = new ApiProvider();
  EducatedGroupDataProvider();

  //Insertion
  Future<int> saveEducatedGroup(EducatedGroup educatedGroup) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, educatedGroup);
  }

  //Get Users
  Future<List<EducatedGroup>> getAllEducatedGroups() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => EducatedGroup.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<EducatedGroup>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => EducatedGroup.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<EducatedGroup> getEducatedGroup(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new EducatedGroup.fromDatabase(result.first);
  }

  Future<int> deleteEducatedGroup(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateEducatedGroup(EducatedGroup educatedGroup) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, educatedGroup);
  }

  Future<int> addOrUpdateEducatedGroup(EducatedGroup educatedGroup) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, educatedGroup);
  }

  Future<List<EducatedGroup>> getFromServer() async {
    try {
      var items = await api.getEducationGroupsList();
      List<EducatedGroup> educatedGroups = [];
      items.forEach((item) {
        educatedGroups.add(EducatedGroup.fromServer(item));
      });
      return educatedGroups;
    } catch(e) {
      print(e.message);
      return [];
    }

  }

  // a function to initialize educatedGroup details
  Future<List<EducatedGroup>> initiateEducatedGroup([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<EducatedGroup> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateEducatedGroup(adjustment);
      });
      return adjustments;
    } else {
      List<EducatedGroup> adjustments = await getAllEducatedGroups();
      return adjustments;
    }
  }
}
