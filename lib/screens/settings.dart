import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blueGrey[900],
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text(
            'Settings',
            style:
                TextStyle(fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
