import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/models/session.dart';
import '../../ui/forms/basic_information.dart';
import '../../ui/forms/education.dart';
import '../../ui/shared/page_scaffold.dart';

class SessionManager extends StatefulWidget {
  Session session;
  String reference;
  SessionManager({this.session, this.reference});
  @override
  State<StatefulWidget> createState() {
    return SessionManagerState(session: this.session, reference: this.reference);
  }
}

class SessionManagerState extends State<SessionManager>
    with SingleTickerProviderStateMixin {
  Session session;
  String reference;
  SessionManagerState({this.session, this.reference});
  TabController _tabController;

  final List<Tab> formSectionTabs = <Tab>[
    Tab(
      child: Text(
        'Taarifa Muhimu',
        style: TextStyle(color: Colors.black, fontSize: 12.0),
      ),
    ),
    Tab(
      child: Text(
        'Elimu',
        style: TextStyle(color: Colors.black, fontSize: 12.0),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: formSectionTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    configureEducation();
    setState(() {
      _tabController
        ..addListener(() {
          if (_tabController.index != null &&
              _tabController.index == formSectionTabs.length - 1) {} else {}
        });
    });

    final body = Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: formSectionTabs,
            controller: _tabController,
          ),
          Container(
            height: height,
            child: TabBarView(controller: _tabController, children: <Widget>[
              BasicInformation(this.session, this.reference),
              Education(this.session, this.reference),
            ]),
          ),
        ],
      ),
    );

    return PageScaffold(
        false, 'TULONGE AFYA', 'Session Mpya', null, body, false, () {}, false);
  }
}

configureEducation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
}