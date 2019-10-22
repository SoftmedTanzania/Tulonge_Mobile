import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/database/tables/ipc_table.dart'
as table;
import 'package:chw/src/resources/networ_layer/api_provider.dart';

class IpcDataProvider {

  ApiProvider api = new ApiProvider();
  IpcDataProvider();

  //Insertion
  Future<int> saveIpc(Ipc ipc) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, ipc);
  }

  //Get Users
  Future<List<Ipc>> getAllIpcs() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => Ipc.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<Ipc>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => Ipc.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<Ipc> getIpc(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new Ipc.fromDatabase(result.first);
  }

  Future<int> deleteIpc(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateIpc(Ipc ipc) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, ipc);
  }

  Future<int> addOrUpdateIpc(Ipc ipc) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, ipc);
  }

  Future<List<Ipc>> getFromServer() async {
    try {
      var items = await api.getEducationGroupsList();
      List<Ipc> ipcs = [];
      items.forEach((item) {
        ipcs.add(Ipc.fromServer(item));
      });
      return ipcs;
    } catch(e) {
      return [];
    }
  }

  // a function to initialize ipc details
  Future<List<Ipc>> initiateIpc() async {
      List<Ipc> adjustments = await getAllIpcs();
      return adjustments;
  }
}
