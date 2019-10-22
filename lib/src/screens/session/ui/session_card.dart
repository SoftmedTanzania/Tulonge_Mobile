import 'package:flutter/material.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/screens/session/session_mazoezi_screen.dart';
import 'package:chw/src/screens/session/session_participants_screen.dart';

class SessionCard extends StatefulWidget {
  Session session;
  bool isSyncing;
  final global = GlobalKey();

  SessionCard(this.session, this.isSyncing);

  @override
  State<StatefulWidget> createState() {
    print(this.isSyncing);
    return SessionCardState(this.session, this.isSyncing, global);
  }
}

class SessionCardState extends State<SessionCard> {
  Session session;
  bool isSyncing;
  GlobalKey key;

  SessionCardState(this.session, this.isSyncing, this.key);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    final bloc = Provider.of(context);
    return Card(
      key: key,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      elevation: 0.09,
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
                            "Kumbu No: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(session.reference),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Kijiji/Mtaa: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(session.event_place),
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
                child: Row(
              children: <Widget>[
                Text(
                  "CSO: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(session.cso_name),
              ],
            )),
            Container(
              child: Row(
                children: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          // We'll create the SelectionScreen in the next step!
                          MaterialPageRoute(
                              builder: (context) => Provider(
                                      child: SessionParticipantsScreen(
                                    reference: session.reference,
                                  ))),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.group,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Washiriki')
                        ],
                      )),
                  FlatButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Provider(
                                      child: SessionMazoeziScreen(
                                    reference: session.reference,
                                  ))),
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.assignment,
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Mazoez/Act')
                        ],
                      )),
                ],
              ),
            ),
            StreamBuilder(
                stream: bloc.isSynchronized,
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, bool>> snapshot) {
                  return isSyncing == true && snapshot.data == null?
                  RefreshProgressIndicator(): snapshot.data != null && snapshot.data[session.reference] == true?Container():Container();
                }),
          ],
        ),
      ),
    );
  }
}
