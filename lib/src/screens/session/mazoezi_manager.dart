import 'package:flutter/material.dart';
import 'package:chw/src/models/card_game_model.dart';
import 'package:chw/src/ui/forms/kadi_game.dart';
import '../../ui/forms/basic_information.dart';
import '../../ui/forms/education.dart';
import '../../ui/forms/intended_group.dart';
import '../../ui/shared/page_scaffold.dart';

class MazoeziManagerScreen extends StatefulWidget {
  String reference;
  CardGameModel mazoezi;

  MazoeziManagerScreen({this.reference, this.mazoezi});

  @override
  State<StatefulWidget> createState() {
    return MazoeziManagerScreenState(reference: reference, mazoezi: mazoezi);
  }
}

class MazoeziManagerScreenState extends State<MazoeziManagerScreen>
    with SingleTickerProviderStateMixin {
  String reference;
  CardGameModel mazoezi;

  MazoeziManagerScreenState({this.reference, this.mazoezi});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final body = Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[KadiGame(reference: reference, mazoezi: mazoezi)],
      ),
    );

    return PageScaffold(false, 'TULONGE AFYA', 'Tengeneza Zoezi', null, body,
        false, () {}, false);
  }
}
