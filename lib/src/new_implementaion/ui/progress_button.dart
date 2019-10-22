import 'package:flutter/material.dart';
import 'dart:async';

class ProgressButton extends StatefulWidget {
  final Function callback;
  final bool success;
  final bool loading;
  final String title;

  ProgressButton({this.callback, this.success = false, this.loading = false, this.title = "SUBMIT"});

  @override
  State<StatefulWidget> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  bool _isPressed = false, _animatingReveal = false;
  int _state = 0;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();
  AnimationController _controller;

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.blue,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: 45.0,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: widget.success ? Colors.green : Colors.blue,
            child: buildButtonChild(),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            onPressed: widget.callback,
            onHighlightChanged: (isPressed) {
              setState(() {
                _isPressed = isPressed;
                if (widget.loading) {
                  animateButton();
                }
              });
            },
          ),
        ));
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 45.0) * _animation.value);
          print(_width);
        });
      });
    _controller.forward();

  }

  Widget buildButtonChild() {
    if (!widget.loading && !widget.success) {
      return Text(
        widget.title,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      );
    } else if (widget.loading && !widget.success) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  double calculateElevation() {
    if (_animatingReveal) {
      return 0.0;
    } else {
      return _isPressed ? 6.0 : 4.0;
    }
  }

  void reset() {
    _width = double.infinity;
    _animatingReveal = false;
  }
}