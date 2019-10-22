import 'dart:async';

import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/progress_button.dart';
import 'package:chw/src/new_implementaion/ui/select_drop_down.dart';
import 'package:chw/src/ui/plugins/multiselect/selection_modal.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class AddMemberForm extends StatefulWidget {
  @override
  _AddMemberFormState createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  bool doneSaving;
  bool isSaving;
  bool isError;
  String gender;
  String maritalStatus;
  bool viewDropDown;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameFieldController = new TextEditingController();
  TextEditingController _phoneFieldController = new TextEditingController();
  TextEditingController _ageFieldController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doneSaving = false;
    isSaving = false;
    isError = false;
    var model = ScopedModel.of<MainModel>(context, rebuildOnChange: false);
    if (model.newParticipant == null) {
      model.setNewParticipant();
    }
    _nameFieldController.text = model.newParticipant.name;
    _phoneFieldController.text = model.newParticipant.phoneNumber;
    _ageFieldController.text = model.newParticipant.age;
    gender = model.newParticipant.gender;
    maritalStatus = model.newParticipant.maritalStatus;
  }

  @override
  Widget build(BuildContext context) {
    var haliYaNdoa =
      [
        SelectInputModel(id: 'M', name: 'Ameoa/Ameolewa'),
        SelectInputModel(id: 'S', name: 'Hajaoa/Hajaolewa'),
        SelectInputModel(id: 'C', name: 'Anaishi na mwenza bila ndoa'),
        SelectInputModel(id: 'A', name: 'Ameachika')
      ];
    var jinsia =
      [
        SelectInputModel(id: 'M', name: 'Mme'),
        SelectInputModel(id: 'F', name: 'Mke'),
      ];
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFB96B40),
            title: Text('${model.selectedIpc.eventNumber} Mshiriki', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 29.0),
              child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  CustomTextField(
                    'text',
                    'Jina',
                    _nameFieldController,
                    isRequered: true,
                    icon: Icons.person_outline,
                  ),
                  SizedBox(height: 15.0),
                  CustomTextField(
                    'phone',
                    'Simu',
                    _phoneFieldController,
                    isRequered: false,
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 15.0),
                  CustomTextField(
                    'number',
                    'Umri',
                    _ageFieldController,
                    isRequered: true,
                    icon: Icons.timer,
                  ),
                  SizedBox(height: 15.0),
//                  FlatButton(
//                    child: Text('Endelea'),
//                    onPressed: () {},
//                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueGrey, width: 1.0), borderRadius: BorderRadius.circular(18.0)),
//                  ),
//                  SizedBox(height: 15.0),
                  SelectInput(
                    'Jinsia',
                    jinsia,
                    onSelection: (value) {
                      setState(() => gender = value);
                    },
                    selectedValue: jinsia.firstWhere(
                            (val) => val.id == gender,
                        orElse: () => null),
                    icon: Icons.accessibility,
                  ),
                  SizedBox(height: 15.0),
                  SelectInput(
                    'Hali Ya Ndoa',
                    haliYaNdoa,
                    onSelection: (value) {
                      setState(() => maritalStatus = value);
                    },
                    selectedValue: haliYaNdoa.firstWhere(
                            (val) => val.id == maritalStatus,
                        orElse: () => null),
                    icon: Icons.people_outline,
                  ),
                  SizedBox(height: 25.0),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: gender == 'F' ? 1.0 : 0.0,
                    child: gender == 'F' ? InkWell(
                      onTap: () => model.setIsPregnant(),
                      child: Row(
                        children: <Widget>[
                          Icon(
                              model.newParticipant.isPregnant ? Icons.check_box : Icons.check_box_outline_blank,
                            size: 35,
                          ),
                          SizedBox(width: 10.0,),
                          Text('Tiki kama mshiriki ni mjamzito', style: TextStyle(fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ) : SizedBox(height: 0,),
                  ),
                  gender == 'F' ? SizedBox(height: 35.0,) : SizedBox(height: 0.0,),
                  ProgressButton(
                    loading: isSaving,
                    callback: isSaving
                        ? null
                        : () {
                            if (_formKey.currentState.validate()) {
                              confirmSubmission(
                                context,
                                'Kusanya Taarifa hii..',
                                onOK: () async {
                                  FocusScope.of(context).unfocus();
                                  model.setTaarifaNyingineZaParticipant(
                                    name: _nameFieldController.text,
                                    phone: _phoneFieldController.text,
                                    age: _ageFieldController.text,
                                    gender: gender,
                                    maritalStatus: maritalStatus
                                  );
                                  await model.saveParticipant();
                                  setState(() => isSaving = true);
                                  try {
                                    showMessage(
                                        context,
                                        'SUCCESS',
                                        'Mshiriki Ameongezwa kikamilifu',
                                        () {
                                          Navigator.pop(context);
                                        });
                                    setState(() {
                                      isSaving = false;
                                      doneSaving = true;
                                    });
                                    Timer(const Duration(milliseconds: 400),
                                        () {
                                      Navigator.pop(context);
                                    });
                                  } catch (e) {
                                    showMessage(context, 'ERROR',
                                        'Hujafanikiwa Kuongeza Mshiriki', () {});
                                    setState(() => isSaving = false);
                                  }
                                },
                                onCancel: () {
                                  FocusScope.of(context).unfocus();
                                },
                              );
                            }
                          },
                    title: 'Kusanya',
                    success: doneSaving,
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
