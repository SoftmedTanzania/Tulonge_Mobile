import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/target_audience.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/ui/shared/custom_button.dart';
import 'package:chw/src/ui/shared/group_check_boxes.dart';
import 'package:chw/src/ui/shared/notification.dart';
import 'package:chw/src/ui/shared/select_drop_down.dart';

class IntendedGroup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntendedGroupState();
  }
}

class IntendedGroupState extends State<IntendedGroup> {
  final _formKey = GlobalKey<FormState>();

  List<String> listOptions = ['Vijana', 'Watu wazima'];
  List<Map<String, dynamic>> dataGroup;
  bool isSaving;
  bool doneSaving;
  bool isError;

  /**
   * Data Collection Fields
   */
  String selectedGroup;
  List<Map<String, dynamic>> selectedOptions;

  Bloc bloc;

  @override
  void initState() {
    selectedGroup = null;
    dataGroup = [];
    doneSaving = false;
    isSaving = false;
    isError = false;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(IntendedGroup oldWidget) {
    if (this.mounted) {
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
//    bloc.disposeTargetAudience();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    bloc = Provider.of(context);

    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Walengwa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        SelectInput(
                            '', listOptions, onSelection: (selectedValue) {
                          setState(() {
                            selectedGroup = null;
                          });
                          setState(() {
                            isError = false;
                            isSaving = false;
                            doneSaving = false;
                          });
                          var timer =
                          new Timer(const Duration(milliseconds: 10), () {
                            bloc.getTargetAudience();
                            setState(() {
                              selectedGroup = selectedValue;
                            });
                          });
                        }),

                        /**
                         * Conditional drop down depending on the selected option for target audience
                         */
                        selectedGroup == null
                            ? Container()
                            : StreamBuilder(
                            stream: bloc.targetAudience,
                            builder: (BuildContext context,
                                AsyncSnapshot<Map<String, dynamic>> snapshot) {
                              if (!snapshot.hasData) {
                                return LinearProgressIndicator();
                              }

                              dataGroup = _getGroupdDataList(
                                  snapshot.data, selectedGroup);
                              return GroupCheckBoxes(
                                  selectedGroup, 'name', dataGroup,
                                      (selections) {
                                    List<Map<String, dynamic>> selected = [];
                                    dataGroup.forEach((groupItem) =>
                                    (selections[groupItem['name']] == true)
                                        ? selected.add(groupItem)
                                        : null);
                                    setState(() => selectedOptions = selected);
                                  });
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
//                  height: deviceHeight*2,
//                  margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PrimaryCustomButton(() async {
                          setState(() {
                            isError = false;
                            isSaving = false;
                            doneSaving = false;
                          });
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          String storedReference = prefs.getString('reference');
                          if (selectedGroup != null &&
                              selectedOptions.length > 0 &&
                              storedReference != null) {
                            setState(() {
                              isError = false;
                              isSaving = true;
                              doneSaving = false;
                            });

                            String selectedValues = "";

                            Map<String, dynamic> intended = {
                              "attendance_female_10_14": false,
                              "attendance_female_15_17": false,
                              "attendance_female_18_24": false,
                              "attendance_female_25_30": false,
                              "attendance_female_31_49": false,
                              "attendance_female_50": false,
                              "attendance_male_10_14": false,
                              "attendance_male_15_17": false,
                              "attendance_male_18_24": false,
                              "attendance_male_25_30": false,
                              "attendance_male_31_49": false,
                              "attendance_male_50": false};

                            selectedOptions.forEach((option) {
                              selectedValues = selectedValues +
                                  option['name'] +
                                  '_' +
                                  option['id'] +
                                  ',';
                            });
                            var target = TargetAudience(
                                reference: storedReference,
                                name: selectedGroup,
                                value: selectedValues);
                            print("REFERENCE");
                            print(selectedGroup);
                            print(selectedOptions);
                            print(selectedValues);
//                        var results =
//                            await bloc.saveUpdateTargetAudience(target, storedReference);
//                        results != null
//                            ? setState(() {
//                                isError = false;
//                                isSaving = false;
//                                doneSaving = true;
//                              })
//                            : setState(() {
//                                isError = true;
//                                isSaving = false;
//                                doneSaving = false;
//                              });
                          } else {
                            print(storedReference);
                            if (storedReference == null) {
                              setState(() {
                                isError = true;
                                isSaving = false;
                                doneSaving = false;
                              });
                            }
                          }
                        }, SAVE),
                        SizedBox(width: 55.0),
                        PrimaryCustomButton(() {}, CANCEL),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  doneSaving == true
                      ? SuccessNotification(
                    isSuccess: doneSaving,
                    message: 'Walengwa wamesajiriwa',
                  )
                      : Container(),
                  isError == true
                      ? ErrorNotification(
                    isError: isError,
                    message: 'Usajiri wa Walengwa umeshindikana',
                  )
                      : Container(),
                  isSaving == true
                      ? OnGoingProcessNotification(
                    isProcessing: isSaving,
                    message: 'Usajiri wa Walengwa unaendelea ...',
                  )
                      : Container(),
                ],
              )),
        ]));
  }
}

List<Map<String, dynamic>> _getGroupdDataList(data, selectedGroup) {
  List<dynamic> dataList = data[selectedGroup == 'Vijana' ? 'YOUTH' : 'ADULTS'];
  return dataList
      .map((item) => {'name': item['swahili_name'], "id": item['id']})
      .toList();
}
