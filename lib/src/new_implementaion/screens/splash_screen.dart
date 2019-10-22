import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({ Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}


class SliderLoader extends StatefulWidget {
  @override
  _SliderTestState createState() => _SliderTestState();
}

class _SliderTestState extends State<SliderLoader> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller1;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideAnimation1;

  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _slideAnimation =
        Tween<Offset>(begin: Offset(-0.5, -2.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller1, curve: Curves.fastOutSlowIn),
        );
    _slideAnimation1 = Tween<Offset>(
      begin: Offset(0.0, -1.5),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
    _controller.forward();
    _controller1.forward();
    super.initState();
  }

  dispose() {
    _controller.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: new FadeTransition(
              opacity: CurvedAnimation(parent: _controller1, curve: Curves.easeIn),
              child: Image.asset(
                "assets/bg.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Center(
            child: SlideTransition(
              position: _slideAnimation1,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/logo1.png',
                    height: 72.0,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Tulonge Afya',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontFamily: 'Monospace'),
                      )
                    ],
                  ),
                  SizedBox( height: 10.0, ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "----",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontFamily: 'AvertaFont'),
                      ),
                    ],
                  ),
                  SizedBox( height: 15.0, ),
                  CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
