import 'dart:async';
import 'dart:convert';

import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/progress_button.dart';
import 'package:chw/src/new_implementaion/ui/select_drop_down.dart';
import 'package:chw/src/ui/plugins/multiselect/flutter_multiselect.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/ui/shared/collapsible.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/notification.dart';

class Education extends StatefulWidget {
  Education();

  @override
  State<StatefulWidget> createState() {
    return EducationState();
  }
}

class EducationState extends State<Education> {
  final _formKey = GlobalKey<FormState>();

  EducationState();

  List<Map<String, dynamic>> selectedParents;
  dynamic selectedChildren;
  TextEditingController __houseHoldController = new TextEditingController();

  bool numberOfHouses;
  bool doneSaving;
  bool isSaving;
  bool isError;
  SharedPreferences prefs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    numberOfHouses = false;
    doneSaving = false;
    isSaving = false;
    isError = false;
  }

  Widget buildIcon(bool check) {
    return Transform.scale(
      child: Icon(check ? Icons.check_box : Icons.check_box_outline_blank,
          color: primaryColor),
      scale: 1.5,
    );
  }

  @override
  Widget build(BuildContext context) {

    double deviceHeight = MediaQuery.of(context).size.height;
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        var eduGroups = model.educatedGroups
            .map((v) => SelectInputModel(id: v.id, name: v.swahiliName))
            .toList();
        __houseHoldController.text = model.newIpc.households;
        return Container(
          height: deviceHeight,
          child: Form(
              key: _formKey,
              child: ListView(children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                _buildEducationTypeWidget(
                  model,
                  eduType: 'Malaria',
                  eduMessageFilter: 'Malaria',
                  educationProvided: model.newIpc.malariaHealthEducationProvided,
                  specificMessage: model.newIpc.malariaSpecificMessage,
                  toolsProvided: model.newIpc.malariaToolsProvided,
                  setHealthProvided: model.setMalarialHealthProvided,
                  setMessage: model.setMalarialSpecificMessage,
                  setTrainingTools: model.setMalariaTrainingTools,
                ),
                _buildEducationTypeWidget(
                  model,
                  eduType: 'VVU',
                  eduMessageFilter: 'HIV',
                  educationProvided: model.newIpc.hivHealthEducationProvided,
                  specificMessage: model.newIpc.hivSpecificMessage,
                  toolsProvided: model.newIpc.hivToolsProvided,
                  setHealthProvided: model.setHIVHealthProvided,
                  setMessage: model.setHIVSpecificMessage,
                  setTrainingTools: model.setHIVTrainingTools,
                ),
                _buildEducationTypeWidget(
                  model,
                  eduType: 'Kifua kikuu',
                  eduMessageFilter: 'TB',
                  educationProvided: model.newIpc.tbHealthEducationProvided,
                  specificMessage: model.newIpc.tbSpecificMessage,
                  toolsProvided: model.newIpc.tbToolsProvided,
                  setHealthProvided: model.setTBHealthProvided,
                  setMessage: model.setTBSpecificMessage,
                  setTrainingTools: model.setTBTrainingTools,
                ),
                _buildEducationTypeWidget(
                  model,
                  eduType: 'Afya ya mama, baba na mtoto',
                  eduMessageFilter: 'MNCH',
                  educationProvided: model.newIpc.mnhcHealthEducationProvided,
                  specificMessage: model.newIpc.mnchSpecificMessage,
                  toolsProvided: model.newIpc.mnchToolsProvided,
                  setHealthProvided: model.setMNCHHealthProvided,
                  setMessage: model.setMNCHSpecificMessage,
                  setTrainingTools: model.setMNCHTrainingTools,
                ),
                _buildEducationTypeWidget(
                  model,
                  eduType: 'Uzazi wa mpango',
                  eduMessageFilter: 'Family Planning (FP)',
                  educationProvided: model.newIpc.healthEducationProvided,
                  specificMessage: model.newIpc.fpSpecificMessage,
                  toolsProvided: model.newIpc.fpToolsProvided,
                  setHealthProvided: model.setFPHealthProvided,
                  setMessage: model.setFPSpecificMessage,
                  setTrainingTools: model.setFPTrainingTools,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Card(
                    elevation: 0.0,
                    child: SelectInput(
                      'Aina ya kikundi/kusanyiko la uelimishaji',
                      eduGroups,
                      icon: Icons.book,
                      selectedValue: eduGroups.firstWhere(
                              (val) => val.name == model.newIpc.groupCrowdEducated,
                          orElse: () => null),
                      onSelection: (value) {
                        model.setEduGroup(value);
                        print(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Card(
                    elevation: 0.0,
                    child: model.newIpc.groupCrowdEducated == '2A-Matembezi ya nyumba kwa nyumba'
                        ? CustomTextField(
                        'number',
                        'Idadi ya Nyumba',
                        __houseHoldController,
                        icon: Icons.home,
                      isRequered: true,
                      onChanged: (value){
                          __houseHoldController.text = value;
                          model.setHouseHold(value);
                      },
                    )
                        : Container(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: SelectInput(
                    'Njia Ya Kufundishia',
                    model.ainaYaMaterial,
                    onSelection: (value) {
                      model.setAinaYaMaterial(value);
                    },
                    selectedValue: model.ainaYaMaterial.firstWhere(
                            (val) => val.id == model.newIpc.trainingItemUsed,
                        orElse: () => null),
                    icon: Icons.people,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: model.educationSelected && model.newIpc.trainingItemUsed != '' && model.newIpc.groupCrowdEducated != '' ? 1.0 : 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ProgressButton(
                            success: doneSaving,
                            loading: isSaving,
                            title: 'Sajili',
                            callback: isSaving ? null : () {
                              confirmSubmission(
                                  context,
                                  'Kusanya Taarifa Hii?',
                                onOK: () async {
                                    setState(() => isSaving = true);
                                    try {
                                      await model.saveInitialIpc();
                                      showMessage(context, 'SUCCESS', 'Session Imeongezwa kikamilifu', () {});
                                      setState(() { isSaving = false; doneSaving = true;});
                                      Timer(const Duration(milliseconds: 500), () {
                                        Navigator.pushReplacementNamed(context, '/sessions');
                                      });
                                    } catch (e) {
                                      showMessage(context, 'ERROR', 'Hujafanikiwa Kusajili Session Hiii', () {});
                                      setState(() => isSaving = false);
                                    }
                                }
                              );
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
                SizedBox(height: 25.0),
              ])),
        );
      },
    );
  }

  Widget _buildEducationTypeWidget(
    MainModel model, {
    String eduType,
    String eduMessageFilter,
    bool educationProvided,
    String specificMessage,
    String toolsProvided,
    Function setHealthProvided,
    Function setMessage,
    Function setTrainingTools,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          border: Border.all(color: Colors.blueGrey, width: 1.0)),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(eduType),
              leading: buildIcon(educationProvided),
              onTap: setHealthProvided),
          educationProvided
              ? Column(
                  children: <Widget>[
                    MultiSelect(
                      autovalidate: false,
                      titleText: 'Ujumbe Mahususi $eduType',
                      validator: (value) {
                        return specificMessage != ''
                            ? null
                            : 'Tafadhali chagua  moja au zaidi';
                      },
                      errorText: 'Tafadhari moja au zaidi',
                      dataSource: model
                          .getSpecificMessage(eduMessageFilter ?? eduType)
                          .map((target) {
                        return {
                          'value': target.swahiliName,
                          'display': target.swahiliName
                        };
                      }).toList(),
                      textField: 'display',
                      valueField: 'value',
                      filterable: true,
                      required: true,
                      value: null,
                      icon: Icons.layers,
                      initialValue: specificMessage.split(', '),
                      onSaved: (va4lue) {
                        setMessage(va4lue);
                      },
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    MultiSelect(
                        autovalidate: false,
                        titleText: 'Nyenzo Zilizotumika $eduType',
                        validator: (value) {
                          return null;
                        },
                        errorText: 'Tafadhari moja au zaidi',
                        dataSource:
                            model.getCanBeUsedForTraining().map((target) {
                          return {
                            'value': target.swahiliName,
                            'display': target.swahiliName
                          };
                        }).toList(),
                        textField: 'display',
                        valueField: 'value',
                        filterable: true,
                        required: false,
                        value: null,
                        icon: Icons.settings_input_component,
                        initialValue: toolsProvided.split(', '),
                        onSaved: (va4lue) {
                          setTrainingTools(va4lue);
                        })
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
