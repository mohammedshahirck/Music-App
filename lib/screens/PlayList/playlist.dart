import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:musicplayer/screens/PlayList/playlist_song.dart';
import 'package:musicplayer/screens/favorites/favorites.dart';
import 'package:musicplayer/screens/PlayList/playlist_screen.dart';
import 'package:musicplayer/widget/const.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<MusicPlayer>('playlistDB').listenable(),
      builder:
          (BuildContext context, Box<MusicPlayer> musicList, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Playlist',
              style: TextStyle(
                  fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Favorites();
                          },
                        ),
                      );
                    },
                    child: GridTile(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage(subimg),
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60, top: 20),
                            child: Text(
                              'Favorites',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PlayListScreen();
                          },
                        ),
                      );
                    },
                    child: GridTile(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                              image: AssetImage(
                                  "assets/images/playlist-folder.png"),
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 65, top: 20),
                            child: Text(
                              'Playlists',
                              style: TextStyle(fontSize: 20, letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
