import 'package:chw/src/new_implementaion/models/ipc_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/detail_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SingleSessionCard extends StatelessWidget {
  final Ipc ipc;
  final MainModel model;
  final bool horizontal;

  SingleSessionCard(this.ipc, this.model, {this.horizontal = true});

  SingleSessionCard.vertical(this.ipc, this.model) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Container(),
    );

    final TextStyle textStyle = TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black54.withOpacity(0.5));
    return new GestureDetector(
      onTap: horizontal
          ? () {
              model.setSelectedIPc(ipc);
              return Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new DetailPage(ipc),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          new FadeTransition(opacity: animation, child: child),
                ),
              );
            }
          : null,
      child: Padding(
        padding: EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(19.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: Offset(1, 1),
                blurRadius: 19,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0.0),
              leading: Hero(
                tag: "planet-hero-${ipc.id}",
                child: Image.asset(
                  'assets/download.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
              title: Hero(
                tag: "planet-number-${ipc.id}",
                child: Row(
                  children: <Widget>[
                    Text(
                      '${ipc.eventNumber}',
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black),
                      overflow: TextOverflow.visible,
                    ),
                    if (ipc.isCompleted && ipc.isSynchronized)
                      SizedBox(
                        width: 10,
                      ),
                    if (ipc.isCompleted && ipc.isSynchronized)
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 16,
                      ),
                  ],
                ),
              ),
              subtitle: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${ipc.region} -> ${ipc.district} -> ${ipc.ward}',
                      style: textStyle,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      '${ipc.eventPlace} (${ipc.created.substring(0, 10)})',
                      style: textStyle,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      '${ipc.getEducationProvided()} (${ipc.trainingItemUsed})',
                      style: textStyle,
                    ),
//                    Text(
//                      '${ipc.trainingItemUsed}',
//                      style: textStyle,
//                      overflow: TextOverflow.visible,
//                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (context, child, model) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  'Washiriki (${model.getNumberOfParticipant(ipc)})'),
                              SizedBox(
                                width: 18.0,
                              ),
                              Text(
                                  'Vipindi (${model.getNumberOfSessions(ipc)})')
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
