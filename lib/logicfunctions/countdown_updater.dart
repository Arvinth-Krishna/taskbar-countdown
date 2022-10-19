


import 'dart:io';

import 'directory_operations.dart';
import 'folders_fetcher.dart';


cdInfoDecoder(data){
  final List lineData=data.split("\n");
  final onlyData=lineData.map((data)=>data.split("~")[1]).toList();
  return onlyData;

}
currentCdNameGetter(path){
  final cdName=path.split("/").last;
  return cdName;
}


countdownUpdater() async {

  final List allFolderList =await listOfFolders();

  allFolderList.forEach((countDown) async {

    var data=await cdInfoDecoder(await DirectoryOperator.readCdInfo(countdownInfoPath(countDown.path)));

    if (await DirectoryOperator.getRemainingDaysCount(data[1])!=data[2]){



    print("current cd updated");
    await Process.run("rename ${currentCdNameGetter(countDown.path)} ${data[0]}${await DirectoryOperator.getRemainingDaysCount(data[1])}", [],
        workingDirectory: await DirectoryOperator.countdownDirPath, runInShell: true);

    DirectoryOperator.writeCdInfo(cdName:data[0],cdNameWithCount:"${data[0]}${await DirectoryOperator.getRemainingDaysCount(data[1])}",currentCount:"${await DirectoryOperator.getRemainingDaysCount(data[1])}",targetDate:data[1],tileColor: data[3]);
    }

  });

}

