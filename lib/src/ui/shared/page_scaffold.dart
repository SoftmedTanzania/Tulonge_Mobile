import 'package:flutter/material.dart';
import 'package:chw/src/ui/shared/custom_mat_color.dart';
import '../shared/app_bar.dart';
import '../shared/app_drawer.dart';

class PageScaffold extends StatelessWidget {
  String titleBar;
  String pageTitle;
  Widget iconCustom;
  Widget customBody;
  bool hasFloatingAction;
  Function floatingAction;
  bool useSilver;
  bool isMainPage;

  PageScaffold(
      this.isMainPage,
      this.titleBar,
      this.pageTitle,
      this.iconCustom,
      this.customBody,
      this.hasFloatingAction,
      this.floatingAction,
      this.useSilver);

  @override
  Widget build(BuildContext context) {
    return !useSilver || useSilver == null
        ? Scaffold(
            appBar: appBar(this.isMainPage, titleBar, pageTitle),
            drawer: isMainPage ? AppDrawer() : null,
            floatingActionButton: hasFloatingAction
                ? FloatingActionButton(
                    onPressed: floatingAction,
                    child: Icon(Icons.add),
                  )
                : null,
            body: Center(
              child: Container(
                child: ListView(
                  children: <Widget>[customBody],
                ),
              ),
            ),
          )
        : Scaffold(
//      appBar: appBar(titleBar),
            drawer: isMainPage ? AppDrawer() : null,
            floatingActionButton: hasFloatingAction
                ? FloatingActionButton(
                    onPressed: floatingAction,
                    child: Icon(Icons.add),
                  )
                : null,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                double width = MediaQuery.of(context).size.width;
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    forceElevated: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
//                      Image.asset('assets/banner.jpg',width:width ,)
                      background: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Hero(
                                tag: 'title',
                                child: Stack(children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          'assets/banner.jpg',
                                        ),
                                      ),
                                    ),
                                    height: 350.0,
                                  ),
                                  Container(
                                    height: 350.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        gradient: LinearGradient(
                                            begin: FractionalOffset.topCenter,
                                            end: FractionalOffset.bottomCenter,
                                            colors: [
                                              Colors.grey.withOpacity(0.0),
                                              customColor.withOpacity(0.8),
                                            ],
                                            stops: [
                                              0.0,
                                              1.0
                                            ])),
                                  ),
                                ])),
                          )
                        ],
                      ),
                      title: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(top: 25.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Image.asset(
                                  'assets/logo1.png',
                                  width: 100.0,
                                ),
                                padding:
                                    EdgeInsets.only(left: 80.0, right: 10.0),
                              ),
                              Text(titleBar)
                            ],
                          )),
                    ),
                  ),
                ];
              },
              body: Center(
                child: Container(
                  child: ListView(
                    padding: EdgeInsets.only(top: 0.0),
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 0.0),
                        padding: EdgeInsets.only(left: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: iconCustom,
                              padding: EdgeInsets.only(right: 10.0),
                            ),
                            Text(
                              pageTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Container(),
                      customBody
                    ],
                  ),
                ),
              ),
            ));
  }
}
