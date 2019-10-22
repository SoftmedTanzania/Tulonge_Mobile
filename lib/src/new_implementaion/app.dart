import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/login.dart';
import 'package:chw/src/new_implementaion/screens/sessions.dart';
import 'package:chw/src/new_implementaion/screens/splash_screen.dart';
import 'package:chw/src/new_implementaion/screens/villages_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MainApp extends StatelessWidget {
  final MainModel model = MainModel();

  @override
  Widget build(BuildContext context) {
    model.initilizeUsers();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        title: 'Tulonge Afya',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'AvertaFont'),
        home: ScopedModelDescendant<MainModel>(
            builder: (context, child, MainModel modelData) {
          return buildHomePage(modelData);
        }),
        routes: {
          '/sessions': (context) => SessionScreen(),
          '/villages': (context) => VillageScreen(),
          '/login': (context) => LoginScreen()
        },
      ),
    );
  }

  Widget buildHomePage(MainModel modelData) {
    if (modelData.dataReady == false) {
      return SliderLoader();
//      return Text('Loading');
    } else {
      if (modelData.currentUser != null) {
        return SessionScreen();
      } else {
        return LoginScreen();
      }
    }
  }
}
