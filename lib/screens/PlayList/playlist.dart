import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:musicplayer/screens/PlayList/playlist_song.dart';
import 'package:musicplayer/screens/favorites/favorites.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

final nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
const subimg = "assets/images/favorite-folder-3023940.png";

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
                'Playlists',
                style: TextStyle(
                    fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(children: [
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
                    child: Card(
                      shadowColor: Colors.blue,
                      elevation: 10,
                      child: GridTile(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Lottie.asset('assets/images/8579-like.json',
                                height: 89, width: 80),
                            const Padding(
                              padding: EdgeInsets.only(left: 50, top: 25),
                              child: Text(
                                'Favorites',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Hive.box<MusicPlayer>('playlistDB').isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Text(
                              'No Playlist',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: musicList.length,
                          itemBuilder: (
                            BuildContext context,
                            index,
                          ) {
                            final data = musicList.values.toList()[index];
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(data.name),
                              ),
                              leading: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.playlist_play,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  const Duration(seconds: 3);

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: const Text(
                                          'Are you sure you want to delete this playlist?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                musicList.deleteAt(index);
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('yes')),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.playlist_remove,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PlaylistData(
                                        playlist: data,
                                        folderindex: index,
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                        ),
                ]),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text('Add'),
              icon: Icon(Icons.playlist_add),
              onPressed: () {
                showModalBottomSheet(
                  elevation: 5,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        height: 250,
                        color: const Color.fromARGB(255, 216, 231, 244),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(50),
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      icon: const Icon(
                                          Icons.playlist_play_outlined),
                                      filled: true,
                                      hintText: 'Playlist Name',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          35,
                                        ),
                                      ),
                                    ),
                                    validator: ((value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Entr playlist name";
                                      } else {
                                        return null;
                                      }
                                    }),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      child: const Text(
                                        'Cancel',
                                      ),
                                      onPressed: () => Navigator.pop(
                                        context,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                        child: const Text(
                                          'Save',
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            buttonClicked();
                                          }
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }

  Future<void> buttonClicked() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      return;
    } else {
      final music = MusicPlayer(
        name: name,
        songIds: [],
      );
      PlaylistDB.addPlaylist(music);
      nameController.clear();
    }
  }
}
