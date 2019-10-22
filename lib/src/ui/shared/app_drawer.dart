import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer();

  String defaultProfilePic =
      "https://firebasestorage.googleapis.com/v0/b/tulonge-32c1c.appspot.com/o/avatar.png?alt=media&token=0af018de-e9d1-40e6-ad0a-3df4b73efc1c";

  @override
  Widget build(BuildContext context) {
//    final bloc = Provider.of(context);
//    bloc.getCurrentUser();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder(
              future: getCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return customAccountDrawerHeader(
                      snapshot.data, defaultProfilePic);
                } else {
                  return customAccountDrawerHeader(null, defaultProfilePic);
                }
              }),
          ListTile(
            title: Text('My Sessions'),
            leading: Container(
              child: Image.asset('assets/ipc.png'),
              width: 25.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/sessions');
            },
          ),
          ListTile(
            title: Text('e-Learning'),
            leading: Container(
              child: Image.asset('assets/e-learning.png'),
              width: 25.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/e_learning');
            },
          ),
          Divider(
            height: 15.0,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Container(
              child: Image.asset('assets/lock.png'),
              width: 25.0,
            ),
            onTap: () async {
//              final provider = DhisApiProvider();
//              var token = await provider.removeToken();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

Widget customAccountDrawerHeader(data, currentProfilePic) {
  return UserAccountsDrawerHeader(
    accountEmail: null,
    accountName: Text(data != null ? '${data['name']}' : '',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    currentAccountPicture: GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentProfilePic),
      ),
      onTap: () => {},
    ),
    decoration: BoxDecoration(
//      image: DecorationImage(
//          image: NetworkImage(
//              "https://firebasestorage.googleapis.com/v0/b/tulonge-32c1c.appspot.com/o/questions-to-ask-when-buying-or-renewing-health-insurance.png?alt=media&token=5372c7f9-f1c1-471a-b219-e944e3a29c11"),
//          fit: BoxFit.fill),
//      gradient: LinearGradient(
//        begin: Alignment.bottomCenter,
//        end: Alignment.topCenter,
//        // 10% of the width, so there are ten blinds.
//        colors: [Colors.black, Colors.transparent],
//        // whitish to gray
//        tileMode: TileMode.repeated, // repeats the gradient over the canvas
//      ),
    ),
  );
}

getCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();

  var user = jsonDecode(prefs.getString('currentUser'));
  return user;
}
