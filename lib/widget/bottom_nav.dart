import 'package:flutter/material.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/screens/home/home_screen.dart';
import 'package:musicplayer/screens/PlayList/playlist.dart';
import 'package:musicplayer/screens/home/mini_player.dart';
import 'package:musicplayer/screens/search.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int index = 0;
  final screens = const [
    HomeScreen(),
    AllMusic(),
    SearchScreen(),
    PlayList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      backgroundColor: Colors.white,
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: FavoriteDB.favoriteSongs,
          builder:
              (BuildContext context, List<SongModel> favordata, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (MusicStore.player.currentIndex != null)
                    Column(
                      children: const [
                        MiniPlayer(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  else
                    const SizedBox(),
                  Column(
                    children: [
                      NavigationBarTheme(
                        data: NavigationBarThemeData(
                          indicatorColor: Colors.blueGrey[800],
                          backgroundColor: Colors.transparent,
                          labelTextStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        child: NavigationBar(
                          elevation: 0,
                          height: 75,
                          labelBehavior: NavigationDestinationLabelBehavior
                              .onlyShowSelected,
                          selectedIndex: index,
                          backgroundColor: Colors.transparent,
                          animationDuration: const Duration(seconds: 3),
                          onDestinationSelected: (index) =>
                              // setState(
                              //   () => this.index = index,
                              // ),
                              setState(() {
                            this.index = index;
                            FavoriteDB.favoriteSongs.notifyListeners();
                          }),
                          destinations: const [
                            NavigationDestination(
                              icon: Icon(
                                Icons.home_outlined,
                              ),
                              selectedIcon: Icon(
                                Icons.home,
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                              label: 'Home',
                            ),
                            NavigationDestination(
                              icon: Icon(
                                Icons.album_outlined,
                              ),
                              selectedIcon: Icon(
                                Icons.album,
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                              label: 'Musics',
                            ),
                            NavigationDestination(
                              icon: Icon(
                                Icons.search_outlined,
                              ),
                              selectedIcon: Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                              label: 'Search',
                            ),
                            NavigationDestination(
                              icon: Icon(
                                Icons.playlist_play,
                              ),
                              selectedIcon: Icon(
                                Icons.playlist_play_outlined,
                                color: Color.fromARGB(255, 221, 221, 221),
                              ),
                              label: 'Playlist',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
