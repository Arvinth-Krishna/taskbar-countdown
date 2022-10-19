import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

AppBar appBarForMainScreen(title, {centerBool: false}) {
  return AppBar(
      centerTitle: centerBool,
      backgroundColor: Colors.black,
      toolbarHeight: 45,
      flexibleSpace: windowDragger(),
      actions: [
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    windowManager.minimize();
                  },
                  child: Tooltip(
                      message: "Minimize",
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.minimize_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ))),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () {
                    windowManager.hide();
                  },
                  child: Tooltip(
                      message: "Close",
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 14,
                        ),
                      ))),
            ],
          ),
        ),
      ],
      title: windowDragger(
        widget: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
      ));
}

class windowDragger extends StatelessWidget {
  final widget;

  const windowDragger({
    Key? key,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (d) {
          windowManager.startDragging();
        },
        child: widget);
  }
}
