import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chw/src/resources/constants.dart';

class GroupCheckBoxes extends StatefulWidget {
  String checkBoxType;
  Function onChangeSelection;
  String displayField;
  String valueField;
  String groupLabel;
  List<Map<String, dynamic>> dataSource;

  GroupCheckBoxes(
      this.groupLabel, this.displayField, this.dataSource, this.onChangeSelection);

  @override
  State<StatefulWidget> createState() {
    return GroupCheckBoxesState(
        this.groupLabel, this.displayField, this.dataSource, this.onChangeSelection);
  }
}

class GroupCheckBoxesState extends State<GroupCheckBoxes> {
  Function onChangeSelection;
  String displayField;
  String valueField;
  List<Map<String, dynamic>> dataSource;
  String groupLabel;

  GroupCheckBoxesState(
      this.groupLabel, this.displayField, this.dataSource, this.onChangeSelection);

  var _values =  new Map<String, bool>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> checkBoxes = [
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.topLeft,
        child: Text(
          "${groupLabel}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];

    dataSource.forEach((data) {
        _values.putIfAbsent(data[displayField], ()=>false);
    });

    dataSource.forEach((data) => checkBoxes.add(CheckboxListTile(
          value: _values[data[displayField]],
          onChanged: (value) {
            setState(() => _values[data[displayField]] = value);
            onChangeSelection(_values);
//            print(onChangeSelection);
          },
          title: new Text('${data[displayField]}'),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: primaryColor,
        )));

    return Column(
      children: checkBoxes,
    );
  }
}
