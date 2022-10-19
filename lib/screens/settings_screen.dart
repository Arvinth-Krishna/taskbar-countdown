import 'package:countdownontaskbar/screens/appbar_for_mainscreen.dart';
import 'package:countdownontaskbar/screens/body_for_mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../logicfunctions/helpers.dart';
import '../logicfunctions/settings_Header.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForMainScreen("⚙Settings",centerBool: true),
      body: Container(color: Colors.black,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                print("hellow");
              },
              child: SettingsHeader(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              IconButton(
                  hoverColor: Color(0xff404EED),
                  splashRadius: 16,
                  onPressed: (){
                print("as");
                _launchUrl("https://discord.gg/THwBTUHnwZ");}, icon: Icon(Icons.discord)),
              IconButton(
                  hoverColor: Colors.red,
                  splashRadius: 7,
                  onPressed: (){

                print("as");
                _launchUrl("https://www.youtube.com/channel/UCKU73B2c4FBl8o4b1qBBPxA");}, icon: FaIcon(FontAwesomeIcons.youtube)),
              IconButton(
                  hoverColor: Color(0xffFA3C57)         ,
                  splashRadius: 16,
                  onPressed: (){
                print("as");
                _launchUrl("https://www.instagram.com/arvinth_krishna/");}, icon: FaIcon(FontAwesomeIcons.instagram)),
              IconButton(
                  hoverColor: Colors.blue,
                  splashRadius: 16,
                  onPressed: (){
                print("as");
                _launchUrl("https://www.linkedin.com/in/arvinth-krishna-g-b7638967/");}, icon: FaIcon(FontAwesomeIcons.linkedin)),
              IconButton(
                  hoverColor: Colors.white24,
                  splashRadius: 16,
                  onPressed: (){
                print("as");
                _launchUrl("https://github.com/Arvinth-Krishna");}, icon: FaIcon(FontAwesomeIcons.github))
            ],),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white38, width: 1),

                      borderRadius: BorderRadius.circular(10),

                    ),
                    hoverColor: Colors.white10,
                    tileColor: Color(0xff80000),
                    title: Text("Always Top Of Screen"), value: alwayOnTopCheckerBool, onChanged: (bool value) {

                      setState(() {
                        alwayOnTopBoolUpdater();
                      });
                      },            ),
SizedBox(height: 10,),
                  SwitchListTile(
                    activeColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white38, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    hoverColor: Colors.white10,
                    tileColor: Color(0x0ff80000),
                    subtitle: Text("Minimized to System Tray."),
                    title: Text("Start Window Minimized."), value: windownHideOrShowBool,
                    onChanged: (bool value) {

                    setState(() {
                      windowHideOrShowUpdater();
                    });
                  },            ),
                  SizedBox(height: 10,),

                ],
              ),
            )


          ],
        ),
      ),
      ),
    );
  }
}

