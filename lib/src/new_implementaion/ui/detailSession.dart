import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/members.dart';
import 'package:chw/src/new_implementaion/screens/zoezi_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailSessionSummary extends StatelessWidget {
  final Ipc ipc;
  final bool horizontal;

  DetailSessionSummary(this.ipc, {this.horizontal = true});

  DetailSessionSummary.vertical(this.ipc) : horizontal = false;

  getPadding() {
    return EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0);
  }

  getTextStyle() {
    return TextStyle(
        fontSize: 12.5, fontWeight: FontWeight.w200, color: Colors.black);
  }

  _actionButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, child, model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                model.setSelectedIPc(ipc);
                Navigator.of(context).push(
                  new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new MembersScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    new FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.people_outline,
                    size: 20.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Washiriki (${model.getNumberOfParticipant(ipc)})')
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green.shade900),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FlatButton(
              onPressed: () async {
                model.setSelectedIPc(ipc);
                Navigator.of(context).push(
                  new PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new ZoeziScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                    new FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assignment_ind,
                    size: 20.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Vipindi (${model.getNumberOfSessions(ipc)})')
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green.shade900),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        );
      },
    );
  }

  TableRow tableRow(String header, String content) {
    return TableRow(
      children: [
        Padding(
          padding: getPadding(),
          child: Text(header,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0,
                  color: Colors.black54)),
        ),
        Padding(
          padding: getPadding(),
          child: Text(
            content,
            style: getTextStyle(),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "planet-hero-${ipc.id}",
        child: CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage('assets/download.jpeg'),
        ),
      ),
    );



    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      child: Column(
        children: <Widget>[
          _actionButton(),
          Hero(
            tag: "planet-number-${ipc.id}",
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 5.0),
                child: Text(
                  '${ipc.eventNumber}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey),
                ),
              ),
            ),
          ),
//          ipc.created == '' ? Container() : Center(
//            child: Padding(
//              padding: const EdgeInsets.only(bottom: 12.0),
//              child: Text(
//                '${DateFormat.yMMMd().format(DateTime.parse(ipc.created))}',
//                style: TextStyle(
//                    fontSize: 15.0,
//                    fontWeight: FontWeight.w600,
//                    color: Colors.black54),
//              ),
//            ),
//          ),
          Table(
            columnWidths: {0: FractionColumnWidth(.3)},
            children: [
//              if (ipc.created != '')
                if (ipc.created != '') tableRow("Tarehe: ", '${DateFormat.yMMMd().format(DateTime.parse(ipc.created))}'),
//              tableRow("Form No: ", ipc.eventNumber),
              tableRow("Mwezeshaji: ", '${ipc.facilitatorName} ( ${ipc.facilitatorPhoneNumber} )'),
              tableRow("Asasi: ", ipc.csoName),
              tableRow("Eneo: ", "${ipc.region} -> ${ipc.district} -> ${ipc.ward}"),
              tableRow("Kijiji/Mtaa: ", ipc.eventPlace),
              tableRow("GPS: ", "${ipc.gpsToolUsed} ( ${ipc.gpsCordinatorE},  ${ipc.gpsCordinateS} )"),
              tableRow("Aina: ", ipc.startTime),
              tableRow("Kundi: ", '${ipc.materialUsed}'),
              tableRow("Walengwa: ", '${ipc.targets}'),
              tableRow("Elimu: ", '${ipc.getEducationProvidedDetailed()}'),
              tableRow("Kutumia: ", '${ipc.trainingItemUsed}'),
              tableRow("Nyenzo: ", '${ipc.getEducationToolsDetailed()}'),
              tableRow("Kusanyiko: ", '${ipc.groupCrowdEducated} '),
              if (ipc.groupCrowdEducated == '2A-Matembezi ya nyumba kwa nyumba')
                tableRow("Kaya: ", '${ipc.households}'),
              if (ipc.groupCrowdEducated == '2A-Matembezi ya nyumba kwa nyumba')
                tableRow("Kaya: ", '${DateFormat.yMMMd().format(DateTime.parse(ipc.created))}'),
              tableRow("VEO/WEO: ", '${ipc.communityLeaderName} ( ${ipc.communityLeaderPhone} )'),
            ],
          ),
//          _actionButton(),
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
//      height: MediaQuery.of(context).size.height,
      margin: horizontal
          ? new EdgeInsets.only(left: 16.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 14.0,
      ),
      child: new Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }
}
