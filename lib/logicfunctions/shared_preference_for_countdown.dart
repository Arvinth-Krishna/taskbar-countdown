import 'package:shared_preferences/shared_preferences.dart';

setAlwaysTopScreen(boolData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('topOfScreen', boolData);
  print("saved");
}

getAlwaysTopScreen() async {
  final prefs = await SharedPreferences.getInstance();
  final data=await prefs.getBool('topOfScreen')??true;
  return data;
}


setAutoStart(boolData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('autoStart', boolData);
}

getAutoStart() async {
  final prefs = await SharedPreferences.getInstance();
  final data= await prefs.getBool('autoStart')??true;
  return data;
}

setHideOrShowWindow(boolData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hideOrShowWindow', boolData);
}

getHideOrShowWindow() async {
  final prefs = await SharedPreferences.getInstance();
  final data= await prefs.getBool('hideOrShowWindow')??false;
  return data;
}


