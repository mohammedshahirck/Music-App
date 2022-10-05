import 'package:flutter/material.dart';

class Stylepage {
  Widget build(BuildContext context) {
    return Container();
  }

  BoxDecoration background() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [Colors.blueGrey, Colors.white, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
