import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/cso.dart';
import 'package:chw/src/models/location_model.dart';
import 'package:chw/src/models/session.dart';
import 'package:chw/src/models/basic_information.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/resources/networ_layer/api_provider.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/loader.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:chw/src/ui/shared/select_drop_down.dart';
import 'package:device_info/device_info.dart';

/**
 * BASIC INFORMATION FORM
 *
 */

class BasicInformation extends StatefulWidget {
  ApiProvider api = new ApiProvider();
  Session session;
  String reference;

  BasicInformation(this.session, this.reference);

  @override
  State<StatefulWidget> createState() {
    return BasicInformationState(
        api: api, session: this.session, reference: this.reference);
  }
}

class BasicInformationState extends State<BasicInformation> {
  ApiProvider api;
  Session session;
  String reference;
  Location location = new Location();

  BasicInformationState({this.api, this.session, this.reference});

  StreamSubscription<LocationData> _locationSub; // new
  Map<String, double> currentLocation;

  final _formKey = GlobalKey<FormState>();
  bool doneSaving;
  bool isSaving;
  bool isError;
  String cso = '';
  String facilitator_type = '';
  String device;
  String longitude = "";
  String latitude = "";
  String region;
  String district;
  String ward;
  String wardid;

  List<Cso> allCSO;

  TextEditingController _communityReaderFieldController =
      new TextEditingController();
  TextEditingController _communityReaderPhoneFieldController =
      new TextEditingController();
  TextEditingController _facilitatorNameFieldController =
      new TextEditingController();
  TextEditingController _facilitatorPhoneNumberFieldController =
      new TextEditingController();

  TextEditingController _villageFieldController = new TextEditingController();

  Bloc bloc;

