import 'dart:async';

import 'package:chw/src/new_implementaion/database/tables/village_table.dart'
    as table;
import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/progress_button.dart';
import 'package:chw/src/ui/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddVillage extends StatefulWidget {
  final Village currentVillage;

  AddVillage({this.currentVillage});

  @override
  _AddVillageState createState() => _AddVillageState();
}

class _AddVillageState extends State<AddVillage> {
  bool doneSaving;
  bool isSaving;
  bool isError;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _communityLeaderFieldController =
      new TextEditingController();
  TextEditingController _communityLeaderPhoneFieldController =
      new TextEditingController();
  TextEditingController _villageFieldController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doneSaving = false;
    isError = false;
    isSaving = false;
    final model = ScopedModel.of<MainModel>(context);
    if (model.newVillage == null) {
      model.setNewVillage(village: null);
    }
    _communityLeaderFieldController.text = model.newVillage.leaderName;
    _communityLeaderPhoneFieldController.text = model.newVillage.leaderPhone;
    _villageFieldController.text = model.newVillage.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB96B40),
        title: Text(
          'Kijiji/Mtaa',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 29.0),
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              CustomTextField(
                'text',
                'Kijiji/Mtaa',
                _villageFieldController,
                isRequered: true,
                icon: Icons.local_convenience_store,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                'text',
                'Jina La Mwenyekit wa Kijiji/mtaa',
                _communityLeaderFieldController,
                isRequered: true,
                icon: Icons.person_outline,
              ),
              SizedBox(height: 15.0),
              CustomTextField(
                'phone',
                'Simu ya Mwenyekit wa mtaa/kijiji',
                _communityLeaderPhoneFieldController,
                isRequered: true,
                icon: Icons.phone,
              ),
              SizedBox(height: 15.0),
              ProgressButton(
                loading: isSaving,
                callback: isSaving
                    ? null
                    : () {
                        if (_formKey.currentState.validate()) {
                          confirmSubmission(
                            context,
                            'Kusanya Taarifa hii..',
                            onOK: () async {
                              FocusScope.of(context).unfocus();
                              final model = ScopedModel.of<MainModel>(context);
                              setState(() => isSaving = true);
                              try {
                                await model.saveVillage({
                                  table.columnId: model.newVillage.id,
                                  table.columnName:
                                      _villageFieldController.text,
                                  table.columnLeaderName:
                                      _communityLeaderFieldController.text,
                                  table.columnLeaderPhone:
                                      _communityLeaderPhoneFieldController.text
                                });
                                showMessage(context, 'SUCCESS',
                                    'Kijiji/Mtaa Umeongezwa kikamilifu', () {});
                                setState(() {
                                  isSaving = false;
                                  doneSaving = true;
                                });
                                Timer(const Duration(milliseconds: 400), () {
                                  Navigator.pushReplacementNamed(
                                      context, '/villages');
                                });
                              } catch (e) {
                                showMessage(context, 'ERROR',
                                    'Hujafanikiwa Kuongeza kijiji', () {});
                                setState(() => isSaving = false);
                              }
                            },
                            onCancel: () {
                              FocusScope.of(context).unfocus();
                            },
                          );
                        }
                      },
                title: 'Kusanya',
                success: doneSaving,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
