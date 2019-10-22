import 'package:flutter/material.dart';

Widget appBar(bool isMainPage, String title, String pageTitle) {
  return isMainPage == true
      ? AppBar(
          title: Row(
            children: <Widget>[
              Container(
                child: Image.asset('assets/logo1.png'),
                padding: EdgeInsets.all(10.0),
              ),
              Text(title)
            ],
          ),
          actions: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ])
      : AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(pageTitle),
              )
            ],
          ),
          actions: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ]);
}
