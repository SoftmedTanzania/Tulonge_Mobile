
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData icon;
  final Color color;
  final Color textColor;
  const CustomButton({
    Key key, this.text, this.color, this.onPressed, this.icon, this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color ?? Colors.grey,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 15.0,
            color: textColor ?? Colors.black87,
          ),
          Text(
            text,
            style:
            TextStyle(fontSize: 12.0, color: textColor ?? Colors.black87),
          ),
        ],
      ),
      elevation: 4,
      onPressed: onPressed,
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
    );
  }
}