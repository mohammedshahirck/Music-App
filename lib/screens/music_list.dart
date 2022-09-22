import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/screens/music_player.dart';
import 'package:musicplayer/widget/favoritebutton.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class ListViewMusic extends StatefulWidget {
  const ListViewMusic({Key? key}) : super(key: key);
  static List<SongModel> song = [];

  @override
  State<ListViewMusic> createState() => _ListViewMusicState();
}

class _ListViewMusicState extends State<ListViewMusic> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
    }
    Permission.storage.request();
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Music',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromARGB(255, 5, 31, 53),
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: ((context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No Songs Found'),
            );
          }

          ListViewMusic.song = item.data!;
          if (!FavoriteDB.isInitialized) {
            FavoriteDB.initialize(item.data!);
          }
          MusicStore.songCopy = item.data!;
          return ListView.builder(
            itemCount: item.data!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: QueryArtworkWidget(
                  id: item.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.aspectRatio * 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: MediaQuery.of(context).size.aspectRatio * 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: MediaQuery.of(context).size.aspectRatio * 90,
                        child: Icon(
                          Icons.music_note_rounded,
                          size: 60,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  item.data![index].displayNameWOExt,
                  maxLines: 1,
                  style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
                ),
                subtitle: Text(
                  "${item.data![index].artist}  ",
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
                ),
                trailing: FavoriteBut(song: ListViewMusic.song[index]),
                onTap: () {
                  MusicStore.player.setAudioSource(
                      MusicStore.createSongList(item.data!),
                      initialIndex: index);
                  MusicStore.player.play();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NowPlaying(
                        playerSong: item.data!,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}
