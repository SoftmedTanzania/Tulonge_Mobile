import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/educated_type_model.dart';
import 'package:chw/src/new_implementaion/database/tables/education_type_table.dart'
as table;
import 'package:chw/src/new_implementaion/api_provider.dart';

class EducationTypeDataProvider {

  ApiProvider api = new ApiProvider();
  EducationTypeDataProvider();

  //Insertion
  Future<int> saveEducationType(EducationType educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, educationType);
  }

  //Get Users
  Future<List<EducationType>> getAllEducationTypes() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => EducationType.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<EducationType>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => EducationType.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<EducationType> getEducationType(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new EducationType.fromDatabase(result.first);
  }

  Future<int> deleteEducationType(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateEducationType(EducationType educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, educationType);
  }

  Future<int> addOrUpdateEducationType(EducationType educationType) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, educationType);
  }

  Future<List<EducationType>> getFromServer() async {
    try {
      var items = await api.getEducationTypeList();
      List<EducationType> educationTypes = [];
      items.forEach((item) {
        educationTypes.add(EducationType.fromServer(item));
      });
      return educationTypes;
    } catch(e) {
      return [];
    }
  }

  // a function to initialize educationType details
  Future<List<EducationType>> initiateEducationType([fromServer = false]) async {
    var count = await getCount();
    if (count == 0 || fromServer) {
      List<EducationType> adjustments = await getFromServer();
      adjustments.forEach((adjustment) async {
        var saved = await addOrUpdateEducationType(adjustment);
      });
      return adjustments;
    } else {
      List<EducationType> adjustments = await getAllEducationTypes();
      return adjustments;
    }
  }
}
