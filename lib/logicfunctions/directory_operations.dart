import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../commands.dart';
var  directoryPath;
var defaultImageIcoPath;

class DirectoryOperator {
  static Future<String> get documentPath async {
     final directory = await getApplicationDocumentsDirectory();
     directoryPath=directory.path;
    return directory.path;
  }
  static Future<String> get userPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  static storeLogo()async{
    final directory= await userPath;
    ByteData byteData = await rootBundle.load("images/cd_logo_icon.ico");

    // this creates the file image
    File file = await File('${(await userPath).replaceAll("\\", "\\\\")}\\image.ico').create(recursive: true);

    // copies data byte by byte
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    defaultImageIcoPath=file.path;


  }

  static Future<String> get countdownDirPath async {
    final path = await documentPath;
    if (await Directory("$path\\taskBarCountdown").exists()) {
      return Directory("$path\\taskBarCountdown").path;
    } else {
      final cdDirPath = await Directory("$path/taskBarCountdown").create();

      return cdDirPath.path;
    }

  }
  
  static getRemainingDaysCount(targetDate){

    final now = DateTime.now().toString().split(" ");

    final todayDate=DateTime.parse(now.first) ;
    late final targetDateTime;
    if((targetDate is DateTime)){
      targetDateTime=targetDate;
    }else{

     targetDateTime=DateTime.parse(targetDate);}
    int remainingDaysInt= todayDate.difference(targetDateTime).inDays;
    String remainingDays=!remainingDaysInt.isNegative?"＋"+remainingDaysInt.toString():remainingDaysInt.toString();

    return remainingDays;
    
  }

  static Future<String> createCountDown({cdName, iconAddress, cdInfo, targetDate, tileColor}) async {
    final path = await countdownDirPath;
    final count=getRemainingDaysCount(targetDate);
    final cdNameWithCount=cdName+count;




    await Process.run(
        cdCreatorCommands(
        cdName: cdNameWithCount, iconAddress: iconAddress, cdInfo: cdInfo,targetDate: targetDate)
    ,
        [],
        workingDirectory: path,
        runInShell: true

        ).then((ProcessResult results) {print("$results\n${results.stderr}\n${results.stdout}" );});

    final newCreatedCdPath = "$path/$cdNameWithCount";
    writeCdInfo(cdName:cdName,cdNameWithCount:cdNameWithCount,currentCount:count,targetDate:targetDate,tileColor:tileColor);
    return newCreatedCdPath;

  }

  static Future<File>  cdInfoPath(cdNameWithCount) async {
    final path = '${await countdownDirPath}\\$cdNameWithCount';
    return File('$path\\countdownInfo.txt');
  }

  static Future<String> readCdInfo(path) async {
    try {
      final file = File(path);

      // Read the file
      final contents = await file.readAsString();

      return contents;

    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return "0";
    }
  }

  static Future<File> writeCdInfo({cdName,cdNameWithCount,currentCount,targetDate,tileColor}) async {
    final file = await cdInfoPath(cdNameWithCount);

    // Write the file
    return file.writeAsString('countdownName~$cdName\ntargetDate~$targetDate\ncurrentCount~$currentCount\ntileColor~$tileColor');
  }
}
