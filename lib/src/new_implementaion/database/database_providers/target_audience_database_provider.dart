import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/target_audience_model.dart';
import 'package:chw/src/new_implementaion/database/tables/target_audience_table.dart'
    as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class TargetAudienceDataProvider {

  ApiProvider api = new ApiProvider();
  TargetAudienceDataProvider();

  //Insertion
  Future<int> saveTargetAudience(TargetAudience targetAudience) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, targetAudience);
  }

  //Get Users
  Future<List<TargetAudience>> getAllTargetAudiences() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => TargetAudience.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<TargetAudience>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
        await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => TargetAudience.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<TargetAudience> getTargetAudience(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new TargetAudience.fromDatabase(result.first);
  }

  Future<int> deleteTargetAudience(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateTargetAudience(TargetAudience targetAudience) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, targetAudience);
  }

  Future<int> addOrUpdateTargetAudience(TargetAudience targetAudience) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, targetAudience);
  }

  Future<List<TargetAudience>> getFromServer() async {
    try {
      var items = await api.getTargetAudience();
      List<TargetAudience> targetAudiences = [];
      items.forEach((item) {
        targetAudiences.add(TargetAudience.fromServer(item));
      });
      return targetAudiences;
    } catch(e) {
      return [];
    }

  }

  // a function to initialize targetAudience details
  Future<List<TargetAudience>> initiateTargetAudience([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<TargetAudience> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateTargetAudience(adjustment);
      });
      return adjustments;
    } else {
      List<TargetAudience> adjustments = await getAllTargetAudiences();
      return adjustments;
    }
  }
}
