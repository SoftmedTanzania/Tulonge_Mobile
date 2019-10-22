import 'dart:async';

import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/forms/add_member.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/pickers.dart';
import 'package:chw/src/new_implementaion/ui/progress_button.dart';
import 'package:chw/src/new_implementaion/ui/select_drop_down.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/ui/plugins/multiselect/flutter_multiselect.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddZoezi extends StatefulWidget {
  @override
  _AddZoeziState createState() => _AddZoeziState();
}

class _AddZoeziState extends State<AddZoezi> {
  var attendance = {};
  var refferal = {};
  var refferalToArea = {};
  var refferalReason = {};

  bool doneSaving;
  bool isSaving;
  bool isError;
  TextEditingController _materialTextController;
  bool vifaaViligawiwa;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final model = ScopedModel.of<MainModel>(context);
    model.getInitialSessionDate();
    _materialTextController = new TextEditingController();
    // set all initial values to default
    model.getIpcMembers().forEach((participant) {
      refferal[participant.id] = participant.referred;
      refferalToArea[participant.id] = participant.referredTo;
      refferalReason[participant.id] = participant.referralReason;
      attendance[participant.id] = false;
    });
    if (model.newSession == null) {
      model.setNewSession(model.selectedIpc);
    }
    _materialTextController.text = model.newSession.material;
    vifaaViligawiwa = model.newSession.material != '';
    // Feed the data while editing
    model.newSession.participants.forEach((participant) {
      attendance[participant.id] = true;
    });

