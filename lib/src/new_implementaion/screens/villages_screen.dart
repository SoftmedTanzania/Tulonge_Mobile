import 'package:chw/src/new_implementaion/models/village_model.dart';
import 'package:chw/src/new_implementaion/scoped_models/main_model.dart';
import 'package:chw/src/new_implementaion/screens/forms/add_village.dart';
import 'package:chw/src/new_implementaion/ui/app_drawer.dart';
import 'package:chw/src/new_implementaion/ui/custom_button.dart';
import 'package:chw/src/ui/shared/custom_mat_color.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:chw/src/new_implementaion/ui/message.dart';
import 'package:chw/src/new_implementaion/ui/bottom_gradient.dart';

class VillageScreen extends StatefulWidget {
  @override
  _VillageScreenState createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool addFormShown = false;

  _openAddVillage() {
    Navigator.of(context).push(
      new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new AddVillage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            new FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model) {
        return Scaffold(
          key: scaffoldKey,
          drawer: AppDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.setNewVillage();
              _openAddVillage();
              },
            child: Icon(addFormShown ? Icons.close : Icons.add),
          ),
          body: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                buildAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate(model.getVillages
                      .map((village) => buildVillage(village, model))
                      .toList()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildVillage(Village village, MainModel model) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        backgroundImage: AssetImage('assets/village.png'),
      ),
      title: Text(
        '${village.name}',
        style: TextStyle(fontSize: 19.0),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${village.leaderName}'),
          Text('${village.leaderPhone}'),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              CustomButton(
//                  text: 'Edit',
//                  onPressed: () {
//                    model.setNewVillage(village: village);
//                    _openAddVillage();
//                  },
//                  icon: Icons.edit,
//                  color: Colors.blueAccent,
//                  textColor: Colors.white),
//              SizedBox(width: 8.0),
//              CustomButton(
//                  text: 'Delete',
//                  onPressed: () {
//                    confirmSubmission(context, 'Futa Kijiji hiki',
//                        onOK: () async {
//                      try {
//                        await model.deleteVillage(village.id);
//                        showMessage(context, 'SUCCESS',
//                            '${village.name} Kimefutwa', null);
//                      } catch (e) {
//                        showMessage(context, 'ERROR',
//                            'Hujafinikiwa Kufuta Kijiji', null);
//                      }
//                    });
//                  },
//                  icon: Icons.delete,
//                  color: Colors.redAccent,
//                  textColor: Colors.black54),
//            ],
//          )
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              onSelected: (value) {
                if (value == "EDIT") {
                  model.setNewVillage(village: village);
                  _openAddVillage();
                } else if (value == "DELETE") {
                  confirmSubmission(context, 'Futa Kijiji hiki',
                      onOK: () async {
                        try {
                          await model.deleteVillage(village.id);
                          showMessage(context, 'SUCCESS',
                              '${village.name} Kimefutwa', null);
                        } catch (e) {
                          showMessage(context, 'ERROR',
                              'Hujafinikiwa Kufuta Kijiji', null);
                        }
                      });
                }
              },
              child: IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  onPressed: null),
              itemBuilder: (BuildContext context) =>getOptions(village)),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      forceElevated: false,
      backgroundColor: Colors.blueAccent,
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
                          colorFilter: ColorFilter.linearToSrgbGamma(),
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/villageP.jpg',
                          ),
                        ),
                      ),
                      height: 300.0,
                    ),
                    Container(
                      height: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                            end: FractionalOffset(0.0, 0.0),
                            begin: FractionalOffset(0.0, 1.0),
                            colors: <Color>[
                              Color(0xff222128),
                              Color(0x442C2B33),
                              Color(0x002C2B33)
                            ],
                          )),
                    ),
                  ])),
            )
          ],
        ),
        title: Text(
          "Vijiji/Mitaa",
          style: TextStyle(fontSize: 14.0),
        ),
      ),
    );
  }


  List<PopupMenuEntry<String>> getOptions(Village village){
    List<PopupMenuEntry<String>> returnList = [];
    returnList.add(PopupMenuItem<String>(
        value: "",
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(village.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
        )));
    returnList.add(PopupMenuItem<String>(
      value: "EDIT",
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.edit, color: Colors.blue,),
        title: const Text('Edit'),
      ),
    ));
    returnList.add(PopupMenuItem<String>(
        value: "DELETE",
        child: const ListTile(
          dense: true,
          leading: const Icon(Icons.delete_forever, color: Colors.deepOrange,),
          title: const Text('Delete'),
        )));
    return returnList;
  }
}
