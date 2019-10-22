import 'package:flutter/material.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/ui/shared/collapsible.dart';

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
    return EducatitonTypeFieldState(
        educationTypes: this.educationTypes,
        parentsSelected: this.parentsSelected,
        childrenSelected: this.childrenSelected,
        onSelectionDone: this.onSelectionDone);
  }
}

class EducatitonTypeFieldState extends State<EducatitonTypeField> {
  List<MaterialModel> materials;
  List<dynamic> educationTypes;
  Function(List<Map<String, dynamic>>, dynamic) onSelectionDone;
  List<Map<String, dynamic>> selectedParents;
  dynamic selectedChildren;
  List<Map<String, dynamic>> parentsSelected;
  dynamic childrenSelected;

  EducatitonTypeFieldState(
      {this.educationTypes,
      this.parentsSelected,
      this.childrenSelected,
      this.onSelectionDone});

//  EducatitonTypeFieldState({this.educationTypes, this.onSelectionDone});

  @override
  Widget build(BuildContext context) {
    List<Entry> entryList = [];
    educationTypes.forEach((entry) {
      List<Entry> children = [];
      entry.specificMessage.forEach((entry) {
        children.add(Entry(
          entry['id'],
          entry['name'],
          false,
        ));
      });
      entryList.add(Entry(entry.id, entry.name, false, children));
    });

    return Column(
      children: <Widget>[
        Collapsible(entryList, parentsSelected, childrenSelected,
            (selectedParents) {
          setState(() {
            parentsSelected = selectedParents;
          });
          this.onSelectionDone(selectedParents, selectedChildren);
        }, (selectedChild) {
          setState(() {
            selectedChildren = selectedChild;
          });
          this.onSelectionDone(selectedParents, selectedChild);
        })
      ],
    );
  }
}
