import 'dart:async';
import 'package:chw/src/new_implementaion/database/database_global.dart';
import 'package:chw/src/new_implementaion/models/participant_model.dart';
import 'package:chw/src/new_implementaion/database/tables/participant_table.dart'
as table;
import 'package:chw/src/resources/networ_layer/api_provider.dart';

class ParticipantDataProvider {

  ApiProvider api = new ApiProvider();
  ParticipantDataProvider();

  //Insertion
  Future<int> saveParticipant(Participant participant) async {
    var dbClient = DatabaseHelper();
    return await dbClient.saveItem(table.tableName, participant);
  }

  //Get Users
  Future<List<Participant>> getAllParticipants() async {
    var dbClient = DatabaseHelper();
    var items = await dbClient.getAllItems(table.tableName);
    return items.map((item) => Participant.fromDatabase(item)).toList();
  }

  //Get Users
  Future<List<Participant>> getAll() async {
    var dbClient = DatabaseHelper();
    var items =
    await dbClient.getOrderdItems(table.tableName, 'last_update', 'desc');
    return items.map((item) => Participant.fromDatabase(item)).toList();
  }

  Future<int> getCount() async {
    var dbClient = DatabaseHelper();
    return await dbClient.getCount(table.tableName);
  }

  Future<Participant> getParticipant(String id) async {
    var dbClient = DatabaseHelper();
    var result = await dbClient.getItem(table.tableName, id);
    if (result == null) return result;
    return new Participant.fromDatabase(result.first);
  }

  Future<int> deleteParticipant(String id) async {
    var dbClient = DatabaseHelper();
    return await dbClient.deleteItem(table.tableName, id);
  }

  Future<int> updateParticipant(Participant participant) async {
    var dbClient = DatabaseHelper();
    return await dbClient.updateItem(table.tableName, participant);
  }

  Future<int> addOrUpdateParticipant(Participant participant) async {
    var dbClient = DatabaseHelper();
    return await dbClient.addOrUpdateItem(table.tableName, participant);
  }

  Future<List<Participant>> getFromServer() async {
    try {
      var items = await api.getEducationGroupsList();
      List<Participant> participants = [];
      items.forEach((item) {
        participants.add(Participant.fromServer(item));
      });
      return participants;
    } catch(e) {
      return [];
    }
  }

  // a function to initialize participant details
  Future<List<Participant>> initiateParticipant() async {
      List<Participant> adjustments = await getAllParticipants();
      return adjustments;
  }
}
