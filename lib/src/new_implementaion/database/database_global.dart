import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/new_implementaion/database/tables/cso_table.dart' as csoTable;
import 'package:chw/src/new_implementaion/database/tables/education_type_table.dart' as educationTypeTable;
import 'package:chw/src/new_implementaion/database/tables/educated_group_table.dart' as educationGroupTable;
import 'package:chw/src/new_implementaion/database/tables/ipc_table.dart' as ipcTable;
import 'package:chw/src/new_implementaion/database/tables/participant_table.dart' as participantTable;
import 'package:chw/src/new_implementaion/database/tables/refferal_type_table.dart' as reffaralTypeTable;
import 'package:chw/src/new_implementaion/database/tables/specific_message_table.dart' as specificMessageTable;
import 'package:chw/src/new_implementaion/database/tables/target_audience_table.dart' as targetAudienceTable;
import 'package:chw/src/new_implementaion/database/tables/user_table.dart' as userTable;
import 'package:chw/src/new_implementaion/database/tables/material_table.dart' as materialTable;
import 'package:chw/src/new_implementaion/database/tables/village_table.dart' as villageTable;

class DatabaseHelper {

  final int version = 2;
  String dbName;
  // This code here will help to make the database helper class singleton
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
//
  factory DatabaseHelper() => _instance;
//
  static Database _db;
//
//
  DatabaseHelper.internal();
//  static DatabaseHelper instance;
//
//  factory DatabaseHelper({String databaseName}) {
//    if (instance == null) {
//      instance = new DatabaseHelper._internal(databaseName);
//    }
//    return instance;
//  }
//
//  DatabaseHelper._internal(this.dbName);

  void printDatabaseName () {
    print('tayari kwenye database helper');
    print(databaseName);
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    //Get application directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //prepare a database path
    String path = join( documentDirectory.path, databaseName + '.db'  );
    //open the database
    var ourDb = await openDatabase( path, version: version, onCreate: _onCreate );
    return ourDb;
  }


  Future deleteDbandRecreate({String databaseName}) async {
    //Get application directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //prepare a database path
    String path = join( documentDirectory.path, databaseName + '.db'  );
    await close();
    await deleteDatabase(path);
    _db = null;
    return db;
  }

  Future deleteDb() async {
    //Get application directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //prepare a database path
    String path = join( documentDirectory.path, databaseName + '.db'  );
    return await deleteDatabase(path);
  }


  void _onCreate(Database db, int version) async{
    await create_table(db, csoTable.tableName, csoTable.columns, csoTable.columnsDefinition);
    await create_table(db, educationGroupTable.tableName, educationGroupTable.columns, educationGroupTable.columnsDefinition);
    await create_table(db, educationTypeTable.tableName, educationTypeTable.columns, educationTypeTable.columnsDefinition);
    await create_table(db, ipcTable.tableName, ipcTable.columns, ipcTable.columnsDefinition);
    await create_table(db, participantTable.tableName, participantTable.columns, participantTable.columnsDefinition);
    await create_table(db, reffaralTypeTable.tableName, reffaralTypeTable.columns, reffaralTypeTable.columnsDefinition);
    await create_table(db, specificMessageTable.tableName, specificMessageTable.columns, specificMessageTable.columnsDefinition);
    await create_table(db, targetAudienceTable.tableName, targetAudienceTable.columns, targetAudienceTable.columnsDefinition);
    await create_table(db, userTable.tableName, userTable.columns, userTable.columnsDefinition);
    await create_table(db, materialTable.tableName, materialTable.columns, materialTable.columnsDefinition);
    await create_table(db, villageTable.tableName, villageTable.columns, villageTable.columnsDefinition);
  }

  Future create_table(Database db, tableName, tableColumns, columnsDefinition) async {

    final String columns = tableColumns.map(
            (column) => "$column ${columnsDefinition[column]}")
        .join(', ');
    final query = "CREATE TABLE IF NOT EXISTS $tableName ($columns)";
    print(query);
    await db.execute(query);
  }


