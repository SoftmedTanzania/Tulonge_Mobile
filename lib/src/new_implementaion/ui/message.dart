import 'package:flutter/material.dart';
import 'package:chw/src/new_implementaion/theme/colors.dart';

const Map<String, Icon> _messageConfigs = {
  "INFO": const Icon(
    Icons.check_circle_outline,
    color: Colors.blueAccent,
    size: 34.0,
  ),
  "WARNING": const Icon(
    Icons.warning,
    color: Colors.yellowAccent,
    size: 34.0,
  ),
  "ERROR": const Icon(
    Icons.error_outline,
    color: Colors.redAccent,
    size: 34.0,
  ),
  "SUCCESS": const Icon(
    Icons.check_circle_outline,
    color: Colors.lightGreenAccent,
    size: 34.0,
  ),
  "NETWORK": const Icon(
    Icons.network_locked,
    color: Colors.redAccent,
    size: 34.0,
  ),
};

showMessage(BuildContext context, type, String message, onClose) {
  showModalBottomSheet<Null>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: onClose,
          child: Container(
            height: 140.0,
            decoration: BoxDecoration(color: TulongeBlack),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 19.0),
                  child: Center(
                    child: _messageConfigs[type],
                  ),
                ),
                Expanded(
                  child: Center(
//                          padding: const EdgeInsets.only(left: 28.0,right: 28.0,top: 9.0),
                    child: Text(message,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontFamily: 'AvertaFont',
                            color: TulongeSurfaceWhite,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      }).then((value){
    onClose();
  });
}

confirmSubmission(BuildContext context, String message, {Function onOK, Function onCancel}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          //onTap: onClose,
          child: Container(
              decoration: BoxDecoration(color: TulongeBlack),
              height: 140.0,
              child: new Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Center(
//                          padding: const EdgeInsets.only(left: 28.0,right: 28.0,top: 9.0),
                          child: Text(message,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontFamily: 'AvertaFont',
                                  color: TulongeSurfaceWhite,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: new EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    border: new Border(
                                      right: new BorderSide(
                                          color: TulongeGray, width: 1.0),
                                      top: new BorderSide(
                                          color: TulongeGray, width: 2.0),
                                    ),
                                  ),
                                  child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.cancel,
                                          color: TulongeGray,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontFamily: 'AvertaFont',
                                              color: TulongeGray,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 19.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              onOK == null
                                  ? SizedBox(
                                height: 0.0,
                              )
                                  : Expanded(
                                child: Container(
                                  padding: new EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    border: new Border(
                                      left: new BorderSide(
                                          color: TulongeGray,
                                          width: 1.0),
                                      top: new BorderSide(
                                          color: TulongeGray,
                                          width: 2.0),
                                    ),
                                  ),
                                  child: FlatButton(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: TulongeSurfaceWhite,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          "Confirm",
                                          style: TextStyle(
                                              fontFamily: 'AvertaFont',
                                              color:
                                              TulongeSurfaceWhite,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onOK();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ))),
        );
      });
}

class MessageConfig {
  final Color backgroundColor;
  final Icon icon;

  const MessageConfig({this.backgroundColor, this.icon});
}

class Message extends StatelessWidget {
  const Message({Key key, this.type, this.title, this.message, this.details})
      : super(key: key);

  final String type;
  final String title;
  final String message;
  final String details;

  static get INFO => "INFO";
  static const Map<String, MessageConfig> _messageConfigs = {
    "INFO": const MessageConfig(
        backgroundColor: Colors.blueAccent, icon: Icon(Icons.info,color: Colors.white,)),
    "WARNING": const MessageConfig(
        backgroundColor: Colors.yellowAccent, icon: Icon(Icons.warning)),
    "ERROR": const MessageConfig(
        backgroundColor: Colors.redAccent, icon: Icon(Icons.error)),
    "SUCCESS": const MessageConfig(
        backgroundColor: Colors.greenAccent, icon: Icon(Icons.thumb_up)),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: _messageConfigs[type].backgroundColor,
        child: ListTile(
          leading: _messageConfigs[type].icon,
          title: new Text(title,style: TextStyle(color: Colors.white),),
          subtitle: new Text(message,style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
