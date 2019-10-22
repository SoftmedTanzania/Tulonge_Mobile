import 'package:chw/src/new_implementaion/models/participant_model.dart';

class SessionModel {
  String sessionDate;
  String toolUsed;
  String kadi;
  String game;
  String material;
  List<Participant> participants;
  num sessionNumber;
  DateTime minDate;
  DateTime maxDate;

  SessionModel({
    this.sessionDate,
    this.toolUsed,
    this.kadi,
    this.game,
    this.participants,
    this.material,
    this.sessionNumber,
    this.minDate,
    this.maxDate,
  });
}