  //Insertion
  Future<int> saveItem( String tableName, dynamic item) async {
    var dbClient =  await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    return res;
  }

  //Get Items
  Future<List<Map<String, dynamic>>> getAllItems(String tableName) async {
    var dbClient =  await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName");

    return result.toList();
  }

  //Get Items
  Future<List<Map<String, dynamic>>> getAllItemsByColumn(String tableName, String columName, dynamic value) async {
    var dbClient =  await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columName = '$value'");

    return result.toList();
  }

  //Get Items
  Future<List<Map<String, dynamic>>> getOrderdItemsByColumn(String tableName, String columName, dynamic value, orderBy, orderType) async {
    var dbClient =  await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columName = '$value' ORDER BY $orderBy $orderType");

    return result.toList();
  }

  //Get Items
  Future<List<Map<String, dynamic>>> getOrderdItems(String tableName, orderBy, orderType) async {
    var dbClient =  await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $orderBy $orderType");

    return result.toList();
  }

  // Get Counts of all items
  Future<int> getCount( String tableName) async {
    var dbClient =  await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  // Get Counts of all single items
  Future<int> getSingleItemCount( String tableName, String id) async {
    var dbClient =  await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName WHERE id = '$id'"));
  }

  // Get Counts of all single items
  Future<int> getSingleItemCountByColumn( String tableName, String columName, dynamic value) async {
    var dbClient =  await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName WHERE $columName = '$value'"));
  }

  // Get single item by id
  Future<dynamic> getItem( String tableName, String id) async {
    var dbClient =  await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = '$id'");
    if (result.length == 0) return null;
    return result;

  }

  // get item by specifying column
  Future<dynamic> getItemByColumn( String tableName, String columnName, dynamic value) async {
    var dbClient =  await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnName = '$value'");
    if (result.length == 0) return null;
    return result;

  }

  // delete column in a database
  Future<int> deleteItem( String tableName, String id) async {
    var dbClient =  await db;

    return await dbClient.delete(tableName,
        where: "id = ?", whereArgs: ["$id"]);
  }


  // delete column in a database using specified
  Future<int> deleteItemByColumn( String tableName, String column, dynamic value) async {
    var dbClient =  await db;

    return await dbClient.delete(tableName,
        where: "$column = ?", whereArgs: [value]);
  }


  // update Item in database
  Future<int> updateItem( String tableName, dynamic item) async {
    var dbClient =  await db;
    return await dbClient.update(tableName,
        item.toMap(), where: "id = ?", whereArgs: [item.id]);
  }

  // update Item in database
  Future<int> updateItemByColumn( String tableName, dynamic item, String column, dynamic value) async {
    var dbClient =  await db;
    return await dbClient.update(tableName,
        item.toMap(), where: "$column = ?", whereArgs: [value]);
  }


  Future<int> addOrUpdateItem( String tableName, dynamic item,[String column, dynamic value]) async {
    int itemCount;
    if( column == null ) {
      itemCount = await getSingleItemCount( tableName, item.id);
      if ( itemCount == 0 ) {
        return saveItem( tableName, item);
      }else {
        return updateItem( tableName, item);
      }
    } else {
      itemCount = await getSingleItemCountByColumn(tableName, column, value);
      if ( itemCount == 0 ) {
        return saveItem( tableName, item);
      }else {
        return updateItemByColumn( tableName, item, column, value);
      }
    }

  }


  // Get single item by id
  Future<dynamic> getListOfTables() async {
    var dbClient =  await db;

    var result = await dbClient.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    if (result.length == 0) return null;
    print('------ all tables here -----');
    print(result);
    return result;

  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  void resetDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //prepare a database path
    String path = join( documentDirectory.path, databaseName + '.db'  );
    await deleteDatabase(path);
    _db = null;
  }



}

