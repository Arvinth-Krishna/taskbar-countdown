
cdCreatorCommands({cdName,iconAddress,cdInfo,targetDate}) {

  final countdownCreatorCommandList = [
    'mkdir $cdName',
    "ATTRIB -R $cdName",
    "ATTRIB -H -R $cdName\\image.ico",
    "ATTRIB -H -R $cdName\\Desktop.ini",
    "COPY /Y $iconAddress $cdName\\image.ico",
    "ECHO [.ShellClassInfo] >> $cdName\\Desktop.ini",
    "ECHO IconFile=image.ico >> $cdName\\Desktop.ini",
    "ECHO IconIndex=0 >> $cdName\\Desktop.ini",
    "ECHO InfoTip=$cdInfo Target:$targetDate >> $cdName\\Desktop.ini",
    "ATTRIB +H +R $cdName\\image.ico",
    "ATTRIB +H +R $cdName\\Desktop.ini",
    "ATTRIB +R $cdName",
    "POPD"
  ];
  return countdownCreatorCommandList.join(" && ");
}