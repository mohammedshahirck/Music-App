// import 'package:flutter/material.dart';
// import 'package:musicplayer/database/playlist_db.dart';
// import 'package:musicplayer/widget/music_store.dart';

// class Settings extends StatelessWidget {
//   const Settings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: Colors.blueGrey[900],
//         elevation: 0,
// title: const Padding(
//   padding: EdgeInsets.only(left: 70),
//   child: Text(
//             'Settings',
//             style:
//                 TextStyle(fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: ListView(
//         children: [
//           Card(
//             child: ListTile(
//               leading: const Icon(
//                 Icons.refresh_rounded,
//                 color: Colors.black,
//               ),
//               title: const Padding(
//                 padding: EdgeInsets.only(right: 80),
//                 child: Text(
//                   'Reset App',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//  onTap: () {
// MusicStore.player.stop();
// showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text(
//           'Reset App',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: const Text(
//           'Are you  want to reset this application?',
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(
//                 context,
//               );
//             },
//             child: const Text(
//               'No',
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(),
//             onPressed: () {
//               PlaylistDB.appReset(
//                 context,
//               );
//             },
//             child: const Text(
//               'Yes',
//             ),
//           ),
//         ],
//       );
//     });
//               },
//             ),
// //           ),
//           const Card(
//             child: ListTile(
//               title: Padding(
//                 padding: EdgeInsets.only(right: 30),
//                 child: Text(
//                   'About Us',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//           const Card(
//             child: ListTile(
//               title: Padding(
//                 padding: EdgeInsets.only(right: 30),
//                 child: Text(
//                   'Privacy Policy',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//           const Card(
//             child: ListTile(
//               title: Padding(
//                 padding: EdgeInsets.only(right: 30),
//                 child: Text(
//                   'Terms & Conditions',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/screens/setting/about.dart';
import 'package:musicplayer/screens/setting/privacypolicy.dart';
import 'package:musicplayer/screens/setting/terms&conditions.dart';
import 'package:musicplayer/widget/music_store.dart';

import '../home/home_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text(
            'Settings',
            style: GoogleFonts.montserrat(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 0, 0, 0),
            )),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      'Musiqaa',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Version 1.0',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const AboutUs();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.info_outline_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              label: Text(
                'About Us',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
            ),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              label: Text(
                'Share App',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const TermsNconditions();
                    },
                  ),
                );
              },
              icon: Image(
                image: AssetImage('assets/images/terms&conditions.jpg'),
                height: 40,
                width: 40,
              ),
              label: Text(
                'Terms & conditions',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              top: 10,
            ),
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Privacy();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.privacy_tip_outlined,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              label: Text(
                'Privacy Policy',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 89, 85, 85),
              ),
              child: TextButton(
                onPressed: () {
                  MusicStore.player.stop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'Reset App',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            'Are you  want to reset this application?',
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: const Text(
                                'No',
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                PlaylistDB.appReset(
                                  context,
                                );
                              },
                              child: const Text(
                                'Yes',
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: const Text('Reset App'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
