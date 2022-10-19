import 'package:countdownontaskbar/logicfunctions/shared_preference_for_countdown.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../screens/body_for_mainscreen.dart';


alwayOnTopBoolUpdater()async{
  if (alwayOnTopCheckerBool) {

  alwayOnTopCheckerBool = false;
  await setAlwaysTopScreen(false);
  await windowManager.setAlwaysOnTop(false);
  } else {
  alwayOnTopCheckerBool = true;
  await setAlwaysTopScreen(true);
  await windowManager.setAlwaysOnTop(true);
  }
}

windowHideOrShowUpdater()async{
  if (windownHideOrShowBool) {

    windownHideOrShowBool = false;
    await setHideOrShowWindow(false);
  } else {
    windownHideOrShowBool = true;
    await setHideOrShowWindow(true);
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

