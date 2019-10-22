import 'package:flutter/material.dart';
import 'package:chw/src/models/participant.dart';

class ParticipantCard extends StatelessWidget {
  ParticipantModel participant;

  ParticipantCard(this.participant);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        width: deviceWidth,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Jina: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(participant.name),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(participant.phone_number),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "Jinsi: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(participant.gender),
                    Text(","),
                    Text(
                      "  Umri: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(participant.age),
                    Text(","),
                    Text(
                      "  Hari ya ndoa: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(participant.marital_status),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
