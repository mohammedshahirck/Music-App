import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/screens/PlayList/playlist_listsong.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistData extends StatefulWidget {
  const PlaylistData(
      {Key? key, required this.playlist, required this.folderindex})
      : super(key: key);
  final MusicPlayer playlist;
  final int folderindex;
  @override
  State<PlaylistData> createState() => _PlaylistDataState();
}

class _PlaylistDataState extends State<PlaylistData> {
  late List<SongModel> playlistsong;
  @override
  Widget build(BuildContext context) {
    PlaylistDB.getAllPlaylist();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: Text(widget.playlist.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<MusicPlayer>('playlistDB').listenable(),
        builder: (BuildContext context, Box<MusicPlayer> value, Widget? child) {
          playlistsong =
              listPlaylist(value.values.toList()[widget.folderindex].songIds);

          return playlistsong.isEmpty
              ? const Center(
                  child: Text(
                    'No songs in this playlist',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                        onTap: () {
                          List<SongModel> newlist = [...playlistsong];

                          MusicStore.player.stop();
                          MusicStore.player.setAudioSource(
                              MusicStore.createSongList(newlist),
                              initialIndex: index);
                          MusicStore.player.play();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => NowPlaying(
                                    playerSong: playlistsong,
                                  )));
                        },
                        leading: QueryArtworkWidget(
                          id: playlistsong[index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Colors.white,
                                  Colors.blueGrey,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.music_note_rounded,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          errorBuilder: (context, excepion, gdb) {
                            setState(() {});
                            return Image.asset('');
                          },
                        ),
                        title: Text(
                          playlistsong[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        subtitle: Text(
                          playlistsong[index].artist!,
                          style: const TextStyle(color: Colors.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              widget.playlist
                                  .deleteData(playlistsong[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            )));
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: playlistsong.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => SongList(
                playlist: widget.playlist,
              ),
            ),
          );
        },
        label: const Text(
          'Add song',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < MusicStore.songCopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (MusicStore.songCopy[i].id == data[j]) {
          plsongs.add(MusicStore.songCopy[i]);
        }
      }
    }
    return plsongs;
  }
}
