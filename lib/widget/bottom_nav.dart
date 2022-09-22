import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home_screen.dart';
import 'package:musicplayer/screens/music_library.dart';
import 'package:musicplayer/screens/search.dart';
import 'package:musicplayer/screens/music_list.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int index = 0;
  final screens = const [
    HomeScreen(),
    ListViewMusic(),
    SearchScreen(),
    MusicLibrary(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      backgroundColor: Colors.white,
      //  const Color.fromARGB(255, 219, 215, 254),
      // Color.fromARGB(255, 229, 241, 251),

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blueGrey[800],
          backgroundColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        child: NavigationBar(
          elevation: 0,
          height: 75,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: index,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(seconds: 2),
          onDestinationSelected: (index) => setState(() => this.index = index),
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
                Icons.library_music_outlined,
              ),
              selectedIcon: Icon(
                Icons.library_music,
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              label: 'Library',
            ),
          ],
        ),
      ),
    );
  }
}
