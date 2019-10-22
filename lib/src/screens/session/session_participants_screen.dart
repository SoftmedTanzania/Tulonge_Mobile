import 'package:flutter/material.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/screens/session/members_manager.dart';
import 'package:chw/src/screens/session/ui/participant_card.dart';
import 'package:chw/src/ui/shared/page_scaffold.dart';
import 'package:chw/src/ui/shared/slidable_item.dart';

class SessionParticipantsScreen extends StatefulWidget {
  String reference;

  SessionParticipantsScreen({this.reference});

  @override
  State<StatefulWidget> createState() {
    return SessionParticipantsScreenState(reference: this.reference);
  }
}

class SessionParticipantsScreenState extends State<SessionParticipantsScreen> {
  String reference;

  SessionParticipantsScreenState({this.reference});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    final bloc = Provider.of(context);
    bloc.getParticipants(reference);
    final body = Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: bloc.participants,
            builder: (BuildContext context,
                AsyncSnapshot<List<ParticipantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return SlidableItem(
                    body: ParticipantCard(snapshot.data[index]),
                    deleteAction: () async {
                      _showDialog(context, snapshot.data[index], (actionType){
                        switch(actionType){
                          case 'Delete':
                            bloc.deleteParticipants(snapshot.data[index].reference, snapshot.data[index].id);
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
                                    child: MemberManagerScreen(
                                  reference: reference,
                                  participant: snapshot.data[index],
                                ))),
                      );
                    },
                  );
                },
              );
            }));

    return PageScaffold(false, 'TULONGE AFYA', 'Washiriki (${this.reference})',
        Icon(Icons.group), body, true, () async {
      final result = await Navigator.push(
        context,
        // We'll create the SelectionScreen in the next step!
        MaterialPageRoute(
            builder: (context) => Provider(
                    child: MemberManagerScreen(
                  reference: reference,
                ))),
      );
    }, false);
  }
}

_showDialog(context, participant, Function(String) action) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Unauhakika unahitaji kufuta?"),
        content: InkWell(
          child: Container(
            child: Row(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>
                  [
                    TextSpan(text:"Mshiriki ",style: TextStyle(color: Colors.black)),
                    TextSpan(text:"${participant.name} ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    TextSpan(text:"ataondolewa.",style: TextStyle(color: Colors.black)),
                  ]
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Ondoa", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
            onPressed: () {
              action('Delete');
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('Sitisha',  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
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
