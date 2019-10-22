import 'package:flutter/material.dart';
import 'package:chw/src/models/participant.dart';
import 'package:chw/src/ui/forms/participant.dart';
import '../../ui/shared/page_scaffold.dart';

class MemberManagerScreen extends StatefulWidget {
  String reference;
  ParticipantModel participant;
  MemberManagerScreen({this.reference, this.participant});

  @override
  State<StatefulWidget> createState() {
    return MemberManagerScreenState(reference: this.reference, participant: this.participant);
  }
}

class MemberManagerScreenState extends State<MemberManagerScreen>
    with SingleTickerProviderStateMixin {
  String reference;
  ParticipantModel participant;
  MemberManagerScreenState({this.reference, this.participant});
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
        children: <Widget>[
          Participant(reference: reference, participant: this.participant),
        ],
      ),
    );

    return PageScaffold(
        false, 'TULONGE AFYA', 'Sajiri Mshiriki Mpya', null, body, false, () {}, false);
  }
}
