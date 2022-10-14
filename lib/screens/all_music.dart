import 'package:flutter/material.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/favoritebutton.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({Key? key}) : super(key: key);
  static List<SongModel> song = [];

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {
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
            color: Color.fromARGB(255, 5, 5, 5),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: SongSortType.TITLE,
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

            return ListView.builder(
              itemCount: item.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: RecentSongsController.recentsNotifier,
                  builder: (BuildContext context, List<SongModel> recentValue,
                      Widget? child) {
                    return ListTile(
                      leading: QueryArtworkWidget(
                        id: item.data![index].id,
                        type: ArtworkType.AUDIO,
                        artworkFit: BoxFit.fill,
                        nullArtworkWidget: CircleAvatar(
                          radius: 25,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.16,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Colors.white,
                                  Colors.black
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Icon(
                              Icons.music_note_rounded,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item.data![index].title,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 31, 53)),
                      ),
                      subtitle: Text(
                        "${item.data![index].artist}  ",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 5, 31, 53)),
                      ),
                      trailing: FavoriteBut(song: item.data![index]),
                      onTap: () {
                        MusicStore.player.setAudioSource(
                          MusicStore.createSongList(item.data!),
                          initialIndex: index,
                        );
                        MusicStore.player.play();
                        RecentSongsController.addRecentlyPlayed(
                            item.data![index].id);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NowPlaying(
                              playerSong: MusicStore.playingSong,
                              //item.data!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
