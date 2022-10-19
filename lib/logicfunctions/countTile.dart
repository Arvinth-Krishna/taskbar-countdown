import 'dart:io';

import 'package:flutter/material.dart';

import 'directory_operations.dart';

int folLength = 0;
var folList;

Future<List<ListTile>> countTileFetcher(context) async {
  List<ListTile> listtile = [];
  for (int index = 0; index < folLength; index++) {
    bool iconCheck = File(folList[index].path + "/image.ico").existsSync();
    var titleRaw = folList[index].path.split("/").last;
    var titleNum = "0";
    if (titleRaw.split("-").length > 1) {
      var rawData = titleRaw.split("-");
      titleRaw = rawData[0];
      if (rawData.length > 1) titleNum = "-" + rawData[1];
    } else {
      var rawData = titleRaw.split("＋");
      titleRaw = rawData[0];
      if (rawData.length > 1) titleNum = "＋" + rawData[1];
    }

    var data = (await DirectoryOperator.readCdInfo(
            folList[index].path + "/Desktop.ini"))
        .split("InfoTip=")
        .last
        .split(" Target:");

    var colorData = (await DirectoryOperator.readCdInfo(
            folList[index].path + "/countdownInfo.txt"))
        .split("~")
        .last;

    String truncate(String text, { length: 7, omission: '...' }) {
      if (length >= text.length) {
        return text;
      }
      return text.replaceRange(length, text.length, omission);
    }


    listtile.add(ListTile(
      horizontalTitleGap: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: 2),
        // contentPadding: EdgeInsets.only(top: 5, left: 15, right: 15,bottom: 5),
        onTap: () {
          showAlertDialog(context,
              dir: folList[index],
              cdInfo: data[0],
              title: titleRaw,
              targetDate: data[1].split(" ").first,
              currentCount: titleNum,
          borderColor:int.parse(colorData),
          );
        },
        // hoverColor:Color(0xff0c1d31),
        tileColor: Color(int.parse(colorData)),
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconCheck
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.file(File(folList[index].path + "/image.ico")))
                : Icon(
                    Icons.photo,
                    size: 30,
                  ),
          ],
        ),
        subtitle: Text(truncate(data[0],length: 200),style: TextStyle(color:(colorData=="4291681337"||colorData=="4294961979"||colorData=="4294951175")? Colors.black:Colors.white,),),
        trailing: Container(
          width: 90,
          padding: EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
          margin: EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: Color(0xff1a242a), borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data[1].split(" ").first,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                titleNum=="＋0"?"0":titleNum,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        title: Text(
          titleRaw.toString().replaceAll("_", " "),
          style: TextStyle(
              color:(colorData=="4291681337"||colorData=="4294961979"||colorData=="4294951175")? Colors.black:Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
        )));
  }

  listtile.insert(
      (listtile.length),
      ListTile(
        contentPadding: EdgeInsets.all(10),
      ));
  return listtile;
}

showAlertDialog(BuildContext context,
    {dir, title, currentCount, cdInfo, targetDate,borderColor}) {
  // set up the buttons
  Widget cancelButton =Padding(padding: EdgeInsets.only(right: 15,bottom: 9),
  child:TextButton(

    child: Text("❌ Close"),
    onPressed: () {
      Navigator.pop(context);
    },
  ));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),

    insetPadding: EdgeInsets.all(25),
    backgroundColor: Color(0xff242124),
    title: Row(
      children: [
        SizedBox(
            height: 30,
            width: 30,
            child: Image.file(File(dir.path + "/image.ico"))),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 180,
        child:Text(title.toString().replaceAll("_", " "), overflow: TextOverflow.fade, style: TextStyle(color:borderColor==4279314758||borderColor==4278190080?Colors.white: Color(borderColor)),),

  )
      ],
    ),
    content: Container(
   
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(border: Border.all(color: Color(borderColor)),
      borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

          RichText(text: TextSpan(children: [TextSpan(text: "Info : ",style: TextStyle(color: Colors.amber,fontSize: 15)),TextSpan(text:"$cdInfo",style: TextStyle(fontSize: 16)),])),
            SizedBox(height: 10,),
            RichText(text: TextSpan(children: [TextSpan(text: "No Of Days : ",style: TextStyle(color: Colors.amber,fontSize: 15)),TextSpan(text:"$currentCount",style: TextStyle(fontSize: 16)),])),
            SizedBox(height: 10,),
            RichText(text: TextSpan(children: [TextSpan(text: "Target Date : ",style: TextStyle(color: Colors.amber,fontSize: 15)),TextSpan(text:"$targetDate",style: TextStyle(fontSize: 16)),])),

            SizedBox(
              height: 30,
              child: Divider(color: Color(borderColor),),
            ),
            Text(
              "If you want to delete this Countdown. Please go to",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              "Documents -> taskBarCountdown",
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
            Text(
              " and delete '$title$currentCount' folder.",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    ),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
