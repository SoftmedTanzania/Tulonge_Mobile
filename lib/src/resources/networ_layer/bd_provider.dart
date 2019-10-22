import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chw/src/models/basic_information.dart';
import 'package:chw/src/models/target_audience.dart';

class DbProvider {
  static final _databaseName = "contact_archive.db";
  static final _databaseVersion = 1;

  static final cso_table = "cso";
  static final session_table = "session";
  static final participant_table = 'participants';
  static final education_table = 'education';
  static final target_audience_table = 'target_audience';
  static final basic_information_table = 'basic_information';
  static final act_card_game_table = 'card_game';

  /**
   * CSO Table columns
   * */

  static final columnStatus = 'status';

  /**
   * Session Table columns
   * */

  static final columnSessionReference = 'reference';
  static final isSynchronized = "isSynchronized";

  /**
   * Basic Information table columns
   */

  static final columnReference = 'reference';
  static final columnCommunityReaderName = 'community_leader_name';
  static final columnCommunityReaderPhone = 'community_leader_phone';
  static final columnCSO = 'cso';
  static final columnCSOName = 'cso_name';
  static final columnEventPlace = 'event_place';
  static final columnFacilitatorPhoneNumber = 'facilitator_phone_number';
  static final columnFacilitatorName = 'facilitator_name';
  static final facilitatorType = 'facilitator_type';
  static final columnHealthEducationProvided = 'health_education_provided';
  static final columnGPSCoordinatorS = 'gps_cordinator_s';
  static final columnGPSCoordinatorE = 'gps_cordinator_e';
  static final columnGPSToolUsed = 'gps_tool_used';
  static final columnWard = 'ward';
  static final columnDistrict = 'district';
  static final columnRegion = 'region';
  static final columnVenue = 'venue';

  /**
   * Participant Table columns
   * */

//  static final columnReference = 'reference';
  static final columnName = 'name';
  static final columnAge = 'age';
  static final columnGender = 'gender';
  static final columnPhoneNumber = 'phone_number';
  static final columnMaritalStatus = 'marital_status';

  /**
   * Education table columns
   */
  //  static final columnReference = 'reference';
  static final columnHivHealthEducationProvided =
      'hiv_health_education_provided';
  static final columnMalariaHealthEducationProvided =
      'malaria_health_education_provided';
  static final columnMnhcHealthEducationProvided =
      'mnhc_health_education_provided';

  /**
   * Target Audience
   */
//  static final columnReference = 'reference';
//  static final columnName = 'name';
  static final columnId = 'id';
  static final columnValue = 'value';

  /**
   * Act type Card / Game
   */

//  this.participants,
//  this.cards_games,
  static final columnType = 'type';
  static final columnDate = 'date';
  static final columnTools = 'distributed_tools';
  static final columnParticipant = 'participants';
  static final columnCardeGame = 'cards_games';

  // make this a singleton class
  DbProvider._privateConstructor();

  static final DbProvider instance = DbProvider._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
//    return await deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    /**
     * Creating session table
     */
    await db.execute("CREATE TABLE $cso_table (" +
        "$columnId INTEGER PRIMARY KEY," +
        "$columnName TEXT NOT NULL," +
        "$columnStatus INTEGER NOT NULL" +
        ")");

    /**
     * Creating session table
     */
    await db.execute("CREATE TABLE $session_table (" +
        "$columnId INTEGER PRIMARY KEY," +
        "$columnReference TEXT NOT NULL," +
        "$isSynchronized INTEGER" +
        ")");

    /**
     * Creating table for basic information
     */
    await db.execute("CREATE TABLE $basic_information_table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnReference TEXT NOT NULL,"
        "$columnCommunityReaderName TEXT  NULL,"
        "$columnCommunityReaderPhone TEXT  NULL,"
        "$columnCSO TEXT  NULL,"
        "$columnCSOName TEXT  NULL,"
        "$columnEventPlace TEXT  NULL,"
        "$columnFacilitatorPhoneNumber TEXT  NULL,"
        "$columnFacilitatorName TEXT  NULL,"
        "$facilitatorType TEXT  NULL,"
        "$columnGPSCoordinatorS TEXT  NULL,"
        "$columnGPSCoordinatorE TEXT  NULL,"
        "$columnGPSToolUsed TEXT  NULL,"
        "$columnVenue TEXT  NULL,"
        "$columnWard TEXT  NULL,"
        "$columnDistrict TEXT  NULL,"
        "$columnRegion TEXT  NULL"
        ")");

