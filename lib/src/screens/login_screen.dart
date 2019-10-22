import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/networ_layer/app_provider.dart';
import 'package:chw/src/resources/networ_layer/authentication_provider.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  AuthenticationProvider appProvider = new AuthenticationProvider();

  @override
  LoginScreenState createState() => new LoginScreenState(appProvider);
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading;
  AuthenticationProvider appProvider;

  LoginScreenState(this.appProvider);

  // Keys
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Controllers
  AnimationController _loginButtonController;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Animation handler
  Animation buttonSqueezeAnimation;

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

    isLoading = false;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    buttonSqueezeAnimation = new Tween(
      begin: 480.0,
      end: 70.0,
    ).animate(new CurvedAnimation(
        parent: _loginButtonController, curve: new Interval(0.0, 0.250)));
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    _scaffoldKey.currentState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // Redirect is user previously never loged in
    checkIfUserLoggedIn(context);
    final logoTop = Hero(
      tag: 'login_form',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 36.0,
        child: Image.asset('assets/logo1.png'),
      ),
    );

    final logoBottom = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24.0,
        child: Image.asset('assets/usaid.png'),
      ),
    );

    final username = TextFormField(
      controller: _usernameController,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Username';
        }
      },
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: true,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
        }
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logoTop,
              SizedBox(height: 96.0),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      username,
                      SizedBox(height: 8.0),
                      password,
                      SizedBox(height: 24.0),
                      GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => isLoading = true);
                              var username = _usernameController.text;
                              var password = _passwordController.text;
                              try {
                                var userLoginStatus =
                                    await appProvider.login(username, password);

                                if (userLoginStatus == true) {
                                  Navigator.pushNamed(context, '/sessions');
                                  setState(() => isLoading = false);
                                } else {
                                  setState(() => isLoading = false);
                                  _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(USER_NOT_CSO_MESSAGE));
                                }
                              } catch (e) {
                                setState(() => isLoading = false);
                                if (e.message == 'USER_NOT_CSO') {
                                  _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(USER_NOT_CSO_MESSAGE));
                                } else if (e.message == 'NOT_AUTHENTICATED') {
                                  _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(
                                          NOT_AUTHENTICATED_MESSAGE));
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(
                                          SMTH_WENT_WRONG_MESSAGE));
                                }
                              }
                            }
                          },
                          child: Container(
                            width: buttonSqueezeAnimation.value,
                            height: 60.0,
                            alignment: FractionalOffset.center,
                            decoration: new BoxDecoration(
                              color: const Color.fromRGBO(244, 115, 34, 1),
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(30.0)),
                            ),
                            child: isLoading == false
                                ? new Text(
                                    "Sign In",
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.3,
                                    ),
                                  )
                                : new CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                          )),
                      loginStateRenderer("", ""),
                    ]),
              ),
              SizedBox(height: 98.0),
              logoBottom
            ],
          ),
        ),
      ),
    );
  }
}

Widget loginButton(
  BuildContext context,
  _formKey,
  _scaffoldKey,
  _usernameController,
  _passwordController,
  buttonSqueezeAnimation,
  AppProvider appProvider,
  bool isLoading,
) {
  return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          _scaffoldKey
              .setState(() => _scaffoldKey.currentState.isLoading = true);
          var username = _usernameController.text;
          var password = _passwordController.text;
          var userLoginStatus = await appProvider.login(username, password);

          if (userLoginStatus == true) {
            Navigator.pushNamed(context, '/sessions');
          } else {
            _scaffoldKey.currentState
                .showSnackBar(showSnackBarCustom(NOT_AUTHENTICATED_MESSAGE));
          }
        }
      },
      child: Container(
        width: buttonSqueezeAnimation.value,
        height: 60.0,
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: const Color.fromRGBO(244, 115, 34, 1),
          borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
        ),
        child: isLoading == false
            ? new Text(
                "Sign In",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                ),
              )
            : new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ));
}

loginStateRenderer(loginState, loginMessage) {
  var container = Container();
  switch (loginState) {
    case initial:
      {
        container = Container();
      }
      break;

    case loginSuccess:
      {
        // statements;
      }
      break;

    case loginProgress:
      {
        //statements;
      }
      break;
    case loginFailed:
      {
        //statements;
      }
      break;

    default:
      {
        //statements;
      }
      break;
  }
  return container;
}

showSnackBarCustom(message) {
  return SnackBar(
      content: Container(
    child: Row(
      children: <Widget>[Icon(Icons.warning), Text(message)],
    ),
  ));
}

showSnackBarMessage(context, message) {
  Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(
    child: Row(
      children: <Widget>[Text("${message}")],
    ),
  )));
}

checkIfUserLoggedIn(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  var user = prefs.get('currentUser');
  user == null
      ? print('not loggen in')
      : Navigator.pushNamed(context, '/sessions');
}
