import 'package:flutter/material.dart';

class SelectInputModel {
  final String id;
  final String name;

  SelectInputModel({this.id = '', this.name = ''});
}

class SelectInput extends StatefulWidget {
  final List<SelectInputModel> options;
  SelectCallback onSelection;
  String label;
  SelectInputModel selectedValue;
  final IconData icon;

  SelectInput(this.label,this.options, {this.onSelection, this.selectedValue, this.icon = Icons.format_indent_increase});

  @override
  State<StatefulWidget> createState() => SelectInputState();

}

class SelectInputState extends State<SelectInput> {

  _fieldDropDown(String label, List<SelectInputModel> theList, int resultPosition, var dbField,
      Function(String) onSelection) {
    return Material(
      shadowColor: Colors.black54,
      elevation: 8.0,
      borderRadius: BorderRadius.circular(28),
      child: new FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
              hintText: '${label}',
              labelText: '${label}',
              contentPadding: EdgeInsets.fromLTRB(10.0, 12.5, 8.0, 12.5),
              border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(32.0)
                  ),
            ),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton(
                value: widget.selectedValue,
                isDense: true,
                onChanged: (SelectInputModel newValue) {
                  widget.onSelection(newValue.id);
                  setState(() {
                    widget.selectedValue = newValue;
                    state.didChange(newValue);
                  });
                },
                items: theList.map<DropdownMenuItem<SelectInputModel>>((SelectInputModel value) {
                  return DropdownMenuItem<SelectInputModel>(
                    value: value,
                    child: new SizedBox(
                        width: 200,
                        child: new Text('${value.name} ', style: TextStyle(fontWeight: FontWeight.w600),)
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
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
