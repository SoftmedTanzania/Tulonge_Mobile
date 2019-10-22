library flutter_multiselect;

import 'package:flutter/material.dart';
import 'package:chw/src/ui/plugins/multiselect/selection_modal.dart';

class MultiSelect extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final bool filterable;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final IconData icon;
  final dynamic parentChildrenSelectionRelation;

  MultiSelect(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      dynamic initialValue,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Bonyeza kufanya chaguo...',
      this.required = false,
      this.errorText = 'Tafadhari weka angalau chaguo moja',
      this.value,
      this.leading,
      this.filterable = true,
      this.dataSource,
      this.textField,
      this.valueField,
      this.change,
      this.open,
      this.close,
      this.trailing,
        this.icon,
      this.parentChildrenSelectionRelation})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<dynamic> state) {
              List<Widget> _buildSelectedOptions(dynamic values, state) {
                List<Widget> selectedOptions = [];
                if (values != null) {
                  values.forEach((item) {
                    var existingItem = dataSource.singleWhere(
                        (itm) => itm[valueField] == item,
                        orElse: () => null);
                    if (existingItem != null) {
                      selectedOptions.add(Chip(
                        label: Text(existingItem[textField],
                            overflow: TextOverflow.ellipsis),
                      ));
                    }
                  });
                }

                return selectedOptions;
              }
              return InkWell(
                  onTap: () async {
                    var results = await Navigator.push(
                        state.context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => SelectionModal(
                              filterable: filterable,
                              valueField: valueField,
                              textField: textField,
                              dataSource: dataSource,
                              values: state.value ?? []),
                          fullscreenDialog: true,
                        ));
                    if (results != null) {
                      if (results.length > 0) {
                        state.didChange(results);
                      } else {
                        state.didChange(null);
                      }
                      onSaved(results);
                    }
                  },
                  child: Material(
                    shadowColor: Colors.black54,
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(18),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(icon ?? Icons.add_shopping_cart),
                        contentPadding:
                            EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18.0)),
                            borderSide: BorderSide(color: Colors.grey.shade400)),
                        errorText: state.hasError ? state.errorText : null,
                        errorMaxLines: 4,
                      ),
                      isEmpty: state.value == null || state.value == '',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  titleText,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                )),
                                required
                                    ? Text(
                                        ' *',
                                        style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 12.0),
                                      )
                                    : Container(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Color(0xFF3D72B6),
                                      size: 30.0,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          state.value != null
                              ? Wrap(
                                  spacing: 8.0, // gap between adjacent chips
                                  runSpacing: 1.0, // gap between lines
                                  children:
                                      _buildSelectedOptions(state.value, state),
                                )
                              : new Container(
                                  margin:
                                      EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 6.0),
                                  child: Text(
                                    hintText,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ));
            });
}
