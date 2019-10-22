import 'package:flutter/material.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/resources/networ_layer/api_provider.dart';
import 'package:chw/src/ui/plugins/multiselect/flutter_multiselect.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:chw/src/ui/shared/select_drop_down.dart';

class KadiGame extends StatefulWidget {
  ApiProvider api = new ApiProvider();
  String reference;
  CardGameModel mazoezi;

  KadiGame({this.reference, this.mazoezi});

  @override
  State<StatefulWidget> createState() {
    return KadiGameState(
        api: api, reference: this.reference, mazoezi: this.mazoezi);
  }
}

class KadiGameState extends State<KadiGame> {
  ApiProvider api;
  String reference;
  CardGameModel mazoezi;

  KadiGameState({this.api, this.reference, this.mazoezi});

  final _formKey = GlobalKey<FormState>();
  bool doneSaving;
  bool isSaving;
  bool isError;
  String labelType;

//  int usedCardOrGame;
  String usedCardOrGame;
  String distributed_tools;
  String participants;

  TextEditingController _actDateFieldController = new TextEditingController();

  Bloc bloc;

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    bloc.getMaterialSupplied();
    bloc.getParticipants(reference);
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
    labelType = "";
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    if (mazoezi != null) {
      _actDateFieldController.text = mazoezi.date;
      setState(() {
        labelType = mazoezi.type;
//        participants = mazoezi.participants;
      });
    }

