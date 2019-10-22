import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/screens/session/session_manager.dart';
import 'package:chw/src/screens/session/ui/session_card.dart';
import 'package:chw/src/ui/shared/loader.dart';
import 'package:chw/src/ui/shared/page_scaffold.dart';
import 'package:chw/src/ui/shared/slidable_item.dart';
import 'package:chw/src/resources/data_layer/repository.dart';

import 'package:chw/src/new_implementaion/database/database_providers/target_audience_database_provider.dart';

class SessionScreen extends StatefulWidget {
  static String tag = 'home-page';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SessionScreenState();
  }
}

class SessionScreenState extends State<SessionScreen> {
  Map<String, bool> isSyncing;
  int totalSessions = 0;
  int synchronizedSessions = 0;
  int localSessions = 0;
  var provider = new TargetAudienceDataProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSyncing = {};
  }

  @override
  Widget build(BuildContext context) {
    provider.getFromServer();
    var deviceWidth = MediaQuery.of(context).size.width;
    final bloc = Provider.of(context);
    bloc.getSessions();
    bloc.getMaterialSupplied();
    bloc.getSpecificMessage();
    final body = Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: bloc.sessions,
            builder:
                (BuildContext context, AsyncSnapshot<List<Session>> snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Loader('card_list'),
                );
              }
              totalSessions = snapshot.data.length;
              return Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Card(
                        elevation: 4.0,
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.add),
                                      Text(
                                        " $totalSessions",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.sync),
                                      StreamBuilder(
                                          stream: bloc.synchronizedSessions,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<int> snapshot) {
                                            return Text(
                                              "${snapshot.data == null || snapshot.data == 0 ? 0 : snapshot.data}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            );
                                          }),
                                      SizedBox(
                                        width: 10.0,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return Container(
//                          key: null,
                            child: SlidableItem(
                          body: SessionCard(snapshot.data[index],
                              isSyncing[snapshot.data[index].reference]),
                          extraIcon: Icons.sync,
                          extraLabel: 'Sync Online',
                          extraAction: () async {
                            setState(() {
                              isSyncing[snapshot.data[index].reference] = true;
                            });
                            bool isSynchronized =
                                await bloc.dataSynchronization(
                                    snapshot.data[index].reference);

                            if (isSynchronized == true) {
                              snapshot.data[index].isSynchronized = true;
                              var session = await bloc.saveUpdateSession(
                                  snapshot.data[index],
                                  snapshot.data[index].reference,
                                  true);
                              if (session['isLocalUpdated'] == 1) {
                                setState(() {
                                  isSyncing = {};
                                  bloc.getSessions();
                                });
                              }
                            } else {
                              print("NOT SYCHRONIZED");
                            }
                          },
                          deleteAction: () {
                            _showDialog(context, snapshot.data[index],
                                (actionType) {
                              switch (actionType) {
                                case 'Delete':
                                  bloc.deleteSession(
                                      snapshot.data[index].reference);
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
                                          child: SessionManager(
                                        reference:
                                            snapshot.data[index].reference,
                                        session: snapshot.data[index],
                                      ))),
                            );
                          },
                        ));
                      },
                    )
                  ],
                ),
              );
            }));

    return PageScaffold(
        true,
        'TULONGE AFYA',
        'Sessions',
        Image.asset(
          'assets/ipc.png',
          width: 30.0,
          height: 60.0,
        ),
        body,
        true, () {
      deleteStoreReference();
      prepareSessionReference();
      prepareSelectedAndParentEducationResources();
      Navigator.pushNamed(context, '/new_session');
    }, true);
  }
}

deleteStoreReference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('reference');
}

prepareSessionReference() async {
  Repository repo = Repository();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('reference', repo.prepareSessionReference());
}

prepareSelectedAndParentEducationResources() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('selectedChildrenElimu', '{}');
  prefs.setString('selectedParentElimu', '[]');
}

_showDialog(context, sessio, Function(String) action) {
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
                    text: "Session Ref: ",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: " ${sessio.reference} ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "inaondolewa.",
                    style: TextStyle(color: Colors.black)),
              ]),
            ))
          ],
        )),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
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
