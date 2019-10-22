import 'package:chw/src/new_implementaion/models/session_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/forms/add_zoezi.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/sessionAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class ZoeziScreen extends StatelessWidget {

  _navigateToAdd(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, __, ___) => AddZoezi(),
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
      new FadeTransition(opacity: animation, child: child),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          floatingActionButton: model.getIpcSessions().length >= 5 ? Container() : FloatingActionButton(
            backgroundColor: const Color(0xFFB96B40),
            onPressed: () {
              model.setNewSession(model.selectedIpc);
              _navigateToAdd(context);
            },
            child: Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SessionAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                    model.selectedIpc.act1Date == '' ?
                    [
                      Container(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'Form No ${model.selectedIpc.eventNumber}'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('Haina Zoezi Lililofanyika'),
                              SizedBox(
                                height: 10.0,
                              ),
                              FlatButton(
                                onPressed: () {
                                  model.setNewSession(model.selectedIpc);
                                  Navigator.of(context)
                                      .push(PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        AddZoezi(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    new FadeTransition(
                                        opacity: animation,
                                        child: child),
                                  ));
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_library,
                                      color: const Color(0xFFB96B40),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Fanya Zoezi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFFB96B40)),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0,
                                        color: const Color(0xFFB96B40)),
                                    borderRadius:
                                    BorderRadius.circular(18)),
                              )
                            ],
                          ),
                        ),
                      )
                    ] : model.getIpcSessions().map((session) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                radius: 30.0,
                                child: Text('${session.sessionNumber}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),),
                              ),
                              title: Text('Kipindi Cha ${session.sessionNumber}', style: TextStyle(fontWeight: FontWeight.w400),),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${DateFormat.yMMMd().format(DateTime.parse(session.sessionDate))}'),
                                  Text('Kadi ${session.kadi}'),
                                  session.participants.length > 1 ? Text('Washiriki ${session.participants.length}') : SizedBox(height: 0.0,),
                                  session.participants.length == 1 ? Text('Mshiriki ${session.participants.length}') : SizedBox(height: 0.0,),
                                  session.participants.length == 0 ? Text('Hakuna Mshiriki') : SizedBox(height: 0.0,),
                                ],
                              ),
                              onTap: () {

                      },
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  PopupMenuButton<String>(
                                      padding: EdgeInsets.zero,
                                      onSelected: (value) {
                                        if (value == "EDIT") {
                                          model.setNewSession(model.selectedIpc, sessionNumber: session.sessionNumber);
                                          _navigateToAdd(context);
                                        } else if (value == "DELETE") {
                                          confirmSubmission(context, 'Futa Kipindi hiki',
                                              onOK: () async {
                                                try {
                                                  await model.deleteSession(session);
                                                  showMessage(
                                                      context, 'SUCCESS', 'Kipindi namba ${session.sessionNumber} Kimefutwa Kikamilifu', () {});
                                                } catch (e) {
                                                  showMessage(context, 'ERROR',
                                                      'Kuna Tatizo, Hujafinikiwa Kufuta Kipindi Hiki,', () {});
                                                }
                                              });
                                        }
                                      },
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.black,
                                          ),
                                          onPressed: null),
                                      itemBuilder: (BuildContext context) => getOptions(session, model.getIpcSessions())),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 2,)
                        ],
                      );
                    }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PopupMenuEntry<String>> getOptions(SessionModel session, List<SessionModel> sessions) {
    List<PopupMenuEntry<String>> returnList = [];
    returnList.add(PopupMenuItem<String>(
        value: "",
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text('Kipindi Namba ${session.sessionNumber}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        )));
    returnList.add(PopupMenuItem<String>(
      value: "EDIT",
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.edit, color: Colors.blue,),
        title: const Text('Edit'),
      ),
    ));
    if (sessions.length == session.sessionNumber) {
      returnList.add(PopupMenuItem<String>(
          value: "DELETE",
          child: const ListTile(
            dense: true,
            leading: const Icon(Icons.delete_forever, color: Colors.deepOrange,),
            title: const Text('Delete'),
          )));
    }
    return returnList;
  }
}
