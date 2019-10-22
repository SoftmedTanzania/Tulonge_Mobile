import 'dart:async';

import 'package:chw/src/new_implementaion/database/database_helper.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/new_session.dart';
import 'package:chw/src/new_implementaion/ui/app_drawer.dart';
import 'package:chw/src/new_implementaion/ui/homeAppBar.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/singleSessionCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SessionScreen extends StatelessWidget {
  _navigateToNew(MainModel model, BuildContext context) {
    model.initilizeIpc();
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new NewSession(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model) {
        return Scaffold(
          drawer: AppDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _navigateToNew(model, context);
            },
            child: Icon(Icons.add),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await model.getUpdates();
              await Future.delayed(const Duration(seconds: 1));
//                  return null;
            },
            child: SafeArea(
              child: Container(
                child: CustomScrollView(
                  slivers: <Widget>[
                    HomeAppBar(),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: SyncData(),
                        )
                      ]),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        model.geIpcs
                            .map((ipc) => SingleSessionCard(ipc, model))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SyncData extends StatefulWidget {
  @override
  _SyncDataState createState() => _SyncDataState();
}

class _SyncDataState extends State<SyncData> {
  bool isSyncing;
  bool synced;

  @override
  void initState() {
    isSyncing = false;
    synced = false;
    super.initState();
  }

  _navigateToNew(MainModel model, BuildContext context) {
    model.initilizeIpc();
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new NewSession(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Column(
          children: <Widget>[
            model.geIpcs.length == 0
                ? Container(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Hakuna Session Iliyofanyika'),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton.icon(
                            onPressed: () => _navigateToNew(model, context),
                            icon: Icon(Icons.add),
                            label: Text('Tengeneza Session'),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.lightBlueAccent,
                                ),
                                borderRadius: BorderRadius.circular(18)),
                          )
                        ],
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (isSyncing) Text('Tunatuma Taarifa...'),
                      if (!isSyncing && model.numberOfUnsyncedSessions > 1)
                        Text(
                            'Kuna Taarifa ${model.numberOfUnsyncedSessions} za Kutuma'),
                      if (!isSyncing && model.numberOfUnsyncedSessions == 1)
                        Text(
                            'Kuna Taarifa ${model.numberOfUnsyncedSessions} ya Kutuma'),
                      if (!isSyncing && model.numberOfUnsyncedSessions == 0)
                        Text('Hakuna Taarifa Ya Kutuma'),
                      IconButton(
                        onPressed: model.numberOfUnsyncedSessions == 0
                            ? null
                            : () {
                                confirmSubmission(context,
                                    'Taarifa zitatumwa kwaajili ya uhakiki',
                                    onOK: () async {
                                  setState(() => isSyncing = !isSyncing);
                                  bool internetAvailable = await checkNetwork();
                                  if (internetAvailable) {
                                    setState(() => isSyncing = !isSyncing);
                                    try {
                                      await model.sendSession();
                                      showMessage(
                                        context,
                                        'SUCCESS',
                                        'Taarifa Zimetumwa kikamilifu',
                                        () {},
                                      );
                                    } catch (e) {
                                      showMessage(
                                        context,
                                        'ERROR',
                                        'Taarifa Hazitumwa kikamilifu',
                                        () {},
                                      );
                                    }

                                    setState(() {
                                      isSyncing = !isSyncing;
                                      synced = true;
                                      Timer(Duration(milliseconds: 1500), () {
                                        setState(() {
                                          synced = false;
                                        });
                                      });
                                    });
                                  } else {
                                    setState(() => isSyncing = !isSyncing);
                                    showMessage(
                                        context,
                                        'NETWORK',
                                        "Hakuna intenet Kwenye Kifaa chako.",
                                        () {});
                                  }
                                });
                              },
                        icon: isSyncing
                            ? CircularProgressIndicator()
                            : !synced
                                ? model.numberOfUnsyncedSessions == 0
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(Icons.sync)
                                : Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                      )
                    ],
                  ),
          ],
        );
      },
    );
  }
}
