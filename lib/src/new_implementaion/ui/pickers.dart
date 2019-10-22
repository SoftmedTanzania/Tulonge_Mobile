import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            hintText: labelText,
            labelText: labelText,
            contentPadding: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28.0)
            )
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: TextStyle(fontWeight: FontWeight.w600)),
            new Icon(Icons.arrow_drop_down,
                color: Theme
                    .of(context)
                    .brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatefulWidget {

  final String label;
  final DateTime selectedDate;
  final DateTime minDate;
  final DateTime maxDate;
  final DatePickerMode initialDatePickerMode = DatePickerMode.day;
  final ValueChanged<DateTime> onDateSelected;
  DatePicker({
    Key key,
    this.label,
    this.selectedDate,
    this.onDateSelected,
    this.minDate,
    this.maxDate
  }) : super(key: key);

  @override
  _DatePicker createState() =>
      new _DatePicker();
}
class _DatePicker extends State<DatePicker> {


  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: widget.initialDatePickerMode,
        firstDate: widget.minDate ?? new DateTime(2015, 5),
        lastDate: widget.maxDate ?? new DateTime(2101)
    );
    if (picked != null && picked != selectedDate){
      widget.onDateSelected(picked);
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme
        .of(context)
        .textTheme
        .title;
    return Material(
      shadowColor: Colors.black54,
      elevation: 8.0,
      borderRadius: BorderRadius.circular(28),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Expanded(
            flex: 4,
            child: new _InputDropdown(
              labelText: widget.label,
              valueText: new DateFormat.yMMMd().format(selectedDate),
              valueStyle: valueStyle,
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key key,
    this.labelText,
    this.selectedTime,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DatePickerMode initialDatePickerMode = DatePickerMode.year;
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme
        .of(context)
        .textTheme
        .title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final DatePickerMode initialDatePickerMode = DatePickerMode.year;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: initialDatePickerMode,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme
        .of(context)
        .textTheme
        .title;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}
