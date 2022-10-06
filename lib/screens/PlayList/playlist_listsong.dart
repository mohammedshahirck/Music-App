import 'package:flutter/material.dart';
import 'package:musicplayer/database/playlist_db.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatefulWidget {
  const SongList({Key? key, required this.playlist}) : super(key: key);

  final MusicPlayer playlist;
  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    PlaylistDB.getAllPlaylist();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Songs',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder<List<SongModel>>(
              future: audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true),
              builder: (context, item) {
                if (item.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (item.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Songs Found',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        onTap: () {},
                        iconColor: const Color.fromARGB(255, 255, 255, 255),
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Colors.white,
                                  // Colors.blueGrey,
                                  Colors.black
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
                          artworkFit: BoxFit.fill,
                          artworkBorder:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        title: Text(
                          item.data![index].displayNameWOExt,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          "${item.data![index].artist}",
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                playlistCheck(item.data![index]);

                                PlaylistDB.playlistNotifier.notifyListeners();
                              });
                            },
                            icon:
                                !widget.playlist.isValueIn(item.data![index].id)
                                    ? const Icon(Icons.add)
                                    : const Icon(Icons.check)),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: item.data!.length);
              }),
        ));
  }

  void playlistCheck(SongModel data) {
    if (!widget.playlist.isValueIn(data.id)) {
      widget.playlist.add(data.id);
      const snackbar = SnackBar(
          backgroundColor: Colors.black,
          content: Text(
            'song Added to Playlist',
            style: TextStyle(
              color: Colors.white,
            ),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
