class CardGameModel {
  final String id;
  final String reference;
  final String type;
  final String date;
  final String distributed_tools;
  final String participants;
  final String cards_games;

  CardGameModel({
    this.id,
    this.reference,
    this.type,
    this.date,
    this.distributed_tools,
    this.participants,
    this.cards_games,
  });

  factory CardGameModel.fromJson(Map<String, dynamic> data) => CardGameModel(
      id: data['id'].toString(),
      reference: data['reference'],
      distributed_tools: data['distributed_tools'],
      type: data['type'],
      date: data['date'],
      cards_games: data['cards_games'],
      participants: data['participants'],
  );

  Map<String, String> toJson() => {
        'reference': this.reference,
        'distributed_tools': this.distributed_tools,
        'cards_games': this.cards_games,
        'participants': this.participants,
        'date': this.date.toString(),
        'type': this.type,
      };
}
