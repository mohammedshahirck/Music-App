import 'package:flutter/material.dart';
import 'package:musicplayer/widget/bottom_nav.dart';
import 'package:musicplayer/widget/const.dart';

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
        backgroundColor: const Color.fromARGB(255, 28, 12, 55),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 140),
                    child: Text('MUSIQAA',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 221, 160, 69))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(90),
                      topRight: Radius.circular(90)),
                  child: Image.asset(
                    subimgw,
                    height: 400,
                  ),
                ),
              ),
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
