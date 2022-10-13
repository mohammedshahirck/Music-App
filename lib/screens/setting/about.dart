import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/screens/setting/settings.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) {
                  return const SettingScreen();
                },
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/apple-music.png',
                  height: 80,
                ),
              ),
            ),
            Text(
              'BlueBerry',
              style: GoogleFonts.montserrat(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Version 1.0',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Text(
                '''
Welcome to MUSIQAA, your number one source for music . We're dedicated to providing you the very best quality of sound and the music varient, with an emphasis on new features,playlists and favourites, and a rich user experience.


Founded in 2022 by Mohammed Shahir CK, MUSIQAA is our first major project with a basic performance of music hub and creates a better version in future. MUSIQAA gives you the best music experience that you never had. It includes attractive mode of UI’s and good practices.

It gives good quality and had increased the settings to power up the system as well as  to provide better  music rythms.

We hope you enjoy our music as much as we enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact us.


Sincerely,

Mohammed Shahir CK

 ''',
              ),
            )
          ]),
        ),
      ),
    );
  }
}
