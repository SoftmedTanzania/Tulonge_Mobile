import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chw/src/new_implementaion/ui/bottom_gradient.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class SessionAppBar extends StatelessWidget {

  final double _appBarHeight = 170.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFFB96B40),
      expandedHeight: _appBarHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "groupInfo",
              child: Image.asset(
                'assets/banner.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: _appBarHeight,
                alignment: Alignment.topCenter,
              ),
            ),
            BottomGradient(),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: ScopedModelDescendant<MainModel>(
                    builder: (context, child, model) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${model.selectedIpc.eventNumber}',
                            style: const TextStyle(
                              //fontWeight:FontWeight.bold,
                              fontSize: 21.0,
                              color: Colors.white,
                              fontFamily: 'AvertaFont',
                            ),
                          ),
                          Text(
                            '${model.selectedIpc.eventPlace}',
                            style: const TextStyle(
                              //fontWeight:FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          Text(
                            '${DateFormat.yMMMd().format(DateTime.parse(model.selectedIpc.created))}',
                            style: const TextStyle(
                              //fontWeight:FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          Text(
                            'Washiriki ${model.getNumberOfParticipant(model.selectedIpc)}, Vipindi ${model.getNumberOfSessions(model.selectedIpc)} ',
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          Text(
                            'Imetumia ${model.selectedIpc.trainingItemUsed}',
                            style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
