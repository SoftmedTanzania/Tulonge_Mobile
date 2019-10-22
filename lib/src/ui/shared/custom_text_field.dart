import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String type;
  final String hintText;
  final TextEditingController _inputFieldController;
  final bool isRequered;
  final IconData icon;
  final Function onChanged;

  CustomTextField(this.type, this.label, this._inputFieldController,
      {this.isRequered = false, this.onChanged, this.icon = Icons.format_indent_increase, this.hintText});

  @override
  State<StatefulWidget> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {

  CustomTextFieldState();
  FocusNode textField = FocusNode();

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.date;
  bool editable = true;
  DateTime date;
  final elevetion = 8.0;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'text':
        {
          return Material(
            shadowColor: Colors.black54,
            elevation: elevetion,
            borderRadius: BorderRadius.circular(28),
            child: TextFormField(
              controller: widget._inputFieldController,
              autofocus: false,
              style: TextStyle(fontWeight: FontWeight.w600),
              validator: (value) {
                if (value.isEmpty && widget.isRequered) {
                  return 'Tafadhali ingiza ${widget.label}';
                }
                return null;
              },
              decoration: getDecoration(),
              onChanged: widget.onChanged,
            ),
          );
        }

        break;

      case 'textArea':
        {
          return Material(
            shadowColor: Colors.black54,
            elevation: elevetion,
            borderRadius: BorderRadius.circular(28),
            child: TextFormField(
              controller: widget._inputFieldController,
              autofocus: false,
              maxLines: 8,
              minLines: 2,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(fontWeight: FontWeight.w600),
              validator: (value) {
                if (value.isEmpty && widget.isRequered) {
                  return 'Tafadhali ingiza ${widget.label}';
                }
                return null;
              },
              decoration: getDecoration(),
              onChanged: widget.onChanged,
            ),
          );
        }

        break;

      case 'number':
        {
          return Material(
            shadowColor: Colors.black54,
            elevation: elevetion,
            borderRadius: BorderRadius.circular(28),
            child: TextFormField(
              controller: widget._inputFieldController,
              keyboardType: TextInputType.number,
              autofocus: false,
              validator: (value) {
                if (value.isEmpty && widget.isRequered) {
                  return 'Tafadhali ingiza ${widget.label}';
                }
                return null;
              },
              decoration: getDecoration(),
              onChanged: widget.onChanged,
            ),
          );
        }

      case 'email':
        {
          return Material(
            shadowColor: Colors.black54,
            elevation: elevetion,
            borderRadius: BorderRadius.circular(28),
            child: TextFormField(
              controller: widget._inputFieldController,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              validator: (value) {
                if (value.isEmpty && widget.isRequered) {
                  return 'Tafadhali ingiza ${widget.label}';
                }
                return null;
              },
              decoration: getDecoration(),
              onChanged: widget.onChanged,
            ),
          );
        }

      case 'phone':
        {
          return Material(
            shadowColor: Colors.black54,
            elevation: elevetion,
            borderRadius: BorderRadius.circular(28),
            child: TextFormField(
              controller: widget._inputFieldController,
              keyboardType: TextInputType.phone,
              autofocus: false,
              validator: (value) {
                if (value.isEmpty && widget.isRequered) {
                  return 'Tafadhali ingiza ${widget.label}';
                }
                if (value.isNotEmpty && value.length != 10) {
                  return 'Namba Ya simu inatakiwa kuwa na tarakimu 10';
                }
                return null;
              },
              decoration: getDecoration(),
            ),
          );
        }

        break;
      case 'date':
        {
          return DateTimePickerFormField(
            inputType: inputType,
            dateOnly: true,
            controller: widget._inputFieldController,
            format: DateFormat('yyyy-MM-dd'),
            editable: false,
            decoration: getDecoration(),
            onChanged: (dt) => setState(() => date = dt),
          );
        }

        break;
    }
  }

  InputDecoration getDecoration() {
    return InputDecoration(
      prefixIcon: Icon(widget.icon),
      hintText: '${widget.hintText ?? widget.label}',
      labelText: '${widget.label}',
      contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28.0),
      )
    );
  }
}
