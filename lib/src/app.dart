import 'package:flutter/material.dart';
import 'package:chw/src/resources/data_layer/provider.dart';
import 'package:chw/src/screens/session/mazoezi_manager.dart';
import 'package:chw/src/screens/session/members_manager.dart';
import 'package:chw/src/screens/session/session_manager.dart';
import 'package:chw/src/screens/login_screen.dart';
import 'package:chw/src/screens/material_screen.dart';
import 'package:chw/src/screens/session/session_mazoezi_screen.dart';
import 'package:chw/src/screens/session/session_participants_screen.dart';
import 'package:chw/src/screens/session/session_screen.dart';
import 'package:chw/src/ui/shared/custom_mat_color.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/sessions': (context) => Provider(child: SessionScreen()),
          '/sessions_members': (context) => Provider(child: SessionParticipantsScreen(reference: null),),
          '/member_manager': (context) => Provider(child: MemberManagerScreen(reference: null)),
          '/sessions_mazoezi': (context) => Provider(child:SessionMazoeziScreen()),
          '/mazoezi_manager': (context) => Provider(child:MazoeziManagerScreen()),
          '/new_session': (context) => Provider(child: SessionManager()),
          '/materials': (context) => MaterialScreen(),
        },
        title: 'TULONGE AFYA',
        theme: ThemeData(primarySwatch: customColor, fontFamily: 'Roboto'));
  }
}
