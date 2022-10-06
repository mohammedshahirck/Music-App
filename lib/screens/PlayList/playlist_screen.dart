// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/screens/PlayList/playlist_song.dart';
import '../../model/music_player_model.dart';

class PlayListScreen extends StatefulWidget {
  PlayListScreen({
    super.key,
  });

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

final nameController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _PlayListScreenState extends State<PlayListScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<MusicPlayer>('playlistDB').listenable(),
        builder:
            (BuildContext context, Box<MusicPlayer> musicList, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'PlayLists',
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 5, 31, 53)),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      onTap: () {
                        showModalBottomSheet(
                          // elevation: 0,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                height: 250,
                                color: Colors.grey,
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  35,
                                                ),
                                              ),
                                            ),
                                            validator: ((value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                      leading: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                      title: const Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Create Playlists',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Hive.box<MusicPlayer>('playlistDB').isEmpty
                        ? const Center(
                            child: Text('No Playlist'),
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
                                title: Text(data.name),
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) =>
                                                      PlayListScreen()),
                                                ),
                                              );
                                            },
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                musicList.deleteAt(index);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return PlayListScreen();
                                                    },
                                                  ),
                                                );
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
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                          ),
                  ]),
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
