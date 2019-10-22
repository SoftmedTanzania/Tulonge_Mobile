import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/material_model.dart';
import 'package:chw/src/new_implementaion/database/tables/material_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class MaterialDataProvider {

  ApiProvider api = new ApiProvider();
  MaterialDataProvider();

  //Insertion
  Future<int> saveMaterialModel(MaterialModel material) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, material);
  }

  //Get Users
  Future<List<MaterialModel>> getAllMaterialModels() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => MaterialModel.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<MaterialModel>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => MaterialModel.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<MaterialModel> getMaterialModel(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new MaterialModel.fromDatabase(result.first);
  }

  Future<int> deleteMaterialModel(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateMaterialModel(MaterialModel material) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, material);
  }

  Future<int> addOrUpdateMaterialModel(MaterialModel material) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, material);
  }

  Future<List<MaterialModel>> getFromServer() async {
    try {
      var items = await api.getMaterialList();
      List<MaterialModel> materials = [];
      items.forEach((item) {
        materials.add(MaterialModel.fromServer(item));
      });
      return materials;
    } catch(e) {
      print(e.message);
      return [];
    }

  }

  // a function to initialize material details
  Future<List<MaterialModel>> initiateMaterialModel([fromServer = false]) async {
    var count = await getCount();
    print(count);
    if (count == 0 || fromServer) {
      List<MaterialModel> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateMaterialModel(adjustment);
      });
      return adjustments;
    } else {
      List<MaterialModel> adjustments = await getAllMaterialModels();
      return adjustments;
    }
  }
}
