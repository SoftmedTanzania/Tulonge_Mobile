import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/material_model.dart';
import 'package:chw/src/ui/plugins/multiselect/flutter_multiselect.dart';

class Collapsible extends StatefulWidget {
  List<MaterialModel> materials;
  List<Entry> data;
  Function(List<Map<String, dynamic>>) onParentSelected;
  Function(dynamic) onChildrenSelected;
  List<Map<String, dynamic>> parentSelected;
  dynamic childrenSelected;

  Collapsible(this.data, this.parentSelected, this.childrenSelected,
      this.onParentSelected, this.onChildrenSelected);

  @override
  State<StatefulWidget> createState() {
    return CollapsibleState(this.data, this.parentSelected,
        this.childrenSelected, this.onParentSelected, this.onChildrenSelected);
  }
}

class CollapsibleState extends State<Collapsible> {
  List<MaterialModel> materials;
  List<Entry> data;
  Function(List<Map<String, dynamic>>) onParentSelected;
  Function(dynamic) onChildrenSelected;
  List<Map<String, dynamic>> parentsSelected;
  dynamic childrenSelected;
  SharedPreferences prefs;

  CollapsibleState(this.data, this.parentsSelected, this.childrenSelected,
      this.onParentSelected, this.onChildrenSelected);


  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var selectionObject;
    try {
      selectionObject = jsonDecode(prefs.getString('selectedChildrenElimu')) ?? {};
    } catch (e) {
    }
    return Column(
      children: data
          .map((dataItem) =>
              EntryItem(dataItem, this.parentsSelected, (selectedParents) {
                setState(() {
                  this.parentsSelected = selectedParents;
                });
                onParentSelected(this.parentsSelected);
              }, this.onChildrenSelected,selectionObject), )
          .toList(),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {

  final String id;
  final String title;
  final String keySearch;
  bool isSelected = false;
  List<Entry> children;
  Entry(
      this.id,
      this.title,
      this.isSelected,
      [this.children = const <Entry>[], this.keySearch = 'HIV']);

}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  List<MaterialModel> materials;
  List<Map<String, dynamic>> selectedParents;
  dynamic localSelectionObject;

  EntryItem(this.entry, this.selectedParents, this.onParentSelected,
      this.onChildrenSelected, this.localSelectionObject);

  final Function(List<Map<String, dynamic>>) onParentSelected;
  final Function(dynamic) onChildrenSelected;
  final Entry entry;
  List<Map<String, dynamic>> parentsSelected = [];

  Widget _buildTiles(Entry root, onTileParentSelected, onTileChildSelected, localSelectionObject) {
    for (var parent in selectedParents) {
      if (parent['id'] == root.id) root.isSelected = true;
    }
    var initialValues = localSelectionObject == null || localSelectionObject[root.id] == null ? {} : localSelectionObject[root.id];

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(top: 2.0),
      child: ExpansionTile(
          onExpansionChanged: (value) {
            print(root.id);
          },
          initiallyExpanded: root.isSelected,
          key: PageStorageKey<Entry>(root),
          title: Container(
            child: CheckboxListTile(
              value: root.isSelected,
              onChanged: (value) {
                root.isSelected = !root.isSelected;
                List<Map<String, dynamic>> updatedParents = [];
                if (selectedParents.length == 0) {
                  updatedParents.add({"id": root.id, "title": root.title});
                } else {
                  List<Map<String, dynamic>> motivatedParents = [];
                  var exist = false;
                  for (var parent in selectedParents) {
                    if (parent['id'] == root.id) {
                      exist = true;
                    } else {
                      motivatedParents.add(parent);
                    }
                  }
                  if (exist == false)
                    motivatedParents.add({"id": root.id, "title": root.title});
                  updatedParents = [...motivatedParents];
                }
                onTileParentSelected(updatedParents);
              },
              title: new Text('${root.title}'),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          children: [
            {"id": "1", "name": "Ujumbe mahsusi kwa eneo la afya/mada husika"},
            {"id": "2", "name": "Nyenzo zilivyotumika kutolea elimu ya afya"}
          ]
              .map((child) => Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        child['id'] == '2'
                            ? FutureBuilder(
                                future: _getMaterialSupplied(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return MultiSelect(
                                        initialValue: initialValues[child['id']]==null?[]:(initialValues[child['id']].map((value)=>value['id'])).toList(),
                                          autovalidate: false,
                                          titleText: child['name'],
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Tafadhari chagua mshirki mmoja au';
                                            }
                                          },
                                          errorText:
                                              'Tafadhari chagua mshirki mmoja au',
                                          dataSource: snapshot.data
                                              .map((child) => {
                                                    'display':
                                                        child['swahili_name'],
                                                    'value': child["id"]
                                                  })
                                              .toList(),
                                          textField: 'display',
                                          valueField: 'value',
                                          filterable: true,
                                          required: true,
                                          value: null,
                                          close: (value) {},
                                          change: (value) {},
                                          onSaved: (children) async {
                                            onTileChildSelected(
                                                await _getSelectedChildren(
                                                    children,
                                                    snapshot,
                                                    root,
                                                    child));
                                          });
                                    } else {
                                      return new CircularProgressIndicator();
                                    }
                                  } else {
                                    return Container();
                                  }
                                })
                            : FutureBuilder(
                                future: _getSpecificMessage(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return MultiSelect(
                                          initialValue: initialValues[child['id']] == null?[]:(initialValues[child['id']].map((value)=>value['id'])).toList(),
                                          autovalidate: false,
                                          titleText: child['name'],
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Tafadhari chagua mshirki mmoja au';
                                            }
                                          },
                                          errorText:
                                              'Tafadhari chagua mshirki mmoja au',
                                          dataSource: snapshot.data[root.title]
                                              .map((child) => {
                                                    'display':
                                                        child['swahili_name'],
                                                    'value': child["id"]
                                                  })
                                              .toList(),
                                          textField: 'display',
                                          valueField: 'value',
                                          filterable: true,
                                          required: true,
                                          value: null,
                                          close: (value) {},
                                          change: (value) {},
                                          onSaved: (children) async {
                                            onTileChildSelected(
                                                await _getSelectedChildren(
                                                    children,
                                                    snapshot,
                                                    root,
                                                    child));
                                          });
                                    } else {
                                      return new CircularProgressIndicator();
                                    }
                                  } else {
                                    return Container();
                                  }
                                })
                      ],
                    ),
                  ))
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry, this.onParentSelected, this.onChildrenSelected, this.localSelectionObject);
  }
}

_getMaterialSupplied() async {
  final prefs = await SharedPreferences.getInstance();
  var materials = jsonDecode(prefs.getString('materialSupplied'));
  return materials;
}

_getSpecificMessage() async {
  final prefs = await SharedPreferences.getInstance();
  var materials = jsonDecode(prefs.getString('specificMessage'));
  return materials;
}

_getSelectedChildren(children, snapshot, root, child) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<dynamic> type = [];
  dynamic childrenObject = {};
  var childObject = prefs.getString('selectedChildrenElimu') == null
      ? {}
      : jsonDecode(prefs.getString('selectedChildrenElimu'));
  childrenObject[root.id] = childObject[root.id] ?? {};

  List<dynamic> data = snapshot.data.runtimeType == type.runtimeType
      ? snapshot.data
      : snapshot.data[root.title];
  childrenObject[root.id][child['id']] =
      List<Map<String, dynamic>>.from(data.map((child) {
    if (children.contains(child['id']) == true) return child;
  }));
  childrenObject[root.id][child['id']].removeWhere((value) => value == null);
  prefs.setString('selectedChildrenElimu', jsonEncode(childrenObject));
  return childrenObject;
}
