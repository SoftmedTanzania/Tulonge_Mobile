import 'package:flutter/material.dart';
import 'package:chw/src/resources/constants.dart';

class PrimaryCustomButton extends StatefulWidget{
  Function onTapCallBack;
  String label;
  bool isSaving;
  PrimaryCustomButton(this.onTapCallBack, this.label, {this.isSaving = false});
  @override
  State<StatefulWidget> createState() {
    return PrimaryCustomButtonState();
  }
}

class PrimaryCustomButtonState extends State<PrimaryCustomButton>{

  PrimaryCustomButtonState();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        widget.onTapCallBack();
      },
      child: Container(
        height: 45.0,
        width: deviceWidth * 0.4,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: primaryColor,
          borderRadius: new BorderRadius.all(const Radius.circular(18.0)),
        ),
        child: widget.isSaving == false
            ? new Text(
          "${widget.label}",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 0.3,
          ),
        )
            : new CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.white),
        ),
      ),
    );
  }
}