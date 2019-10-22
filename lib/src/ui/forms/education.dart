import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/education_group.dart';
import 'package:chw/src/models/education_type.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/ui/shared/collapsible.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/education_type_field.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:chw/src/ui/shared/select_drop_down.dart';

class Education extends StatefulWidget {
  Session session;
  String reference;

  Education(this.session, this.reference);

  @override
  State<StatefulWidget> createState() {
    return EducationState(session: this.session, reference: this.reference);
  }
}

class EducationState extends State<Education> {
  Session session;
  String reference;

  Bloc bloc;
  final _formKey = GlobalKey<FormState>();

  EducationState({this.session, this.reference});

  List<Map<String, dynamic>> selectedParents;
  dynamic selectedChildren;

  List<Entry> data = <Entry>[
    Entry(
      '',
      'Malaria',
      false,
      <Entry>[Entry('', 'Option 1', false)],
    ),
    Entry(
      '1',
      'VVU',
      false,
      <Entry>[Entry('', 'Option 1', false)],
    ),
    Entry(
      '2',
      'Kifua kikuu',
      false,
      <Entry>[Entry('', 'Option 1', false)],
    ),
    Entry(
      '3',
      'Afya ya mama, baba na mtoto',
      false,
      <Entry>[Entry('', 'Option 1', false)],
    ),
    Entry(
      '4',
      'Uzazi wa mpango',
      false,
      <Entry>[Entry('', 'Option 1', false)],
    ),
  ];

  bool numberOfHouses;
  bool doneSaving;
  bool isSaving;
  bool isError;
  SharedPreferences prefs;

  @override
  void didChangeDependencies() async {
    bloc = Provider.of(context);
    bloc.getEducationType();
    bloc.getEducationGroups();
    bloc.getMaterialSupplied();

    super.didChangeDependencies();

    prefs = await SharedPreferences.getInstance();
    try {
      var rawParents = List<Map<String, dynamic>>.from(
          jsonDecode(prefs.getString('selectedParentElimu') ?? '[]'));
      selectedParents = rawParents;
    } catch (e) {
      selectedParents = [];
    }

    try {
      var rawChildren = List<Map<String, dynamic>>.from(
          jsonDecode(prefs.getString('selectedChildrenElimu') ?? '[]'));
      selectedChildren = rawChildren;
    } catch (e) {
      selectedChildren = [];
    }
  }

  @override
  void dispose() {
//    bloc.disposeEducationType();
//    bloc.disposeEducatedGroup();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    numberOfHouses = false;
    doneSaving = false;
    isSaving = false;
    isError = false;
//    selectedParents = [];
//    selectedChildren = [];
  }

