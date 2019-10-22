import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/cso_model.dart';
import 'package:chw/src/new_implementaion/database/tables/cso_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class CsoDataProvider {

  ApiProvider api = new ApiProvider();
  CsoDataProvider();

  //Insertion
  Future<int> saveCso(Cso cso) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, cso);
  }

  //Get Users
  Future<List<Cso>> getAllCsos() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => Cso.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<Cso>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => Cso.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<Cso> getCso(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new Cso.fromDatabase(result.first);
  }

  Future<int> deleteCso(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateCso(Cso cso) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, cso);
  }

  Future<int> addOrUpdateCso(Cso cso) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, cso);
  }

  Future<List<Cso>> getFromServer() async {
    try {
      var items = await api.getCSOList();
      List<Cso> csos = [];
      items.forEach((item) {
        csos.add(Cso.fromServer(item));
      });
      return csos;
    } catch(e) {
      print(e.message);
      return [];
    }

  }

  // a function to initialize cso details
  Future<List<Cso>> initiateCso([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<Cso> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateCso(adjustment);
      });
      return adjustments;
    } else {
      List<Cso> adjustments = await getAllCsos();
      return adjustments;
    }
  }
}
