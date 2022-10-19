import 'package:countdownontaskbar/screens/appbar_for_mainscreen.dart';
import 'package:countdownontaskbar/screens/data_entry_screen.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:flutter/material.dart';

import '../logicfunctions/directory_operations.dart';
import 'body_for_mainscreen.dart';
import 'package:tray_manager/tray_manager.dart';

import 'package:flutter/material.dart' hide MenuItem;
import 'package:tray_manager/tray_manager.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen>  with TrayListener  {
  final TrayManager _trayManager = TrayManager.instance;
  final String _iconPathWin = 'images/cd_logo_icon.ico';

  @override
  void onTrayIconRightMouseDown() async {
    await _trayManager.popUpContextMenu();
  }
  @override
  void onTrayIconMouseDown()async {
    if(await windowManager.isVisible()){
      await windowManager.hide();
    }else{
      await windowManager.show();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trayManager.addListener(this);
    setupIconTray();


  }
  setupIconTray()async{
    await _trayManager.setIcon(_iconPathWin);
    await _trayManager.setToolTip(' TaskBar Countdown ');
    await trayManager.setContextMenu(Menu(items: items));
  }
  List<MenuItem> items = [

    MenuItem(label: "Quit",onClick:(d)async{await windowManager.close();}),



  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBarForMainScreen("Taskbar Countdown"),
      body: MainScreenBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () async {

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DataEntryScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
