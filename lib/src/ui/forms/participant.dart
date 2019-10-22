import 'package:flutter/material.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/resources/networ_layer/api_provider.dart';
import 'package:chw/src/screens/session/members_manager.dart';
import 'package:chw/src/screens/session/session_participants_screen.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:chw/src/ui/shared/select_drop_down.dart';

/**
 * BASIC INFORMATION FORM
 *
 */

class Participant extends StatefulWidget {
  ApiProvider api = new ApiProvider();
  String reference;
  ParticipantModel participant;

  Participant({this.reference, this.participant});

  @override
  State<StatefulWidget> createState() {
    return ParticipantState(
        api: api, reference: this.reference, participant: this.participant);
  }
}

class ParticipantState extends State<Participant> {
  ApiProvider api;
  String reference;
  ParticipantModel participant;

  ParticipantState({this.api, this.reference, this.participant});

  final _formKey = GlobalKey<FormState>();
  bool doneSaving;
  bool isSaving;
  bool isError;

  String name;
  String phone;
  String gender;
  String age;
  String marital_status;

  TextEditingController _nameFieldController = new TextEditingController();
  TextEditingController _phoneFieldController = new TextEditingController();
  TextEditingController _ageFieldController = new TextEditingController();

  Bloc bloc;

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
//    bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doneSaving = false;
    isSaving = false;
    isError = false;

    name = "";
    phone = "";
    gender = "";
    age = "";
    marital_status = "";
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    if (this.participant != null) {
      _nameFieldController.text = this.participant.name;
      _phoneFieldController.text = this.participant.phone_number;
      gender = this.participant.gender;
      _ageFieldController.text = this.participant.age;
    }

    return this.participant == null
        ? Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                /**
           * Basic information Card for form
           */
                Container(
                    child: Container(
                  height: deviceHeight * 0.75,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      CustomTextField('text', 'Jina', _nameFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Namba ya Simu', _phoneFieldController),
                      SizedBox(height: 5.0),
                      SelectInput('Jinsi', ['Mume', 'Mke'],
                          onSelection: (value) {
                        setState(() {
                          gender = value;
                        });
                      }),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Umri(Miaka)', _ageFieldController),
                      SizedBox(height: 5.0),
                      SelectInput('Hali ya Ndoa', [
                        'Ameoa/Ameolewa',
                        'Hajaoa/Hajaolewa',
                        'Anaishi na mwenza bila ndoa',
                        'Ameachika'
                      ], onSelection: (value) {
                        setState(() {
                          marital_status = value;
                        });
                      }),
                      SizedBox(height: 5.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PrimaryCustomButton(() async {
                              setState(() {
                                isError = false;
                                isSaving = true;
                                doneSaving = false;
                              });
                              var name = _nameFieldController.text;
                              var phone = _phoneFieldController.text;
                              var age = _ageFieldController.text;
                              var results = await bloc.saveUpdateParticipants(
                                  ParticipantModel(
                                      id: null,
                                      reference: reference,
                                      name: name,
                                      age: age,
                                      gender: gender,
                                      phone_number: phone,
                                      marital_status: marital_status),
                                  null,
                                  null);
                              if (results != null) {
                                setState(() {
                                  isError = false;
                                  isSaving = false;
                                  doneSaving = true;
                                });
                                routeToPage(
                                    "/sessions_members", context, reference);
                              }
                            }, SAVE),
                            SizedBox(width: 55.0),
                            PrimaryCustomButton(() {
                              routeToPage(
                                  "/sessions_members", context, reference);
                            }, CANCEL),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      doneSaving == true
                          ? SuccessNotification(
                              isSuccess: doneSaving,
                              message: 'Mshiriki amesajiriwa',
                            )
                          : Container(),
                      isError == true
                          ? ErrorNotification(
                              isError: isError,
                              message: 'Usajiri wa mshiriki umeshindikana',
                            )
                          : Container(),
                      isSaving == true
                          ? OnGoingProcessNotification(
                              isProcessing: isSaving,
                              message: 'Usajiri wa mshiriki unaendelea ...',
                            )
                          : Container(),
                    ],
                  ),
                )),
              ],
            ),
          )
        : Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                /**
           * Basic information Card for form
           */
                Container(
                    child: Container(
                  height: deviceHeight * 0.75,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      CustomTextField('text', 'Jina', _nameFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Namba ya Simu', _phoneFieldController),
                      SizedBox(height: 5.0),
                      SelectInput('Jinsi', ['Mume', 'Mke'],
                          onSelection: (value) {
                        setState(() {
                          gender = value;
                        });
                      }),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Umri(Miaka)', _ageFieldController),
                      SizedBox(height: 5.0),
                      SelectInput('Hali ya Ndoa', [
                        'Ameoa/Ameolewa',
                        'Hajaoa/Hajaolewa',
                        'Anaishi na mwenza bila ndoa',
                        'Ameachika'
                      ], onSelection: (value) {
                        setState(() {
                          marital_status = value;
                        });
                      }),
                      SizedBox(height: 5.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PrimaryCustomButton(() async {
                              setState(() {
                                isError = false;
                                isSaving = true;
                                doneSaving = false;
                              });
                              var name = _nameFieldController.text;
                              var phone = _phoneFieldController.text;
                              var age = _ageFieldController.text;
                              var results = await bloc.saveUpdateParticipants(
                                  ParticipantModel(
                                      id: participant.id,
                                      reference: reference,
                                      name: name,
                                      age: age,
                                      gender: gender,
                                      phone_number: phone,
                                      marital_status: marital_status),
                                  reference,
                                  participant.id);

                              if (results == 1) {
                                routeToPage(
                                    "/sessions_members", context, reference);
                              }
                            }, UPDATE),
                            SizedBox(width: 55.0),
                            PrimaryCustomButton(() {
                              routeToPage(
                                  "/sessions_members", context, reference);
                            }, CANCEL),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      doneSaving == true
                          ? SuccessNotification(
                              isSuccess: doneSaving,
                              message: 'Mshiriki amesajiriwa',
                            )
                          : Container(),
                      isError == true
                          ? ErrorNotification(
                              isError: isError,
                              message: 'Usajiri wa mshiriki umeshindikana',
                            )
                          : Container(),
                      isSaving == true
                          ? OnGoingProcessNotification(
                              isProcessing: isSaving,
                              message: 'Usajiri wa mshiriki unaendelea ...',
                            )
                          : Container(),
                    ],
                  ),
                )),
              ],
            ),
          );
  }
}

routeToPage(route, context, reference) async {
  final result = await Navigator.pop(context);
}
