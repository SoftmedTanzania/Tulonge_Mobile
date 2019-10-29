import 'package:chw/src/new_implementaion/api_provider.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/resources/constants.dart';
import 'package:chw/src/resources/networ_layer/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  ApiProvider appProvider = new ApiProvider();

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading;
  bool successfull;
  ApiProvider appProvider;
  bool _obscureText;

  LoginScreenState();

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
    successfull = false;
    _obscureText = true;

    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    buttonSqueezeAnimation = new Tween(
      begin: 480.0,
      end: 70.0,
    ).animate(new CurvedAnimation(
        parent: _loginButtonController, curve: new Interval(0.0, 0.250)));
    var model = ScopedModel.of<MainModel>(context, rebuildOnChange: false);
    model.setIsLoading(false);
    model.setIsSuccessful(false);
  }

  @override
  void dispose() {
    if (_loginButtonController != null) {
      _loginButtonController.dispose();
    }
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    // Redirect is user previously never loged in
    final logoTop = Hero(
      tag: 'login_form',
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30.0,
          child: Image.asset('assets/logo1.png'),
        ),
      ),
    );

    final logoBottom = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 18.0,
        child: Image.asset('assets/usaid.png'),
      ),
    );

    final services = Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black12, width: 1)),
                width: 110,
                child: Image.asset(
                  'assets/furaha_yangu.png',
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.black12, width: 1)),
                width: 110,
                child: Image.asset('assets/naweza_logo.png'),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black12, width: 1)),
            width: 120,
            child: Image.asset('assets/sitetereki_logo.png'),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'TULONGE AFYA',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );

    final username = TextFormField(
      controller: _usernameController,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Username';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: _passwordController,
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
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
              services,
//              logoTop,
              SizedBox(height: 26.0),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      username,
                      SizedBox(height: 14.0),
                      password,
                      SizedBox(height: 24.0),
                      ScopedModelDescendant<MainModel>(
                          builder: (context, child, MainModel model) {
                        return GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                model.setIsLoading(true);
                                var username = _usernameController.text;
                                var password = _passwordController.text;

                                try {
                                  var userLoginStatus = await widget.appProvider
                                      .userLogin(username, password);
                                  model.setIsLoading(false);
                                  model.setIsSuccessful(true);
                                  model.initiateUser(userLoginStatus);
                                } catch (e) {
                                  print(e.message);
                                  model.setIsLoading(false);
                                  if (e.message == 'USER_NOT_CSO') {
                                    _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(USER_NOT_CSO_MESSAGE),
                                    );
                                  } else if (e.message == 'NOT_AUTHENTICATED') {
                                    _scaffoldKey.currentState.showSnackBar(
                                        showSnackBarCustom(
                                            NOT_AUTHENTICATED_MESSAGE));
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                      showSnackBarCustom(
                                          SMTH_WENT_WRONG_MESSAGE),
                                    );
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: buttonSqueezeAnimation.value,
                              height: 60.0,
                              alignment: FractionalOffset.center,
                              decoration: new BoxDecoration(
                                color: model.successful
                                    ? Colors.green
                                    : const Color.fromRGBO(244, 115, 34, 1),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(30.0)),
                              ),
                              child: model.isLoading == false
                                  ? model.successful
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Text(
                                          "Sign In",
                                          style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.3,
                                          ),
                                        )
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                            ));
                      }),
                      loginStateRenderer("", ""),
                    ]),
              ),
              SizedBox(height: 98.0),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          Icons.warning,
          color: Colors.orangeAccent,
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
            child: Text(
          message,
          style: TextStyle(fontFamily: 'AvertaFont', fontSize: 15.0),
        ))
      ],
    ),
  ));
}

showSnackBarMessage(context, message) {
  Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(
    child: Text("${message}"),
  )));
}
