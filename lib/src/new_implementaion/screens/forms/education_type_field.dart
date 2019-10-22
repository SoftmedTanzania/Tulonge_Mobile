import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/ui/shared/collapsible.dart';
import 'package:scoped_model/scoped_model.dart';

class EducatitonTypeField extends StatefulWidget {
  List<dynamic> educationTypes;
  List<Map<String, dynamic>> parentsSelected;
  dynamic childrenSelected;
  Function(List<Map<String, dynamic>>, dynamic) onSelectionDone;

  EducatitonTypeField(
      {this.educationTypes,
      this.parentsSelected,
      this.childrenSelected,
      this.onSelectionDone});

  @override
  State<StatefulWidget> createState() {
    return EducatitonTypeFieldState();
  }
}

class EducatitonTypeFieldState extends State<EducatitonTypeField> {
  List<MaterialModel> materials;
  List<Map<String, dynamic>> selectedParents;
  dynamic selectedChildren;

  EducatitonTypeFieldState();

//  EducatitonTypeFieldState({this.educationTypes, this.onSelectionDone});

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<MainModel>(context);
    List<Entry> entryList = [];
    widget.educationTypes.forEach((entry) {
      List<Entry> children = [];
      model.getSpecificMessageByType(entry).forEach((entry) {
        children.add(Entry(
          entry.id,
          entry.name,
          false,
        ));
      });
      entryList.add(Entry(entry.id, entry.name, false, children));
    });

    return Column(
      children: <Widget>[
        Text('Hello')
//        Collapsible(entryList, widget.parentsSelected, widget.childrenSelected,
//            (selectedParents) {
//          setState(() {
//            widget.parentsSelected = selectedParents;
//          });
//          widget.onSelectionDone(selectedParents, selectedChildren);
//        }, (selectedChild) {
//          setState(() {
//            selectedChildren = selectedChild;
//          });
//          widget.onSelectionDone(selectedParents, selectedChild);
//        })
      ],
    );
  }
}