  @override
  Widget build(BuildContext context) {
    return this.reference == null
        ? Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    StreamBuilder(
                        stream: bloc.educationTypes,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EducationType>> snapshot) {
                          if (snapshot.data == null) {
                            return Card(
                              elevation: 0.0,
                              child: Column(
                                children: <Widget>[
                                  LinearProgressIndicator(),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Aina ya elimu ya afya'),
                                  )
                                ],
                              ),
                            );
                          }
                          return EducatitonTypeField(
                            educationTypes: snapshot.data,
                            parentsSelected: selectedParents,
                            childrenSelected: selectedChildren,
                            onSelectionDone:
                                (parentsSelected, childrenSelected) {
                              if (parentsSelected == null) {
                                setState(() {
                                  selectedParents =
                                      List<Map<String, dynamic>>.from(
                                          jsonDecode(prefs.getString(
                                              'selectedParentElimu')));
                                });
                              } else {
                                setState(() {
                                  selectedParents = parentsSelected;
                                });
                                prefs.setString('selectedParentElimu',
                                    jsonEncode(parentsSelected));
                              }
                              if (childrenSelected == null) {
                                setState(() {
                                  selectedChildren = jsonDecode(
                                      prefs.getString('selectedChildrenElimu'));
                                });
                              } else {
                                setState(() {
                                  selectedChildren = childrenSelected;
                                });
                              }
                            },
                          );
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 0.0,
                      child: StreamBuilder(
                          stream: bloc.educationGroups,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<EducationGroup>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                          'Aina ya kikundi/kusanyiko la uelimishaji'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return SelectInput(
                                'Aina ya kikundi/kusanyiko la uelimishaji',
                                snapshot.data.map((cso) => cso.name).toList(),
                                onSelection: (value) {
                              setState(() {
                                value == 'Household visit'
                                    ? numberOfHouses = true
                                    : numberOfHouses = false;
                              });
                            });
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 0.0,
                      child: numberOfHouses == true
                          ? CustomTextField('text', 'Idadi ya Nyumba', null)
                          : Container(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          PrimaryCustomButton(() async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              isError = false;
                              isSaving = true;
                              doneSaving = false;
                            });
                          }, SAVE),
                          SizedBox(width: 55.0),
                          PrimaryCustomButton(() {
                            Navigator.pop(context);
                          }, CANCEL),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    doneSaving == true
                        ? SuccessNotification(
                            isSuccess: doneSaving,
                            message: 'Taarifa za elimu zimwsajiriwa',
                          )
                        : Container(),
                    isError == true
                        ? ErrorNotification(
                            isError: isError,
                            message:
                                'Usajiri wa taarifa za elimu  umeshindikana',
                          )
                        : Container(),
                    isSaving == true
                        ? OnGoingProcessNotification(
                            isProcessing: isSaving,
                            message: 'Usajiri wa taarifa za elimu',
                          )
                        : Container(),
                  ],
                ),
              )
            ]))
        : Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    StreamBuilder(
                        stream: bloc.educationTypes,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EducationType>> snapshot) {
                          if (snapshot.data == null) {
                            return Card(
                              elevation: 0.0,
                              child: Column(
                                children: <Widget>[
                                  LinearProgressIndicator(),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Aina ya elimu ya afya'),
                                  )
                                ],
                              ),
                            );
                          }
                          return EducatitonTypeField(
                            educationTypes: snapshot.data,
                            parentsSelected: selectedParents,
                            childrenSelected: selectedChildren,
                            onSelectionDone:
                                (parentsSelected, childrenSelected) {
                              if (parentsSelected == null) {
                                setState(() {
                                  selectedParents =
                                      List<Map<String, dynamic>>.from(
                                          jsonDecode(prefs.getString(
                                              'selectedParentElimu')));
                                });
                              } else {
                                setState(() {
                                  selectedParents = parentsSelected;
                                });
                                prefs.setString('selectedParentElimu',
                                    jsonEncode(parentsSelected));
                              }

                              if (childrenSelected == null) {
                                setState(() {
                                  selectedChildren = jsonDecode(
                                      prefs.getString('selectedChildrenElimu'));
                                });
                              } else {
                                setState(() {
                                  selectedChildren = childrenSelected;
                                });
                              }
                            },
                          );
                        }),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 0.0,
                      child: StreamBuilder(
                          stream: bloc.educationGroups,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<EducationGroup>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                          'Aina ya kikundi/kusanyiko la uelimishaji'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return SelectInput(
                                'Aina ya kikundi/kusanyiko la uelimishaji',
                                snapshot.data.map((cso) => cso.name).toList(),
                                onSelection: (value) {
                              setState(() {
                                value == 'Household visit'
                                    ? numberOfHouses = true
                                    : numberOfHouses = false;
                              });
                            });
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 0.0,
                      child: numberOfHouses == true
                          ? CustomTextField('text', 'Idadi ya Nyumba', null)
                          : Container(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          PrimaryCustomButton(() async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              isError = false;
                              isSaving = true;
                              doneSaving = false;
//                          print(isSaving);
                            });
//                        var education = await bloc.saveUpdateEducation();
                          }, UPDATE),
                          SizedBox(width: 55.0),
                          PrimaryCustomButton(() {
                            Navigator.pop(context);
                          }, CANCEL),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    doneSaving == true
                        ? SuccessNotification(
                            isSuccess: doneSaving,
                            message: 'Taarifa za elimu zimwsajiriwa',
                          )
                        : Container(),
                    isError == true
                        ? ErrorNotification(
                            isError: isError,
                            message:
                                'Usajiri wa taarifa za elimu  umeshindikana ',
                          )
                        : Container(),
                    isSaving == true
                        ? OnGoingProcessNotification(
                            isProcessing: isSaving,
                            message: 'Usajiri wa taarifa za elimu ',
                          )
                        : Container(),
                  ],
                ),
              )
            ]));
  }
}

prepareConfigureEducation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var selectedParentElimu = jsonEncode(prefs.getString('selectedParentElimu'));
  var selectedChildrenElimu =
      jsonEncode(prefs.getString('selectedChildrenElimu'));
  return {
    "selectedParentElimu":
        selectedParentElimu != null ? selectedParentElimu : [],
    "selectedChildrenElimu":
        selectedChildrenElimu != null ? selectedChildrenElimu : []
  };
}
