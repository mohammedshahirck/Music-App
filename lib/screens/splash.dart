// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/widget/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splashing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 28, 12, 55),
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/apple-music.png'),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  Future splashing() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    await RecentSongsController.displayRecents();

    Navigator.of(
      context,
    ).pushReplacement(
      MaterialPageRoute(
        builder: (
          context,
        ) {
          return const ScreenHome();
        },
      ),
    );
  }
}
