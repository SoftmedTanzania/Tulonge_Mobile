import 'package:flutter/material.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/screens/session/mazoezi_manager.dart';
import 'package:chw/src/screens/session/ui/zoezi_card.dart';
import 'package:chw/src/ui/shared/loader.dart';
import 'package:chw/src/ui/shared/page_scaffold.dart';
import 'package:chw/src/ui/shared/slidable_item.dart';

class SessionMazoeziScreen extends StatefulWidget {
  String reference;

  SessionMazoeziScreen({this.reference});

  @override
  State<StatefulWidget> createState() {
    return SessionMazoeziScreenState(reference: this.reference);
  }
}

class SessionMazoeziScreenState extends State<SessionMazoeziScreen> {
  String reference;

  SessionMazoeziScreenState({this.reference});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    final bloc = Provider.of(context);
    bloc.getMazoezi(reference);
    final body = Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: bloc.mazoezi,
            builder: (BuildContext context,
                AsyncSnapshot<List<CardGameModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Loader('card_list'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return SlidableItem(
                    body: ZoeziCard(snapshot.data[index]),
                    deleteAction: () async {
                      _showDialog(context, snapshot.data[index], (actionType) {
                        switch (actionType) {
                          case 'Delete':
                            bloc.deleteMazoezi(snapshot.data[index].reference,
                                snapshot.data[index].id);
                            break;
                          case 'Cancel':
                            break;
                          default:
                            break;
                        }
                      });
                    },
                    updateAction: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Provider(
                                    child: MazoeziManagerScreen(
                                  reference: reference,
                                  mazoezi: snapshot.data[index],
                                ))),
                      );
                    },
                  );
                },
              );
            }));

    return PageScaffold(false, 'TULONGE AFYA', 'Taarifa ya Mazoezi',
        Icon(Icons.group), body, true, () async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Provider(
                    child: MazoeziManagerScreen(
                  reference: reference,
                ))),
      );
    }, false);
  }
}

_showDialog(context, zoez, Function(String) action) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Unauhakika unahitaji kufuta?"),
        content: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "Zoezi la ",
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "${zoez.date}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "litaondolewa.",
                        style: TextStyle(color: Colors.black)),
                  ]),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              "Ondoa",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              action('Delete');
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text(
              'Sitisha',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              action('Cancel');
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
