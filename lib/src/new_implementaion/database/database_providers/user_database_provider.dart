import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/user_model.dart';
import 'package:chw/src/new_implementaion/database/tables/user_table.dart'
as table;
import 'package:chw/src/resources/networ_layer/api_provider.dart';

class UserDataProvider {

  ApiProvider api = new ApiProvider();
  UserDataProvider();

  //Insertion
  Future<int> saveUser(User user) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, user);
  }

  //Get Users
  Future<List<User>> getAllUsers() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => User.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<User>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => User.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<User> getUser(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new User.fromDatabase(result.first);
  }

  Future<int> deleteUser(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateUser(User user) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, user);
  }

  Future<int> addOrUpdateUser(User user) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, user);
  }


  // a function to initialize user details
  Future<List<User>> initiateUser(groupId) async {
      List<User> adjustments = await getAllUsers();
      return adjustments;
  }
}
