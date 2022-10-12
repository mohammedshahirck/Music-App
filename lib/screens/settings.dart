import 'package:flutter/material.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/screens/home/mini_player.dart';
import 'package:musicplayer/widget/music_store.dart';

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
      body: SafeArea(
          child: ListView(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.refresh_rounded,
                color: Colors.black,
              ),
              title: const Padding(
                padding: EdgeInsets.only(right: 80),
                child: Text(
                  'Reset App',
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
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
            ),
          ),
          const Card(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'About Us',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Card(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'Privacy Policy',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Card(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'Terms & Conditions',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