    doneSaving = false;
    isSaving = false;
    isError = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        var refferedTo = [
          SelectInputModel(id: 'Kituo cha afya', name: 'Kituo cha afya'),
          SelectInputModel(id: 'Mshauri Nasaa', name: 'Mshauri Nasaa'),
        ];
        var refferalReasonList = model.getReferralTypes
            .map((v) => SelectInputModel(id: v.id, name: v.name))
            .toList();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFB96B40),
            title: Text(
              '${model.selectedIpc.eventNumber} Zoezi',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(15.0),
            child: model.getIpcMembers().length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Text('Hakuna Washiriki Kwenye form hii')),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: FlatButton.icon(
                          onPressed: () {
                            model.setNewParticipant();
                            Navigator.of(context)
                                .push(
                              PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => AddMemberForm(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child)),
                            )
                                .then((_) {
                              model.getIpcMembers().forEach((participant) {
                                refferal[participant.id] = false;
                                refferalToArea[participant.id] = '';
                                refferalReason[participant.id] = '';
                                attendance[participant.id] = false;
                              });
                            });
                          },
                          icon: Icon(Icons.person_add),
                          label: Text('Ongeza Washiriki Kwanza'),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Kipindi Cha ${model.newSession.sessionNumber}',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Divider(
                        height: 5.0,
                      ),
                      SizedBox(height: 15.0),
                      DatePicker(
                        label: "Tarehe",
                        selectedDate: model.newSession.sessionDate == ''
                            ? DateTime.now()
                            : DateTime.parse(model.newSession.sessionDate),
//                        minDate: model.newSession.minDate,
                        maxDate: model.newSession.maxDate,
                        onDateSelected: (date) {
                          print(date);
                          model.setSessionDate(date);
                        },
                      ),
                      SizedBox(height: 15.0),
                      model.selectedIpc.trainingItemUsed == 'Kadi'
                          ? MultiSelect(
                              autovalidate: false,
                              titleText:
                                  '${model.selectedIpc.trainingItemUsed}',
                              validator: (value) {
                                return model.newSession.kadi != ''
                                    ? null
                                    : 'Tafadhali chagua  moja au zaidi';
                              },
                              errorText: 'Tafadhari moja au zaidi',
                              dataSource: model.kadiList
                                  .where((kadi) => !model
                                      .kadiZilizotumika()
                                      .contains(kadi['value']))
                                  .toList(),
                              textField: 'display',
                              valueField: 'value',
                              filterable: true,
                              required: true,
                              value: null,
                              icon: Icons.local_library,
                              initialValue: model.newSession.kadi.split(', '),
                              onSaved: (va4lue) {
                                model.setSessionKadi(va4lue);
                              },
                            )
                          : MultiSelect(
                              autovalidate: false,
                              titleText:
                                  '${model.selectedIpc.trainingItemUsed}',
                              validator: (value) {
                                return model.newSession.game != ''
                                    ? null
                                    : 'Tafadhali chagua  moja au zaidi';
                              },
                              errorText: 'Tafadhari moja au zaidi',
                              dataSource: model.gameList
                                  .where((game) => !model
                                      .gameZilizotumika()
                                      .contains(game['value']))
                                  .toList(),
                              textField: 'display',
                              valueField: 'value',
                              filterable: true,
                              required: true,
                              value: null,
                              icon: Icons.local_library,
                              initialValue: model.newSession.game.split(', '),
                              onSaved: (va4lue) {
                                model.setSessionKGame(va4lue);
                              }),
                      SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                          title: Text('Vifaa Viligawiwa'),
                          leading: Transform.scale(
                            child: Icon(
                                vifaaViligawiwa
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: primaryColor),
                            scale: 1.5,
                          ),
                          onTap: () {
                            _materialTextController.text = '';
                            vifaaViligawiwa = !vifaaViligawiwa;
                            model.setVifaaVilivyotumika(vifaaViligawiwa);
                            setState(() {});
                          }),
                      SizedBox(
                        height: 15.0,
                      ),
                      AnimatedOpacity(
                        opacity: vifaaViligawiwa ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          height: vifaaViligawiwa ? 90 : 0,
                          duration: Duration(milliseconds: 500),
                          child: CustomTextField(
                            'textArea',
                            'Vifaa Vilivyogawiwa',
                            _materialTextController,
                            isRequered: true,
                            hintText:
                                'Andika jina na idadi ya vifaa ulivyogawa',
                            icon: Icons.settings_input_component,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 14.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Mahudhurio',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            FlatButton.icon(
                              onPressed: () {
                                model.setNewParticipant();
                                Navigator.of(context)
                                    .push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => AddMemberForm(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      new FadeTransition(
                                          opacity: animation, child: child),
                                ))
                                    .then((_) {
                                  model.getIpcMembers().forEach((participant) {
                                    refferal[participant.id] =
                                        participant.referred;
                                    refferalToArea[participant.id] =
                                        participant.referredTo;
                                    refferalReason[participant.id] =
                                        participant.referralReason;
                                    attendance[participant.id] = false;
                                  });
                                  if (model.newSession != null &&
                                      model.newSession.participants.length >
                                          0) {
                                    model.newSession.participants
                                        .forEach((participant) {
                                      attendance[participant.id] = true;
                                    });
                                  }
                                });
                              },
                              icon: Icon(Icons.person_add),
                              label: Text('Ongeza Mshiriki'),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1.0),
                      if (model.getIpcMembers().length == 0)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('Hakuna Washiriki'),
                          ),
                        ),
                      Column(
                        children: model.getIpcMembers().map((participant) {
                          return attendance[participant.id] != null
                              ? Column(
                                  children: [
                                    CheckboxListTile(
                                      title: Text('${participant.name} '),
                                      subtitle: Text(
                                          '${model.genderDefinition[participant.gender]} ${participant.age} Yrs'),
                                      value: attendance[participant.id],
                                      onChanged: (val) {
                                        setState(() =>
                                            attendance[participant.id] =
                                                !attendance[participant.id]);
                                        print(val);
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height:
                                          attendance[participant.id] ? 25 : 0,
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 300),
                                        opacity: attendance[participant.id]
                                            ? 1.0
                                            : 0.0,
                                        child: attendance[participant.id]
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      refferal[participant.id] =
                                                          !refferal[
                                                              participant.id];
                                                    });
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                          refferal[participant
                                                                  .id]
                                                              ? Icons.check_box
                                                              : Icons
                                                                  .check_box_outline_blank,
                                                          color: refferal[
                                                                  participant
                                                                      .id]
                                                              ? Colors
                                                                  .lightGreen
                                                              : Colors
                                                                  .lightBlueAccent),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('Mwaliko Wa Huduma')
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ),
                                    ),
                                    if (attendance[participant.id] &&
                                        refferal[participant.id])
                                      SizedBox(
                                        height: 10,
                                      ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height: attendance[participant.id] &&
                                              refferal[participant.id]
                                          ? 130
                                          : 0,
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 400),
                                        opacity: attendance[participant.id] &&
                                                refferal[participant.id]
                                            ? 1.0
                                            : 0.0,
                                        child: attendance[participant.id] &&
                                                refferal[participant.id]
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    SelectInput(
                                                      'Kwenda',
                                                      refferedTo,
                                                      onSelection: (value) {
                                                        setState(() =>
                                                            refferalToArea[
                                                                    participant
                                                                        .id] =
                                                                value);
                                                      },
                                                      selectedValue:
                                                          refferedTo.firstWhere(
                                                              (val) =>
                                                                  val.id ==
                                                                  refferalToArea[
                                                                      participant
                                                                          .id],
                                                              orElse: () =>
                                                                  null),
                                                      icon:
                                                          Icons.local_hospital,
                                                    ),
                                                    SizedBox(height: 15.0),
                                                    SelectInput(
                                                      'Sababu za mwaliko',
                                                      refferalReasonList,
                                                      onSelection: (value) {
                                                        setState(() =>
                                                            refferalReason[
                                                                    participant
                                                                        .id] =
                                                                value);
                                                      },
                                                      selectedValue: refferalReasonList
                                                          .firstWhere(
                                                              (val) =>
                                                                  val.id ==
                                                                  refferalReason[
                                                                      participant
                                                                          .id],
                                                              orElse: () =>
                                                                  null),
                                                      icon: Icons.filter_list,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      height: 1.0,
                                    )
                                  ],
                                )
                              : Container();
                        }).toList(),
                      ),
                      if (!((model.newSession.kadi != '' ||
                              model.newSession.game != '') &&
                          model.newSession.sessionDate != '' &&
                          attendance.length > 0))
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Hakikisha umechagua ${model.newSession.toolUsed}, Mshiriki na Tarehe',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.amber),
                          ),
                        ),
                      AnimatedContainer(
                        height: (model.newSession.kadi != '' ||
                                    model.newSession.game != '') &&
                                model.newSession.sessionDate != '' &&
                                attendance.length > 0
                            ? 50
                            : 0,
                        duration: Duration(milliseconds: 400),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: (model.newSession.kadi != '' ||
                                      model.newSession.game != '') &&
                                  model.newSession.sessionDate != ''
                              ? 1.0
                              : 0.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            margin: EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: ProgressButton(
                                    success: doneSaving,
                                    loading: isSaving,
                                    title: 'Sajili',
                                    callback: isSaving
                                        ? null
                                        : () {
                                            confirmSubmission(
                                                context, 'Kusanya Taarifa Hii?',
                                                onOK: () async {
                                              setState(() => isSaving = true);
                                              try {
                                                await model.saveSession(
                                                    mahudhurio: attendance,
                                                    material:
                                                        _materialTextController
                                                            .text,
                                                    referralReason:
                                                        refferalReason,
                                                    referral: refferal,
                                                    referralType:
                                                        refferalToArea);
                                                showMessage(context, 'SUCCESS',
                                                    'Kipindi Kimeongezwa kikamilifu',
                                                    () {
                                                  Navigator.pop(context);
                                                });
                                                setState(() {
                                                  isSaving = false;
                                                  doneSaving = true;
                                                });
                                                Timer(
                                                    Duration(milliseconds: 500),
                                                    () =>
                                                        Navigator.pop(context));
                                              } catch (e) {
                                                showMessage(
                                                    context,
                                                    'ERROR',
                                                    'Hujafanikiwa Kusajili Kipindi',
                                                    () {});
                                                setState(
                                                    () => isSaving = false);
                                              }
                                            });
                                          },
                                  ),
                                ),
                                SizedBox(width: 55.0),
                                PrimaryCustomButton(() {
                                  Navigator.pop(context);
                                }, CANCEL),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
