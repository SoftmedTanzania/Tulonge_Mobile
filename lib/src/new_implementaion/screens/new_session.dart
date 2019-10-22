import 'dart:async';
import 'dart:io';

import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/forms/basic_information.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';

import 'forms/education.dart';

class NewSession extends StatefulWidget {
  @override
  _NewSessionState createState() => _NewSessionState();
}

class _NewSessionState extends State<NewSession>
    with SingleTickerProviderStateMixin  {

  StreamSubscription<LocationData> _locationSub;
  Map<String, double> currentLocation;
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
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    final model = ScopedModel.of<MainModel>(context, rebuildOnChange: false);
    model.getDeviceName();
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFB96B40),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Taarifa Za Awali',icon: Icon(Icons.table_chart,)),
//              Tab(text: 'Walengwa',icon: Icon(Icons.directions_transit)),
              Tab(text: 'Elimu',icon: Icon(Icons.library_books)),
            ],
          ),
          title: const Text('New Session'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.translucent,
          child: TabBarView(
            controller: _tabController,
            children: [
              BasicInformation(goNextPage: () => _tabController.animateTo(1)),
              Education(),
//            Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );

  }
}
