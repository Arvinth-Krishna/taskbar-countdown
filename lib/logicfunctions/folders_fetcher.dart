import 'dart:io';


import 'directory_operations.dart';




  listOfFolders()  async {

  final folder =  Directory("$directoryPath/taskBarCountdown/").listSync(recursive:false);  //use yo

  var statResults = await Future.wait([
    for (var path in folder) FileStat.stat(path.path),
  ]);

    var mtimes = <String, DateTime>{
      for (var i = 0; i < folder.length; i += 1)
        folder[i].path: statResults[i].changed,
    };

    folder.sort((a, b) => mtimes[a.path]!.compareTo(mtimes[b.path]!));

    return folder;
  }


String countdownInfoPath(path){
  return "$path/countdownInfo.txt";




}