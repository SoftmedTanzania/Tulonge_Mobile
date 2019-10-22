import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/models/participant_model.dart';
import 'package:chw/src/new_implementaion/models/session_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/map_screen.dart';
import 'package:chw/src/new_implementaion/screens/members.dart';
import 'package:chw/src/new_implementaion/screens/new_session.dart';
import 'package:chw/src/new_implementaion/screens/zoezi_screen.dart';
import 'package:chw/src/new_implementaion/ui/detailSession.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailPage extends StatelessWidget {
  final Ipc ipc;

  DetailPage(this.ipc);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Color(0xFFAAA9AB),
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(context),
            _getToolbar(context, ipc),
          ],
        ),
      ),
    );
  }

  Container _getBackground() {
    return new Container(
      child: new Image.asset(
        'assets/sitetereki.jpg',
        fit: BoxFit.cover,
        height: 200.0,
        colorBlendMode: BlendMode.darken,
      ),
      constraints: new BoxConstraints.expand(height: 200.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 50.0),
      height: 150.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
//          colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
          colors: <Color>[new Color(0x2A736AB7), new Color(0xFFAAA9AB)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent(BuildContext context) {
    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          DetailSessionSummary(
            ipc,
            horizontal: false,
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 12.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                if (ipc.gpsCordinatorE != '' && ipc.gpsCordinateS != '')
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new PageRouteBuilder(
                          fullscreenDialog: true,
                          pageBuilder: (_, __, ___) => new MapScreen(
                            selecting: false,
                            startingLocation: LatLng(
                                double.tryParse(ipc.gpsCordinateS),
                                double.tryParse(ipc.gpsCordinatorE)),
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  new FadeTransition(
                                      opacity: animation, child: child),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child: Image.network(
                          generateMapUrl(
                              latitude: ipc.gpsCordinateS,
                              longitude: ipc.gpsCordinatorE),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                if (ipc.gpsCordinatorE != '' && ipc.gpsCordinateS != '')
                  SizedBox(
                    height: 15,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) {
                        return Text(
                          'Vipindi (${model.getNumberOfSessions(ipc)})',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400),
                        );
                      }),
                      ScopedModelDescendant<MainModel>(
                        builder: (context, child, model) {
                          return FlatButton.icon(
                            icon: Icon(
                              Icons.assignment_ind,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Zaidi',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              model.setSelectedIPc(ipc);
                              Navigator.of(context).push(
                                new PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => ZoeziScreen(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      new FadeTransition(
                                          opacity: animation, child: child),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ScopedModelDescendant<MainModel>(
                  builder: (context, child, model) {
                    return Column(
                      children: model
                          .getIpcSessions()
                          .map((session) => getSessionCard(session))
                          .toList(),
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ScopedModelDescendant<MainModel>(
                          builder: (context, child, model) {
                        return Text(
                          'Washiriki (${model.getNumberOfParticipant(ipc)})',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400),
                        );
                      }),
                      ScopedModelDescendant<MainModel>(
                        builder: (context, child, model) {
                          return FlatButton.icon(
                            icon: Icon(
                              Icons.people_outline,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Zaidi',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              model.setSelectedIPc(ipc);
                              Navigator.of(context).push(
                                new PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new MembersScreen(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      new FadeTransition(
                                          opacity: animation, child: child),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ScopedModelDescendant<MainModel>(
                  builder: (context, child, model) {
                    return Column(
                      children: model
                          .getIpcMembers()
                          .map((participant) =>
                              getParticipantCard(participant, model))
                          .toList(),
                    );
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: ScopedModelDescendant<MainModel>(
                    builder: (context, child, model) {
                      if (ipc.isSynchronized && ipc.isCompleted) {
                        return Text(
                          'Taarifa hii imekamilika na imeshatumwa kwaajili ya uhakiki',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        );
                      } else if (!ipc.isSynchronized && ipc.isCompleted) {
                        return Text(
                          'Taarifa hii imekamilika, inasuburu kutumwa kwaajili ya uhakiki',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return FlatButton.icon(
                          onPressed: () {
                            confirmSubmission(
                              context,
                              'Hii itamaanisha kuwa session hii imeisha na iko tayari kutumwa',
                              onOK: () {
                                model.completeSession(ipc);
                                showMessage(
                                  context,
                                  'SUCCESS',
                                  'Session Imemalizwa kikamilifu',
                                  () {},
                                );
                              },
                            );
                          },
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                          ),
                          label: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Maliza Session',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                color: Colors.white,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSessionCard(SessionModel session) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${session.sessionNumber}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 20),
                ),
                backgroundColor: Colors.blueGrey,
                radius: 20.0,
              ),
              title: Text(
                'Kipindi cha ${session.sessionNumber}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${DateFormat.yMMMd().format(DateTime.parse(session.sessionDate))}',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                  ipc.trainingItemUsed == 'Kadi'
                      ? Text(
                          'Kadi No ${session.kadi}',
                          style: getTextStyle(),
                        )
                      : Text(
                          'Zoezi No ${session.game}',
                          style: getTextStyle(),
                        ),
                  session.participants.length > 1
                      ? Text(
                          'Washiriki ${session.participants.length}',
                          style: getTextStyle(),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  session.participants.length == 1
                      ? Text(
                          'Mshiriki ${session.participants.length}',
                          style: getTextStyle(),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  session.participants.length == 0
                      ? Text(
                          'Hakuna Mshiriki',
                          style: getTextStyle(),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 2,
        )
      ],
    );
  }

  Widget getParticipantCard(Participant participant, MainModel model) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: participant.name == ''
                    ? Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 27.0,
                      )
                    : Text(
                        '${participant.name[0].toUpperCase()}',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
              title: Row(
                children: <Widget>[
                  Text('${participant.name}'),
                  participant.isPregnant
                      ? Text(' (Mjamzito)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black54))
                      : Container(),
                ],
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${participant.phoneNumber}',
                    style: getTextStyle(),
                  ),
                  Text(
                    '${model.genderDefinition[participant.gender]} (${participant.age}) ${participant.maritalStatus != '' ? '(' + model.maritalStatusDefinition[participant.maritalStatus] + ')' : ''}',
                    style: getTextStyle(),
                  ),
                  if (model.numberOfSessionMemberAttended(participant) == 0)
                    Text(
                      'Hajashiriki kipindi chochote',
                      style: getTextStyle(),
                    ),
                  if (model.numberOfSessionMemberAttended(participant) == 1)
                    Text(
                      'Kashiriki kipindi 1 (${model.sessionMemberParicipated(participant)})',
                      style: getTextStyle(),
                    ),
                  if (model.numberOfSessionMemberAttended(participant) > 1)
                    Text(
                      'Kashiriki Vipindi ${model.numberOfSessionMemberAttended(participant)} (${model.sessionMemberParicipated(participant)})',
                      style: getTextStyle(),
                    )
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }

  TextStyle getTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w300, color: Colors.black, fontSize: 12.5);
  }

  Container _getToolbar(BuildContext context, Ipc ipc) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(color: Colors.white),
                ScopedModelDescendant<MainModel>(
                  builder: (BuildContext context, child, MainModel model) {
                    return IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          model.initilizeIpc(ipc);
                          Navigator.of(context).push(
                            new PageRouteBuilder(
                              pageBuilder: (_, __, ___) => new NewSession(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  new FadeTransition(
                                      opacity: animation, child: child),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
