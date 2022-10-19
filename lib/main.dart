// Taskbar Countdown for Windows.
// Intial Release 07/09/2022 - 11:08 AM IST
// Designed and Developed by Arvinth Krishna G aka GAK - https://github.com/Arvinth-Krishna
// Logo Credits to Amritha Varthini G aka GAV          - https://www.instagram.com/amirthavarthini/

// Current_Version_No : 1.0.0v

import 'dart:async';

import 'package:countdownontaskbar/logicfunctions/shared_preference_for_countdown.dart';
import 'package:countdownontaskbar/screens/body_for_mainscreen.dart';
import 'package:countdownontaskbar/screens/mainscreen.dart';
import 'package:window_manager/window_manager.dart';

import 'logicfunctions/directory_operations.dart';

import 'dart:io';

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();
  alwayOnTopCheckerBool = await getAlwaysTopScreen();
  windownHideOrShowBool = await getHideOrShowWindow();

  WindowOptions windowOptions = WindowOptions(
    size: Size(340, 620),
    backgroundColor: Colors.black,
    skipTaskbar: false,
    alwaysOnTop: alwayOnTopCheckerBool,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    if (windownHideOrShowBool) {
      await windowManager.hide();
    } else {
      await windowManager.show();
    }
    await windowManager.focus();
  });

  await DirectoryOperator.documentPath;
  await DirectoryOperator.storeLogo();
  print("success: $defaultImageIcoPath");
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  LaunchAtStartup.instance.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );

  await LaunchAtStartup.instance.enable();
  // await LaunchAtStartup.instance.disable();
  bool isEnabled = await LaunchAtStartup.instance.isEnabled();
  print(isEnabled);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskbar Countdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MainScreen(),
    );
  }
}
