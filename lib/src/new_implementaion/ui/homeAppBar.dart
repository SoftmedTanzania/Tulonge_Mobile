import 'dart:async';

import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/ui/shared/custom_mat_color.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'bottom_gradient.dart';

class HomeAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final double _appBarHeight = 240.0;
    return SliverAppBar(
      backgroundColor: const Color(0xFFB96B40),
      expandedHeight: _appBarHeight,
      pinned: true,
//      actions: <Widget>[
//        IconButton(
//          icon: const Icon(Icons.create),
//          tooltip: 'Edit',
//          onPressed: () {
//
//          },
//        ),
//      ],
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
                      crossAxisAlignment: CrossAxisAlignment
                          .start,
                      children: <Widget>[
                        Text('Tulonge Afya',
                          style: const TextStyle(
                            //fontWeight:FontWeight.bold,
                            fontSize: 25.0,
                            color: Colors.white,
                            fontFamily: 'AvertaFont',
                          ),
                        ),
                        Text(
                          '${model.user.name}',
                          style: const TextStyle(
                            //fontWeight:FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white
                          ),
                        ),
                        Text('${model.user.phoneNumber}',
                          style: const TextStyle(
                            //fontWeight:FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          "${model.user.regionName} -> ${model.user.districtName} -> ${model.user.wardName}",
                          style: const TextStyle(
                            //fontWeight:FontWeight.bold,
                              fontSize: 11.0,
                              color: Colors.white
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(icon: Icon(
                  Icons.person_outline, size: 30.0,
                  color: Colors.white,), onPressed: () {

                })
            ),
          ],
        ),
      ),
    );

//    return SliverAppBar(
//      expandedHeight: 200.0,
//      floating: false,
//      pinned: true,
//      forceElevated: false,
//      backgroundColor: Colors.blueAccent,
//      flexibleSpace: FlexibleSpaceBar(
//        centerTitle: true,
////                      Image.asset('assets/banner.jpg',width:width ,)
//        background: Stack(
//          children: <Widget>[
//            Positioned.fill(
//              child: Hero(
//                  tag: 'title',
//                  child: Stack(children: <Widget>[
//                    Container(
//                      decoration: BoxDecoration(
//                        color: Colors.transparent,
//                        image: DecorationImage(
//                          fit: BoxFit.fill,
//                          image: AssetImage(
//                            'assets/sitetereki.jpg',
//                          ),
//                        ),
//                      ),
//                      height: 350.0,
//                    ),
//                    Container(
//                      height: 350.0,
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          gradient: LinearGradient(
//                              begin: FractionalOffset.topCenter,
//                              end: FractionalOffset.bottomCenter,
//                              colors: [
//                                Colors.grey.withOpacity(0.0),
//                                customColor.withOpacity(0.8),
//                              ],
//                              stops: [
//                                0.0,
//                                1.0
//                              ])),
//                    ),
//                  ])),
//            )
//          ],
//        ),
//        title: Container(
//            alignment: Alignment.bottomCenter,
//            padding: EdgeInsets.only(top: 25.0),
//            child: Row(
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                Container(
//                  child: Image.asset(
//                    'assets/logo1.png',
//                    width: 100.0,
//                  ),
//                  padding:
//                  EdgeInsets.only(left: 80.0, right: 10.0),
//                ),
//                Text("TULONGE AFYA", style: TextStyle(fontSize: 14.0, fontFamily: 'AvertaFont'),)
//              ],
//            )),
//      ),
//    );
  }
}
