import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/resources/constants.dart';

class ZoeziCard extends StatelessWidget {
  CardGameModel cardGame;

  ZoeziCard(this.cardGame);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

//    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Card(
      child: Container(
        width: deviceWidth,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Tarehe: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cardGame.date),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Kumb No: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(cardGame.reference),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Aina Iliyotumika: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(cardGame.type),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        "Vifaa: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Row(
                      children: <Widget>[
                        ...prepareArray(cardGame.distributed_tools)
                            .map((toolId) {
                          Map<String, dynamic> tool = getToolEntry(toolId);
                          return tool != null
                              ? Text(
                                  "${tool['name']}, ",
                                )
                              : Text("");
                        }).toList()
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(
                        "${cardGame.type}: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Row(
                      children: <Widget>[
                        ...prepareArray(cardGame.cards_games).map((cardId) {
                          Map<String, dynamic> card =
                              getCardGameEntiry(GAMES_CARDS, cardId);
                          return card != null
                              ? Text(
                                  "${card['display']}, ",
                                )
                              : Text("");
                        }).toList()
                      ],
                    )
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

prepareArray(data) {
  data = data.replaceAll(new RegExp(r'\['), '');
  data = data.replaceAll(new RegExp(r'\]'), '');
  return data.split(',');
}

Map<String, dynamic> getCardGameEntiry(cardGames, cardId) {
  Map<String, dynamic> cardgame;
  cardGames.forEach((cardGameItem) {
    var cardGameValue = cardGameItem['value']
        .toString()
        .replaceAll(new RegExp(r"\s\b|\b\s"), "");
    var cardIdentity = cardId.replaceAll(new RegExp(r"\s\b|\b\s"), "");
    if (cardGameValue == cardIdentity) {
      cardgame = cardGameItem;
    }
  });
  return cardgame;
}
Map<String, dynamic> getToolEntry(toolId)  {
  Map<String, dynamic> cardgame;

//  cardGames.forEach((cardGameItem) {
//    var cardGameValue = cardGameItem['value']
//        .toString()
//        .replaceAll(new RegExp(r"\s\b|\b\s"), "");
//    var cardIdentity = cardId.replaceAll(new RegExp(r"\s\b|\b\s"), "");
//    if (cardGameValue == cardIdentity) {
//      cardgame = cardGameItem;
//    }
//  });
  return cardgame;
}
