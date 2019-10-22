import 'package:flutter/material.dart';

class SuccessNotification extends StatefulWidget {
  bool isSuccess;

  String message;

  SuccessNotification({this.isSuccess, this.message});

  @override
  State<StatefulWidget> createState() {
    return SuccessNotificationState(
        isSuccess: this.isSuccess, message: this.message);
  }
}

class SuccessNotificationState extends State<SuccessNotification> {
  bool isSuccess;
  String message;

  SuccessNotificationState({this.isSuccess, this.message});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return isSuccess == true
        ? Container(
            padding: EdgeInsets.all(20.0),
            width: deviceWidth,
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 128, 0, 0.1),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: Color.fromRGBO(0, 128, 0, 0.1),
                  width: 2.0,
                )),
            child: Text(
              '${message}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          )
        : Container();
  }
}

class ErrorNotification extends StatefulWidget {
  bool isError;

  String message;

  ErrorNotification({this.isError, this.message});

  @override
  State<StatefulWidget> createState() {
    return ErrorNotificationState(isError: this.isError, message: this.message);
  }
}

class ErrorNotificationState extends State<ErrorNotification> {
  bool isError;
  String message;

  ErrorNotificationState({this.isError, this.message});

  @override
  Widget build(BuildContext context) {
    var color = Color.fromRGBO(237, 22, 22, 0.1);
    double deviceWidth = MediaQuery.of(context).size.width;
    return isError == true
        ? Container(
            padding: EdgeInsets.all(15.0),
            width: deviceWidth,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: color,
                  width: 2.0,
                )),
            child: Text(
              'Sorry, ${message}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          )
        : Container();
  }
}

class OnGoingProcessNotification extends StatefulWidget {
  bool isProcessing;

  String message;

  OnGoingProcessNotification({this.isProcessing, this.message});

  @override
  State<StatefulWidget> createState() {
    return OnGoingProcessNotificationState(
        isProcessing: this.isProcessing, message: this.message);
  }
}

class OnGoingProcessNotificationState
    extends State<OnGoingProcessNotification> {
  bool isProcessing;
  String message;

  OnGoingProcessNotificationState({this.isProcessing, this.message});

  var color = Color.fromRGBO(191, 191, 191, 0.1);

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return isProcessing == true
        ? Container(
            padding: EdgeInsets.all(15.0),
            width: deviceWidth,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: color,
                  width: 2.0,
                )),
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 10.0,
                ),
                Text('${message}',  style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(191, 191, 191, 1)),)
              ],
            ),
          )
        : Container();
  }
}
