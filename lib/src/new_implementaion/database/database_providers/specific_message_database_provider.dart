import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/specific_message_model.dart';
import 'package:chw/src/new_implementaion/database/tables/specific_message_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class SpecificMessageDataProvider {

  ApiProvider api = new ApiProvider();
  SpecificMessageDataProvider();

  //Insertion
  Future<int> saveSpecificMessage(SpecificMessage educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, educationType);
  }

  //Get Users
  Future<List<SpecificMessage>> getAllSpecificMessages() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => SpecificMessage.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<SpecificMessage>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => SpecificMessage.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<SpecificMessage> getSpecificMessage(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new SpecificMessage.fromDatabase(result.first);
  }

  Future<int> deleteSpecificMessage(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateSpecificMessage(SpecificMessage educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, educationType);
  }

  Future<int> addOrUpdateSpecificMessage(SpecificMessage educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, educationType);
  }

  Future<List<SpecificMessage>> getFromServer() async {
    try {
      var items = await api.getSpecificMessageList();
      List<SpecificMessage> educationTypes = [];
      items.forEach((item) {
        educationTypes.add(SpecificMessage.fromServer(item));
      });
      return educationTypes;
    } catch(e) {
      return [];
    }
  }

  // a function to initialize educationType details
  Future<List<SpecificMessage>> initiateSpecificMessage([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<SpecificMessage> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateSpecificMessage(adjustment);
      });
      return adjustments;
    } else {
      List<SpecificMessage> adjustments = await getAllSpecificMessages();
      return adjustments;
    }
  }
}
