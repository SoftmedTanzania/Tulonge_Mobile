import 'dart:async';
import 'dart:convert';

import 'package:chw/src/models/cso.dart';
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/map_screen.dart';
import 'package:chw/src/new_implementaion/ui/select_drop_down.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/ui/plugins/multiselect/flutter_multiselect.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_village.dart';

class BasicInformation extends StatefulWidget {
  final Function goNextPage;

  BasicInformation({this.goNextPage});

  @override
  State<StatefulWidget> createState() => BasicInformationState();
}

class BasicInformationState extends State<BasicInformation> {
  StreamSubscription<LocationData> _locationSub; // new
  Map<String, double> currentLocation;

  final _formKey = GlobalKey<FormState>();
  bool doneSaving;
  bool isSaving;
  bool isError;
  bool getLocation;
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
  Location location = new Location();

  TextEditingController _leaderNameController = new TextEditingController();
  TextEditingController _leaderPhoneController = new TextEditingController();
  TextEditingController _dateEditingControler = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _locationSub.cancel();
  }

  @override
  void initState() {
    super.initState();
    doneSaving = false;
    isSaving = false;
    isError = false;
    getLocation = false;
    final model = ScopedModel.of<MainModel>(context);
    _leaderNameController.text = model.newIpc.communityLeaderName;
    _leaderPhoneController.text = model.newIpc.communityLeaderPhone;
    _dateEditingControler.text = model.newIpc.created;
//    _locationSub =
//        location.onLocationChanged().listen((LocationData locationData) {
//      model.setLocation(locationData);
//    });
  }

  getPadding() {
    return EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0);
  }

  getTextStyle() {
    return TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600);
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        var villageList = model.getVillages
            .map((v) => SelectInputModel(id: v.id, name: v.name))
            .toList();
        var ainaYaWalengwa = model.ainaYaWalengwa;

        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Table(
                  columnWidths: {0: FractionColumnWidth(.3)},
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: getPadding(),
                          child: Text("Form No: ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            '${model.newIpc.eventNumber}',
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: getPadding(),
                          child: Text("Mwezeshaji: ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            '${model.newIpc.facilitatorName} ( ${model.newIpc.facilitatorPhoneNumber} )',
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: getPadding(),
                          child: Text("Asasi: ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            '${model.newIpc.csoName}',
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: getPadding(),
                          child: Text("Eneo: ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            "${model.newIpc.region} -> ${model.newIpc.district} -> ${model.newIpc.ward}",
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Location location = new Location();
                            model.setLocation(await location.getLocation());
                          },
                          child: Padding(
                            padding: getPadding(),
                            child: Text("GPS: ",
                                style: TextStyle(fontWeight: FontWeight.w900)),
                          ),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            "${model.newIpc.gpsToolUsed} ( ${model.newIpc.gpsCordinatorE},  ${model.newIpc.gpsCordinateS} )",
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: FlatButton.icon(
                                  onPressed: () async {
                                    model.setLocation(
                                        await location.getLocation());
                                  },
                                  icon: Icon(
                                    Icons.my_location,
                                    size: 16,
                                  ),
                                  label: Text(
                                    'Nilipo',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: FlatButton.icon(
                                  onPressed: () async {
                                    double latitude;
                                    double longtude;
                                    if (model.newIpc.gpsCordinatorE != '' &&
                                        model.newIpc.gpsCordinateS != '') {
                                      latitude = double.tryParse(
                                          model.newIpc.gpsCordinateS);
                                      longtude = double.tryParse(
                                          model.newIpc.gpsCordinatorE);
                                    } else {
                                      setState(() => getLocation = true);
                                      LocationData locationData =
                                          await location.getLocation();
                                      latitude = locationData.latitude;
                                      longtude = locationData.longitude;
                                      setState(() => getLocation = false);
                                    }

                                    final LatLng selectedLocation =
                                        await Navigator.of(context).push(
                                      new PageRouteBuilder(
                                        fullscreenDialog: true,
                                        pageBuilder: (_, __, ___) =>
                                            new MapScreen(
                                          startingLocation:
                                              LatLng(latitude, longtude),
                                        ),
                                        transitionsBuilder: (context, animation,
                                                secondaryAnimation, child) =>
                                            new FadeTransition(
                                                opacity: animation,
                                                child: child),
                                      ),
                                    );
                                    if (selectedLocation == null) {
                                      return;
                                    }
                                    model.setLocationFromMap(selectedLocation);
                                  },
                                  icon: getLocation
                                      ? CircularProgressIndicator()
                                      : Icon(
                                          Icons.map,
                                          size: 16,
                                        ),
                                  label: Text(
                                    'Chagua',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: getPadding(),
                          child: Text("Aina: ",
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        Padding(
                          padding: getPadding(),
                          child: Text(
                            '${model.newIpc.startTime}',
                            style: getTextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /**
                 * Basic information Card for form
                 */
                villageList.length == 0
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Weka Kwanza Vijiji/Mitaa Unayofanyia Kazi',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              RaisedButton(
                                child: Text(
                                  'Ongeza Vijiji/Mitaa',
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    new PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          new AddVillage(),
                                      transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) =>
                                          new FadeTransition(
                                              opacity: animation, child: child),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: deviceHeight + (deviceHeight * 0.50),
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 15.0),
//                      DatePicker(
//                        label: "Tarehe ya tukio",
//                        selectedDate: model.newIpc.created == '' ? DateTime.now() : DateTime.parse(model.newIpc.created),
//                        onDateSelected: (date) {
//                          print(date);
//                          model.setEventDate(date);
//                        },
//                      ),
                            SizedBox(height: 15.0),
                            SelectInput(
                              'Kijiji/Mtaa',
                              villageList,
                              onSelection: (value) {
                                Village selectedVillage =
                                    model.getVillage(value);
                                if (selectedVillage != null) {
                                  model.setIpcVillage(selectedVillage);
                                  _leaderNameController.text =
                                      selectedVillage.leaderName;
                                  _leaderPhoneController.text =
                                      selectedVillage.leaderPhone;
                                }
                              },
                              selectedValue: villageList.firstWhere(
                                  (val) => val.name == model.newIpc.eventPlace,
                                  orElse: () => null),
                              icon: Icons.location_city,
                            ),
                            SizedBox(height: 15.0),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity:
                                  model.newIpc.eventPlace == '' ? 0.0 : 1.0,
                              child: CustomTextField(
                                'text',
                                'Jina La Mtendaji Kata/Mwenyekit wa mtaa',
                                _leaderNameController,
                                icon: Icons.person_outline,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity:
                                  model.newIpc.eventPlace == '' ? 0.0 : 1.0,
                              child: CustomTextField(
                                'text',
                                'Simu ya Mtendaji Kata/Mwenyekit wa mtaa',
                                _leaderPhoneController,
                                icon: Icons.phone,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity:
                                  model.newIpc.eventPlace == '' ? 0.0 : 1.0,
                              child: SelectInput(
                                'Kundi la Walengwa',
                                ainaYaWalengwa,
                                onSelection: (value) {
                                  model.setWalengwa(value);
                                },
                                selectedValue: ainaYaWalengwa.firstWhere(
                                    (val) =>
                                        val.name == model.newIpc.materialUsed,
                                    orElse: () => null),
                                icon: Icons.people,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity:
                                  model.newIpc.materialUsed == '' ? 0.0 : 1.0,
                              child: MultiSelect(
                                  autovalidate: false,
                                  titleText: 'Aina ya Walengwa wa elimu',
                                  validator: (value) {
                                    return model.newIpc.targets != ''
                                        ? null
                                        : 'Tafadhali chagua  moja au zaidi';
                                  },
                                  errorText: 'Tafadhari moja au zaidi',
                                  dataSource:
                                      model.currentTargetList.map((target) {
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
                                  icon: Icons.local_library,
                                  initialValue:
                                      model.newIpc.targets.split(', '),
                                  onSaved: (va4lue) {
                                    model.setTargetGroup(va4lue);
                                  }),
                            ),
                            SizedBox(height: 25.0),
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 400),
                              opacity: model.newIpc.targets == '' ? 0.0 : 1.0,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    PrimaryCustomButton(
                                      () async {
                                        if (_formKey.currentState.validate()) {
                                          widget.goNextPage();
                                        }
                                      },
                                      'Taarifa za Elimu',
                                      isSaving: isSaving,
                                    ),
                                    SizedBox(width: 55.0),
                                    Expanded(
                                      child: PrimaryCustomButton(() {
                                        Navigator.pop(context);
                                      }, CANCEL),
                                    ),
                                  ],
                                ),
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
                      ),
              ],
            ),
          ),
        );
      },
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
