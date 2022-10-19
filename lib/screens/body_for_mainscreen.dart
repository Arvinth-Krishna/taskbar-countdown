import 'dart:async';
import 'package:countdownontaskbar/logicfunctions/folders_fetcher.dart';
import 'package:countdownontaskbar/logicfunctions/helpers.dart';
import 'package:countdownontaskbar/logicfunctions/shared_preference_for_countdown.dart';
import 'package:countdownontaskbar/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:window_manager/window_manager.dart';

import '../logicfunctions/countTile.dart';
import '../logicfunctions/countdown_updater.dart';
import '../logicfunctions/directory_operations.dart';

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

late bool alwayOnTopCheckerBool;
late bool windownHideOrShowBool;



class _MainScreenBodyState extends State<MainScreenBody> {


  late Timer t1;

  listLength() async {
    folList = await listOfFolders();
    setState(() {
      folList = folList;
      folLength = folList.length;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      listLength();
      countdownUpdater();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(

        color: Colors.black,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () async {
setState(() {
  alwayOnTopBoolUpdater();
});
                  },
                  style: TextButton.styleFrom(
                      backgroundColor:
                          alwayOnTopCheckerBool ? Colors.green : Colors.grey),
                  child: Text(
                    "Top of Screen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
               Spacer(),
                IconButton(icon:Icon(Icons.settings,color: Colors.white,), onPressed: () {  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen())); },),
              ],
            ),
          ),
          Expanded(
              child: Material(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0,left: 8.0),
              child: FutureBuilder<List<ListTile>>(

                  future: countTileFetcher(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return ListView.builder(

                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: snapshot.data![index],
                              );
                            });
                    } else {
                      return Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()));
                    }
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
