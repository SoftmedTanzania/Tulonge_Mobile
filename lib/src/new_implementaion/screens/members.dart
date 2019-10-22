import 'package:chw/src/new_implementaion/models/participant_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/ui/bottom_gradient.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/sessionAppBar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:chw/src/new_implementaion/screens/forms/add_member.dart';

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel model) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFB96B40),
            onPressed: () {
              model.setNewParticipant();
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddMemberForm(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        new FadeTransition(opacity: animation, child: child),
              ));
            },
            child: Icon(Icons.add),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SessionAppBar(),
              SliverList(
                  delegate: SliverChildListDelegate(
                      model.getIpcMembers().length == 0 ? [
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
                                  Text('Haina Washiriki'),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      model.setNewParticipant();
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            AddMemberForm(),
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
                                          Icons.person_add,
                                          color: const Color(0xFFB96B40),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'Ongeza Mshiriki',
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
                        ]
                      : model
                          .getIpcMembers()
                          .map((item) => buildMember(item, model, context))
                          .toList()))
            ],
          ),
          );
    });
  }

  TextStyle getTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w300, color: Colors.black, fontSize: 13
    );
  }

  Widget buildMember(Participant item, MainModel model, BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: item.name == ''
                  ? Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 27.0,
                    )
                  : Text(
                      '${item.name[0].toUpperCase()}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
            ),
            title: Row(
              children: <Widget>[
                Text('${item.name}'),
                item.isPregnant
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
                  '${item.phoneNumber}',
                  style: getTextStyle(),
                ),
                Text(
                  '${model.genderDefinition[item.gender]} ${item.maritalStatus != '' ? '(' + model.maritalStatusDefinition[item.maritalStatus] + ')' : ''}',
                  style: getTextStyle(),
                ),
                if (model.numberOfSessionMemberAttended(item) == 0) Text('Hajashiriki kipindi chochote', style: getTextStyle(),),
                if (model.numberOfSessionMemberAttended(item) == 1) Text('Kashiriki kipindi 1 (${model.sessionMemberParicipated(item)})', style: getTextStyle(),),
                if (model.numberOfSessionMemberAttended(item) > 1) Text('Kashiriki Vipindi ${model.numberOfSessionMemberAttended(item)} (${model.sessionMemberParicipated(item)})', style: getTextStyle(),)

              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == "EDIT") {
                        model.setNewParticipant(participant: item);
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => AddMemberForm(),
                          transitionsBuilder: (context, animation, secondaryAnimation,
                                  child) =>
                              new FadeTransition(opacity: animation, child: child),
                        ));
                      } else if (value == "DELETE") {
                        confirmSubmission(context, 'Futa Mshiriki Huyu',
                            onOK: () async {
                          try {
                            await model.deleteParticipant(item.id);
                            showMessage(
                                context, 'SUCCESS', '${item.name} Ameondolewa', null);
                          } catch (e) {
                            showMessage(context, 'ERROR',
                                'Hujafinikiwa Kufuta Mshiriki', null);
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
                    itemBuilder: (BuildContext context) => getOptions(item)),
              ],
            ),
          ),
        ),
        Divider(height: 1,),
      ],
    );
  }

  List<PopupMenuEntry<String>> getOptions(Participant participant) {
    List<PopupMenuEntry<String>> returnList = [];
    returnList.add(PopupMenuItem<String>(
        value: "",
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(participant.name,
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
    returnList.add(PopupMenuItem<String>(
        value: "DELETE",
        child: const ListTile(
          dense: true,
          leading: const Icon(Icons.delete_forever, color: Colors.deepOrange,),
          title: const Text('Delete'),
        )));
    return returnList;
  }
}
