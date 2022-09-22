import 'package:flutter/material.dart';
import 'package:musicplayer/screens/favorites.dart';

class MusicLibrary extends StatefulWidget {
  const MusicLibrary({super.key});

  @override
  State<MusicLibrary> createState() => _MusicLibraryState();
}

class _MusicLibraryState extends State<MusicLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Library',
          style: TextStyle(fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              // Text(
              //   'Playlist',
              //   style: TextStyle(fontSize: 25),
              // ),
              const Divider(
                height: 1,
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const Favorites();
                    }),
                  );
                },
              ),
              ListTile(
                title: const Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text(
                    'Playlist',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