    return mazoezi == null
        ? Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                /**
           * Basic information Card for form
           */
                Container(
                    child: Container(
                  height: deviceHeight,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          'date', 'Tarehe', _actDateFieldController),
                      SizedBox(height: 5.0),
                      SelectInput(
                          'Aina iliyotumika', ['Tumia kadi', 'Tumia Game'],
                          onSelection: (value) {
                        print(value);
                        setState(() {
                          labelType = value == 'Tumia kadi'
                              ? 'Kadi'
                              : value == 'Tumia Game' ? 'Game' : 'Kadi';
                        });
                      }),
                      SizedBox(height: 5.0),
                      MultiSelect(
                          autovalidate: false,
                          titleText: labelType,
                          validator: (value) {
                            if (value == null) {
                              return 'Tafadhari chagua  moja au zaidi';
                            }
                          },
                          errorText: 'Tafadhari moja au zaidi',
                          dataSource: GAMES_CARDS,
                          textField: 'display',
                          valueField: 'value',
                          filterable: true,
                          required: true,
                          value: null,
                          onSaved: (va4lue) {
                            print(va4lue);
                            setState(() {
                              usedCardOrGame = va4lue.toString();
//                              usedCardOrGame = (GAMES_CARDS.map((cardGame) {
//                                if (va4lue.contains(cardGame['value']) ==
//                                    true) {
//                                  return cardGame;
//                                }
//                              }).toList());
//                              usedCardOrGame
//                                  .removeWhere((value) => value == null);
                            });
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder(
                          stream: bloc.materialSupplied,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<MaterialModel>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Nyenzo zilizogawiwa'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return MultiSelect(
                                autovalidate: false,
                                titleText: 'Nyenzo zilizogawiwa',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tafadhari chagua nyenzo moja au zaidi';
                                  }
                                },
                                errorText:
                                    'Tafadhari chagua nyenzo moja au zaidi',
                                dataSource: snapshot.data
                                    .map((cso) => {
                                          'display': cso.swahili_name,
                                          'value': cso.id
                                        })
                                    .toList(),
                                textField: 'display',
                                valueField: 'value',
                                filterable: true,
                                required: true,
                                value: null,
                                close: (value) {
                                  print(value);
                                },
                                change: (value) {
                                  print(value);
                                },
                                onSaved: (va4lue) {
                                  setState(() {
                                    distributed_tools = va4lue.toString();
//                                    distributed_tools =
//                                        snapshot.data.map((material) {
//                                      if (va4lue.contains(material.id) ==
//                                          true) {
//                                        return material.toMap();
//                                      }
//                                    }).toList();
//                                    distributed_tools
//                                        .removeWhere((value) => value == null);
                                  });
                                });
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder(
                          stream: bloc.participants,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ParticipantModel>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Mshiriki'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return MultiSelect(
                                autovalidate: false,
                                titleText: 'Mshiriki',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tafadhari chagua mshirki mmoja au';
                                  }
                                },
                                errorText: 'Tafadhari chagua mshirki mmoja au',
                                dataSource: snapshot.data
                                    .map((cso) => {
                                          'display': cso.name,
                                          'value': cso.name
                                        })
                                    .toList(),
                                textField: 'display',
                                valueField: 'value',
                                filterable: true,
                                required: true,
                                value: null,
                                close: (value) {
                                  print(value);
                                },
                                change: (value) {},
                                onSaved: (va4lue) {
                                  setState(() {
                                    participants = va4lue.toString();
//                                    participants =
//                                        snapshot.data.map((participant) {
//                                      if (va4lue.contains(participant.name) ==
//                                          true) {
//                                        return participant.toJson();
//                                      }
//                                    }).toList();
//                                    participants
//                                        .removeWhere((value) => value == null);
                                  });
                                });
                          }),
                      SizedBox(
                        height: 40.0,
                      ),
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

                              String tools = distributed_tools.toString();
                              String participant = participants.toString();
                              String cards_games = usedCardOrGame.toString();
                              var results = await bloc.saveUpdateMazoezi(
                                  CardGameModel(
                                      reference: reference,
                                      date: _actDateFieldController.text,
                                      type: labelType,
                                      distributed_tools: tools,
                                      cards_games: cards_games,
                                      participants: participant),
                                  null,
                                  null);
                              if (results != null) {
                                routeToPage(context);
                              }
                            }, SAVE),
                            SizedBox(width: 55.0),
                            PrimaryCustomButton(() {
                              Navigator.pop(context);
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
                  height: deviceHeight,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          'date', 'Tarehe', _actDateFieldController),
                      SizedBox(height: 5.0),
                      SelectInput(
                          'Aina iliyotumika', ['Tumia kadi', 'Tumia Game'],
                          onSelection: (value) {
                        print(value);
                        setState(() {
                          labelType = value == 'Tumia kadi'
                              ? 'Kadi'
                              : value == 'Tumia Game' ? 'Game' : 'Kadi';
                        });
                      }),
                      SizedBox(height: 5.0),
                      MultiSelect(
                          autovalidate: false,
                          titleText: labelType,
                          validator: (value) {
                            if (value == null) {
                              return 'Tafadhari chagua  moja au zaidi';
                            }
                          },
                          errorText: 'Tafadhari moja au zaidi',
                          dataSource: GAMES_CARDS,
                          textField: 'display',
                          valueField: 'value',
                          filterable: true,
                          required: true,
                          value: null,
                          onSaved: (va4lue) {}),
                      SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder(
                          stream: bloc.materialSupplied,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<MaterialModel>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Nyenzo zilizogawiwa'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return MultiSelect(
                                autovalidate: false,
                                titleText: 'Nyenzo zilizogawiwa',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tafadhari chagua nyenzo moja au zaidi';
                                  }
                                },
                                errorText:
                                    'Tafadhari chagua nyenzo moja au zaidi',
                                dataSource: snapshot.data
                                    .map((cso) => {
                                          'display': cso.swahili_name,
                                          'value': cso.id
                                        })
                                    .toList(),
                                textField: 'display',
                                valueField: 'value',
                                filterable: true,
                                required: true,
                                value: null,
                                close: (value) {
                                  print(value);
                                },
                                change: (value) {},
                                onSaved: (va4lue) {
                                  print(va4lue);
                                });
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      StreamBuilder(
                          stream: bloc.participants,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ParticipantModel>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Mshiriki'),
                                    )
                                  ],
                                ),
                              );
                            }
                            return MultiSelect(
                                autovalidate: false,
                                titleText: 'Mshiriki',
                                validator: (value) {
                                  if (value == null) {
                                    return 'Tafadhari chagua mshirki mmoja au';
                                  }
                                },
                                errorText: 'Tafadhari chagua mshirki mmoja au',
                                dataSource: snapshot.data
                                    .map((cso) => {
                                          'display': cso.name,
                                          'value': cso.name
                                        })
                                    .toList(),
                                textField: 'display',
                                valueField: 'value',
                                filterable: true,
                                required: true,
                                value: null,
                                close: (value) {
                                  print(value);
                                },
                                change: (value) {},
                                onSaved: (va4lue) {
                                  print(va4lue);
                                });
                          }),
                      SizedBox(
                        height: 40.0,
                      ),
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
                              var results = await bloc.saveUpdateMazoezi(
                                  CardGameModel(
                                    id: mazoezi.id,
                                    reference: reference,
                                    date: _actDateFieldController.text,
                                    type: labelType,
                                    distributed_tools: distributed_tools,
                                  ),
                                  reference,
                                  mazoezi.id);
                              if (results != null) {
                                routeToPage(context);
                              }
                            }, UPDATE),
                            SizedBox(width: 55.0),
                            PrimaryCustomButton(() {
                              Navigator.pop(context);
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

prepareStringFromList(List<Map<String, dynamic>> distributed_tools) {
  print(distributed_tools);
  return "1";
}

routeToPage(context) async {
  final result = await Navigator.pop(context);
}


getTools(List<dynamic> data, List<dynamic> va4lue, ){
  data.map((material) {
//       if (va4lue.contains(material.id) == true) {
//           return material.toMap();
//       }
  }).toList();
}