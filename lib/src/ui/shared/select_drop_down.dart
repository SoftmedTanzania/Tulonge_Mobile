import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  final List<String> options;
  SelectCallback onSelection;
  String label;
  String selectedValue;

  SelectInput(this.label,this.options, {this.onSelection, this.selectedValue});

  @override
  State<StatefulWidget> createState() => SelectInputState();

}

class SelectInputState extends State<SelectInput> {

  _fieldDropDown(String label, List<String> theList, int resultPosition, var dbField,
      Function(String) onSelection) {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            hintText: '${label}',
            labelText: '${label}',
            contentPadding: EdgeInsets.fromLTRB(10.0, 12.5, 8.0, 12.5),
            border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(32.0)
                ),
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              value: widget.selectedValue,
              isDense: true,
              onChanged: (String newValue) {
                widget.onSelection(newValue);
                setState(() {
                  widget.selectedValue = newValue;
                  state.didChange(newValue);
                });
              },
              items: theList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new SizedBox(
                      width: 200,
                      child: new Text('${value} ')
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _fieldDropDown(widget.label, widget.options, 1, 'field', widget.onSelection);
  }
}

typedef SelectCallback = void Function(String selectedValue);
