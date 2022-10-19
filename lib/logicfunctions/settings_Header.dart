import 'package:flutter/material.dart';

import 'helpers.dart';


class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),

        SizedBox(
            height: 150,
            width: 150,
            child:Image.asset("images/cd_logo_circle.png")),
        SizedBox(height: 10,),
        Text("Taskbar Countdown",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 19),),
        SizedBox(height: 7,),
        GradientText(
          "Designed & Develoved by GAK ✌",
          style: const TextStyle(fontSize: 15),
          gradient: LinearGradient(colors: [
            Color(0xffD498A2),
            Color(0xffE5CE9F),
            // Color(0xff5F4F7D),
            Color(0xff6FDB4C),
            // Color(0xff555B4D),
            Color(0xffCCC55D),

          ]),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}

