import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:chw/src/resources/constants.dart';

class SlidableItem extends StatelessWidget {
  Widget body;
  Function deleteAction;
  Function updateAction;
  Function extraAction;
  String extraLabel;
  IconData extraIcon;

  SlidableItem(
      {this.body,
      this.updateAction,
      this.deleteAction,
      this.extraAction,
      this.extraLabel,
      this.extraIcon});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    this.extraAction != null
        ? actions.add(IconSlideAction(
            caption: extraLabel,
            color: Colors.white,
            icon: extraIcon,
            onTap: () => extraAction(),
          ))
        : null;
    actions.add(IconSlideAction(
      caption: 'Edit',
      color: Colors.white,
      icon: Icons.edit,
      onTap: () => updateAction(),
    ));

    actions.add(IconSlideAction(
      caption: 'Delete',
      color: primaryColor,
      icon: Icons.delete,
      onTap: () => deleteAction(),
    ));
    return Slidable(
      delegate: SlidableScrollDelegate(),
      actionExtentRatio: 0.25,
      secondaryActions: actions,
      child: body,

    );
  }
}