    /**
     * Creating participant table
     */
    await db.execute("CREATE TABLE $participant_table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnReference TEXT NOT NULL,"
        "$columnName TEXT NOT NULL,"
        "$columnGender TEXT NOT NULL,"
        "$columnAge TEXT NOT NULL,"
        "$columnPhoneNumber TEXT NOT NULL,"
        "$columnMaritalStatus TEXT NOT NULL"
        ")");

    /**
     * Creating table for Education
     */
    await db.execute("CREATE TABLE $education_table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnReference TEXT NOT NULL,"
        "$columnHealthEducationProvided INTEGER DEFAULT 0,"
        "$columnMalariaHealthEducationProvided INTEGER DEFAULT 0,"
        "$columnMnhcHealthEducationProvided INTEGER DEFAULT 0"
        ")");

    /**
     * Creating table for target Audience
     */
    await db.execute("CREATE TABLE $target_audience_table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnReference TEXT NOT NULL,"
        "$columnName TEXT NOT NULL,"
        "$columnValue TEXT NOT NULL"
        ")");

    /**
     * Creating table for Acts
     */
    await db.execute("CREATE TABLE $act_card_game_table ("
        "$columnId INTEGER PRIMARY KEY,"
        "$columnReference TEXT NOT NULL,"
        "$columnType TEXT NOT NULL,"
        "$columnTools TEXT NOT NULL,"
        "$columnParticipant TEXT NOT NULL,"
        "$columnCardeGame TEXT NOT NULL,"
        "$columnDate TEXT NOT NULL"
        ")");
  }

  /**
   *  HELPER METHODS
   */

  // Insert Helper methods

  // insert basic information
  Future<int> insertBasicInformation(Map<String, dynamic> row) async {
    Database db = await instance.database;
    try {
      var results = await db.insert(basic_information_table, row);
      return results;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  // insert basic information
  Future<int> updateBasicInformation(
      BasicInformationModel row, String reference) async {
    Database db = await instance.database;
    try {
      var results = await db.update("$basic_information_table", row.toJson(),
          where: "id = ?", whereArgs: [row.reference]);

      return results;
    } catch (e) {
      return null;
    }
  }

  // insert target
  Future<int> insertTargetAudience(TargetAudience row) async {
    Database db = await instance.database;
    try {
      return await db.insert(target_audience_table, row.toJson());
    } catch (e) {
      print("FAILED");
    }
    return null;
  }

  // insert target
  Future<int> updateTargetAudience(TargetAudience row, reference) async {
    Database db = await instance.database;
    try {
      return await db.update(target_audience_table, row.toJson(),
          where: "id = ?", whereArgs: [reference]);
    } catch (e) {
      print("FAILED");
    }
    return null;
  }

  // insert participants
  Future<int> insertParticipant(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(participant_table, row);
  }

  Future<int> updateParticipant(String session_id, String participant_id,
      Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(participant_table, row,
        where: " reference = ? AND id = ?",
        whereArgs: [session_id, participant_id]);
  }

  Future<int> deleteParticipant(
      String session_id, String participant_id) async {
    Database db = await instance.database;
    return await db.delete(participant_table,
        where: " reference = ? AND id = ?",
        whereArgs: [session_id, participant_id]);
  }

  // insert session
  Future<Map<String, dynamic>> insertSession(Map<String, dynamic> row) async {
    Database db = await instance.database;
    Map<String, dynamic> lastItem;
    var results = await db.insert(session_table, row);
    if (results != null) {
      var lastInsertIdArray = await db.rawQuery("SELECT last_insert_rowid()");

      var lastRow = await db.rawQuery(
          "SELECT * FROM $session_table WHERE id = ${lastInsertIdArray[0]['last_insert_rowid()']} ORDER BY rowid DESC LIMIT 1");
      lastItem = lastRow[0];
    }

    return lastItem;
  }

  // insert session
  Future<Map<String, dynamic>> updateSession(
      Map<String, dynamic> row, reference) async {
    Database db = await instance.database;
    Map<String, dynamic> item;
    var results = await db.rawQuery(
        "UPDATE $session_table SET $isSynchronized = ${row['isSynchronized']==true?1:0} WHERE reference = '${reference}'");
    if (results != null) {
      var lastRow = await db
          .rawQuery("SELECT * FROM $session_table ORDER BY rowid DESC LIMIT 1");
      item = lastRow[0];
    }

    return item;
  }

  // insert Education
  Future<int> insertEducation(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(education_table, row);
  }

  // insert Education
  Future<int> insertMazoezi(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var results = await db.insert(act_card_game_table, row);
    return results;
  }

  // insert Mazoez
  Future<int> updateMazoezi(
      Map<String, dynamic> row, String referenceId, String zoeziId) async {
    Database db = await instance.database;
    return await db.update(act_card_game_table, row,
        where: " reference = ? AND id = ?", whereArgs: [referenceId, zoeziId]);
  }

  // delete Mazoezi
  Future<int> deleteMazoezi(String referenceId, String zoeziId) async {
    Database db = await instance.database;
    return await db.delete(act_card_game_table,
        where: " reference = ? AND id = ?", whereArgs: [referenceId, zoeziId]);
  }

//   All of the rows are returned as a list of maps, where each map is
//   a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllSessions() async {
    Database db = await instance.database;
    List<Map> results = await db.rawQuery(''
        'SELECT S.reference as reference,'
        ' B.community_leader_name as community_leader_name,'
        ' B.community_leader_phone as community_leader_phone,'
        ' B.cso as cso,'
        ' B.cso_name as cso_name,'
        ' B.event_place as event_place,'
        ' B.facilitator_phone_number as facilitator_phone_number,'
        ' B.facilitator_name as facilitator_name,'
        ' B.facilitator_type as facilitator_type,'
        ' B.gps_cordinator_s as gps_cordinator_s,'
        ' B.gps_cordinator_e as gps_cordinator_e,'
        ' B.gps_tool_used as gps_tool_used,'
        'S.isSynchronized as isSynchronized'
        '  FROM $session_table S INNER JOIN $basic_information_table B ON B.reference=S.reference');
    return results;
  }

  // Geting session based on reference id
  Future<List<Map<String, dynamic>>> getSession(reference) async {
    Database db = await instance.database;
    List<Map> results = await db.rawQuery(''
        'SELECT S.reference as reference,'
        ' B.community_leader_name as community_leader_name,'
        ' B.community_leader_phone as community_leader_phone,'
        ' B.cso as cso,'
        ' B.cso_name as cso_name,'
        ' B.event_place as event_place,'
        ' B.facilitator_phone_number as facilitator_phone_number,'
        ' B.facilitator_name as facilitator_name,'
        ' B.facilitator_type as facilitator_type,'
        ' B.gps_cordinator_s as gps_cordinator_s,'
        ' B.gps_cordinator_e as gps_cordinator_e,'
        ' B.gps_tool_used as gps_tool_used'
        ' FROM $session_table S '
        'INNER JOIN $basic_information_table B ON B.reference=S.reference '
        'WHERE B.reference=\'$reference\'');
    return results;
  }

  Future<List<Map<String, dynamic>>> getParticipants(reference) async {
    Database db = await instance.database;
    List<Map> result = await db.rawQuery(''
        "SELECT * FROM $participant_table WHERE reference='${reference}'");
    return result;
  }

  Future<List<Map<String, dynamic>>> getSessionParticipants(reference) async {
    Database db = await instance.database;
    List<Map> result = await db.rawQuery(''
        "SELECT * FROM $participant_table WHERE reference='${reference}'");
    return result;
  }

  Future<List<Map<String, dynamic>>> getMazoezi(reference) async {
    Database db = await instance.database;
    List<Map> result = await db.rawQuery(''
        "SELECT * FROM $act_card_game_table WHERE reference='${reference}'");
    return result;
  }

  Future<bool> deleteSession(reference) async {
    Database db = await instance.database;

    try {
      var result = await db.rawQuery(''
          "DELETE FROM $session_table  WHERE reference='${reference}'");
      var result2 = await db.rawQuery(''
          "DELETE FROM $basic_information_table  WHERE reference='${reference}'");
      var result_education = await db.rawQuery(''
          "DELETE FROM $education_table WHERE reference='${reference}'");
      var result_basic = await db.rawQuery(''
          "DELETE FROM $basic_information_table WHERE reference='${reference}'");
      var result_card_game = await db.rawQuery(''
          "DELETE FROM $act_card_game_table WHERE reference='${reference}'");
      var result_participant = await db.rawQuery(''
          "DELETE FROM $participant_table WHERE reference='${reference}'");
      var result_sesion = await db.rawQuery(''
          "DELETE FROM $session_table WHERE reference='${reference}'");
      return true;
    } catch (e) {
      return true;
    }
  }

  prepareSessionReference() {
    var year = new DateTime.now().year;
    var month = new DateTime.now().month;
    return year.toString() +
        month.toString() +
        '(MOBILE)' +
        DateTime.now().millisecondsSinceEpoch.toString();
  }
}