  _getDeviceName() async {
    if (Platform.isAndroid) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          setState(() {
            device = androidInfo.brand;
          });
        }
      } catch (e) {}
    }
  }

  @override
  void didChangeDependencies() {
    bloc = Provider.of(context);
    bloc.getCSOs();

    _getDeviceName();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _locationSub.cancel();
  }

  @override
  void initState() {
    super.initState();
    doneSaving = false;
    isSaving = false;
    isError = false;
    cso = '';
    device = '';
    region = '';
    district = '';
    ward = '';
    wardid = '';

    _locationSub =
        location.onLocationChanged().listen((LocationData locationData) {
      setState(() {
        currentLocation = {
          "latitude": locationData.latitude,
          "longitude": locationData.longitude,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    if (this.reference != null) {
      _communityReaderFieldController.text = session.community_leader_name;
      _communityReaderPhoneFieldController.text =
          session.community_leader_phone;
      _facilitatorNameFieldController.text = session.facilitator_name;
      _facilitatorPhoneNumberFieldController.text =
          session.facilitator_phone_number;
      _villageFieldController.text = session.event_place;
    }
    return this.reference == null
        ? Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                /**
           * Basic information Card for Location Section
           */
                Container(
                    child: Card(
                  child: Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: _getStructure(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Loader('basic_form');
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Mkoa: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['region']['name']}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Wilaya: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['district']['name']}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Kata: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['ward']['name']}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Kifaa: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  Text('${device}'),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Long: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      currentLocation != null
                                          ? Text(
                                              '${currentLocation['longitude']}',
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Lat: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      currentLocation != null
                                          ? Text(
                                              '${currentLocation['latitude']}',
                                              overflow: TextOverflow.clip,
                                            )
                                          : Text(""),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),

                /**
           * Basic information Card for form
           */
                Container(
                    child: Container(
                  height: deviceHeight + (deviceHeight * 0.50),
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      /**
                     *
                     * Basic information form fields using custom TextField Widget
                     *
                     */
                      CustomTextField(
                          'text',
                          'Jina La Mtendaji Kata/Mwenyekit wa mtaa',
                          _communityReaderFieldController),
                      SizedBox(height: 5.0),

                      CustomTextField(
                          'text',
                          'Simu ya Mtendaji Kata/Mwenyekit wa mtaa',
                          _communityReaderPhoneFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Kijiji/Mtaa', _villageFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField('text', 'Jina la Mwezeshaji',
                          _facilitatorNameFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField('text', 'Simu ya Mwezeshaji',
                          _facilitatorPhoneNumberFieldController),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                      SelectInput(
                          'Aina ya Mwezeshaji',
                          [
                            {"name": "Community Health Worker"},
                            {"name": "Peer Champion"},
                            {"name": "Community Volunteer"}
                          ]
                              .map((facilitatorType) => facilitatorType["name"])
                              .toList(), onSelection: (value) {
                        setState(() {
                          facilitator_type = value;
                        });
                        print(value);
                      }),
//                ,
                      SizedBox(height: 5.0),
                      StreamBuilder(
                          stream: bloc.csos,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Cso>> snapshot) {

                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Asasi'),
                                    )
                                  ],
                                ),
                              );
                            } else{
                              allCSO = snapshot.data;
                              return SelectInput(
                                  'Asasi', snapshot.data.map((cso) => cso.name).toList(),
                                  onSelection: (value) {
                                    setState(() {
                                      cso = value;
                                    });
                                    print(value);
                                  });
                            }

                          }),
                      SizedBox(height: 25.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PrimaryCustomButton(() async {
                              if (emptyFieldExist([
                                    this._communityReaderFieldController.text,
                                  ]) ==
                                  false) {
                                setState(() {
                                  isError = false;
                                  isSaving = true;
                                  doneSaving = false;
                                });
                                /**
                               * Preparing and saving basic Information
                               */
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String storedReference =
                                    prefs.getString('reference');

                                var session = await bloc.saveUpdateSession(
                                    Session(storedReference),
                                    storedReference,
                                    false);

                                var tree = await _getStructure();
                                print(tree);
                                BasicInformationModel basicInformation =
                                    new BasicInformationModel(
                                  reference: session['reference'],
                                  community_leader_name:
                                      this._communityReaderFieldController.text,
                                  community_leader_phone: this
                                      ._communityReaderPhoneFieldController
                                      .text,
                                  cso: _getCSOID(allCSO, cso),
                                  cso_name: cso,
                                  event_place:
                                      this._villageFieldController.text,
                                  facilitator_phone_number: this
                                      ._facilitatorPhoneNumberFieldController
                                      .text,
                                  facilitator_name:
                                      this._facilitatorNameFieldController.text,
                                  facilitator_type: facilitator_type,
                                  gps_cordinator_s: longitude,
                                  gps_cordinator_e: latitude,
                                  gps_tool_used: device,
                                  venue: null,
                                  ward: tree['ward']['name'],
                                  district: tree['district']['name'],
                                  region: tree['region']['name'],
                                );
                                var results =
                                    await bloc.saveUpdateBasicInformation(
                                        basicInformation, null);
                                if (storedReference == null)
                                  prefs.setString(
                                      'reference', session['reference']);

                                results != null
                                    ? setState(() {
                                        isError = false;
                                        isSaving = false;
                                        doneSaving = true;
                                      })
                                    : setState(() {
                                        isError = true;
                                        isSaving = false;
                                        doneSaving = false;
                                      });
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
                              message: 'Taarifa muhimu zimesajiriwa',
                            )
                          : Container(),
                      isError == true
                          ? ErrorNotification(
                              isError: isError,
                              message:
                                  'Usajiri wa taarifa muhimu umeshindikana',
                            )
                          : Container(),
                      isSaving == true
                          ? OnGoingProcessNotification(
                              isProcessing: isSaving,
                              message:
                                  'Usajiri wa taarifa muhimu unaendelea ...',
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
            child: ListView(
              children: <Widget>[
                /**
           * Basic information Card for Location Section
           */
                Container(
                    child: Card(
                  child: Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: _getStructure(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Loader('basic_form');
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Mkoa: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['region']['name']}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Wilaya: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['district']['name']}"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Kata: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                            "${snapshot.data['ward']['name']}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Kifaa: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  Text('${device}'),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Long: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        '${longitude}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Lat: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Text(
                                        '${latitude}',
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),

                /**
           * Basic information Card for form
           */
                Container(
                    child: Container(
                  height: deviceHeight + (deviceHeight * 0.50),
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      /**
                     *
                     * Basic information form fields using custom TextField Widget
                     *
                     */
                      CustomTextField(
                          'text',
                          'Jina La Mtendaji Kata/Mwenyekit wa mtaa',
                          _communityReaderFieldController),
                      SizedBox(height: 5.0),

                      CustomTextField(
                          'text',
                          'Simu ya Mtendaji Kata/Mwenyekit wa mtaa',
                          _communityReaderPhoneFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField(
                          'text', 'Kijiji/Mtaa', _villageFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField('text', 'Jina la Mwezeshaji',
                          _facilitatorNameFieldController),
                      SizedBox(height: 5.0),
                      CustomTextField('text', 'Simu ya Mwezeshaji',
                          _facilitatorPhoneNumberFieldController),
                      SizedBox(height: 5.0),
                      SizedBox(height: 5.0),
                      SelectInput(
                          'Aina ya Mwezeshaji',
                          [
                            {"name": "Community Health Worker"},
                            {"name": "Peer Champion"},
                            {"name": "Community Volunteer"}
                          ]
                              .map((facilitatorType) => facilitatorType["name"])
                              .toList(), onSelection: (value) {
                        setState(() {
                          facilitator_type = value;
                        });
                        print(value);
                      }),
//                ,
                      SizedBox(height: 5.0),
                      StreamBuilder(
                          stream: bloc.csos,
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Cso>> snapshot) {
                            if (snapshot.data == null) {
                              return Center(
                                child: Column(
                                  children: <Widget>[
                                    LinearProgressIndicator(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Asasi'),
                                    )
                                  ],
                                ),
                              );
                            } else{
                              allCSO = snapshot.data;
                              return SelectInput(
                                  'Asasi',
                                  snapshot.data
                                      .map((cso) => cso.name)
                                      .toList(), onSelection: (value) {
                                setState(() {
                                  cso = value;
                                });
                                print(value);
                              });

                            }


                          }),
                      SizedBox(height: 25.0),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PrimaryCustomButton(() async {
                              if (emptyFieldExist([
                                    this._communityReaderFieldController.text,
                                  ]) ==
                                  false) {
                                setState(() {
                                  isError = false;
                                  isSaving = true;
                                  doneSaving = false;
                                });
                                /**
                               * Preparing and saving basic Information
                               */
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String storedReference =
                                    prefs.getString('reference');

                                var session = await bloc.saveUpdateSession(
                                    Session(storedReference),
                                    storedReference,
                                    false);

                                var tree = await _getStructure();
                                BasicInformationModel basicInformation =
                                    new BasicInformationModel(
                                  reference: session['reference'],
                                  community_leader_name:
                                      this._communityReaderFieldController.text,
                                  community_leader_phone: this
                                      ._communityReaderPhoneFieldController
                                      .text,
                                  cso: _getCSOID(allCSO, cso),
                                  cso_name: cso,
                                  event_place:
                                      this._villageFieldController.text,
                                  facilitator_phone_number: this
                                      ._facilitatorPhoneNumberFieldController
                                      .text,
                                  facilitator_name:
                                      this._facilitatorNameFieldController.text,
                                  facilitator_type: facilitator_type,
                                  gps_cordinator_s: longitude,
                                  gps_cordinator_e: latitude,
                                  gps_tool_used: device,
                                  venue: null,
                                  ward: tree['ward']['name'],
                                  district: tree['district']['name'],
                                  region: tree['region']['name'],
                                );
                                var results =
                                    await bloc.saveUpdateBasicInformation(
                                        basicInformation, null);
                                if (storedReference == null)
                                  prefs.setString(
                                      'reference', session['reference']);

                                results != null
                                    ? setState(() {
                                        isError = false;
                                        isSaving = false;
                                        doneSaving = true;
                                      })
                                    : setState(() {
                                        isError = true;
                                        isSaving = false;
                                        doneSaving = false;
                                      });
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
                              message: 'Taarifa muhimu zimesajiriwa',
                            )
                          : Container(),
                      isError == true
                          ? ErrorNotification(
                              isError: isError,
                              message:
                                  'Usajiri wa taarifa muhimu umeshindikana',
                            )
                          : Container(),
                      isSaving == true
                          ? OnGoingProcessNotification(
                              isProcessing: isSaving,
                              message:
                                  'Usajiri wa taarifa muhimu unaendelea ...',
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

prepareCSOs(csos) {
  var csoToMap = csos == null ? [] : csos;
  return csoToMap.map((cso) => cso.name);
}

_getStructure() async {
  return jsonDecode((await SharedPreferences.getInstance())
      .getString('organisationunit_tree'));
}

_getCSOID(allCSO, cso) {
  var id;
  for (var csoItem in allCSO) {
    if (cso == csoItem.name) {
      id = csoItem.id;
    }
  }
  return id;
}

emptyFieldExist(List<String> fields) {
  int counter = 0;
  fields.forEach((field) {
    if (field.length > 0) {
      counter++;
    }
  });
  return counter == fields.length && counter > 0 ? false : true;
}

deleteStoreReference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('reference');
}
