import 'dart:convert';

import 'package:chw/src/new_implementaion/models/user_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer();

  @override
  Widget build(BuildContext context) {
//    final bloc = Provider.of(context);
//    bloc.getCurrentUser();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        // Important: Remove any padding from the ListView.
        children: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (context, child, MainModel model) {
            return customAccountDrawerHeader(model.user);
          }),
          ListTile(
            title: Text(
              'My Sessions',
              style: TextStyle(
                fontFamily: 'AvertaFont',
              ),
            ),
            subtitle: Text(
              'Angalia Session zako',
              style: TextStyle(fontSize: 10.0),
            ),
            leading: Container(
              child: Image.asset('assets/ipc.png'),
              width: 25.0,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/sessions');
            },
          ),
          ListTile(
            title: Text(
              'Vijiji/Mtaa',
              style: TextStyle(
                fontFamily: 'AvertaFont',
              ),
            ),
            subtitle: Text(
              'Taarifa za maeneo ya kazi',
              style: TextStyle(fontSize: 10.0),
            ),
            leading: Container(
              child: Image.asset('assets/village.png'),
              width: 25.0,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/villages');
            },
          ),
//          ListTile(
//            title: Text('e-Learning', style: TextStyle(fontFamily: 'AvertaFont',)),
//            leading: Container(
//              child: Image.asset('assets/e-learning.png'),
//              width: 25.0,
//            ),
//            onTap: () {
//              Navigator.pushNamed(context, '/e_learning');
//            },
//          ),
          Expanded(
            child: SizedBox(),
          ),
          Divider(
            height: 15.0,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Logout',
                style: TextStyle(
                  fontFamily: 'AvertaFont',
                )),
            leading: Container(
              child: Image.asset('assets/lock.png'),
              width: 25.0,
            ),
            onTap: () async {
              var model =
                  ScopedModel.of<MainModel>(context, rebuildOnChange: false);
              model.logOut();
            },
          ),
        ],
      ),
    );
  }
}

Widget customAccountDrawerHeader(User user) {
  return UserAccountsDrawerHeader(
    accountEmail: Text('${user.phoneNumber}',
        style: TextStyle(
            fontFamily: 'AvertaFont',
            fontWeight: FontWeight.w400,
            color: Colors.white70)),
    accountName: Text('${user.name}',
        style: TextStyle(
            fontFamily: 'AvertaFont',
            fontWeight: FontWeight.bold,
            color: Colors.white70)),
    currentAccountPicture: GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/user.png'),
      ),
      onTap: () => {},
    ),
    decoration: BoxDecoration(
//      image: DecorationImage(
//          image: NetworkImage(
//              "https://firebasestorage.googleapis.com/v0/b/tulonge-32c1c.appspot.com/o/questions-to-ask-when-buying-or-renewing-health-insurance.png?alt=media&token=5372c7f9-f1c1-471a-b219-e944e3a29c11"),
//          fit: BoxFit.fill),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        // 10% of the width, so there are ten blinds.
        colors: [Colors.black, Colors.transparent],
        // whitish to gray
        tileMode: TileMode.repeated, // repeats the gradient over the canvas
      ),
    ),
  );
}

getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();

  var user = jsonDecode(prefs.getString('currentUser'));
  return user;
}
