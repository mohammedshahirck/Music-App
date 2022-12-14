import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeRecentsSongs extends StatefulWidget {
  const HomeRecentsSongs({Key? key}) : super(key: key);

  @override
  State<HomeRecentsSongs> createState() => _HomeRecentsSongsState();
}

class _HomeRecentsSongsState extends State<HomeRecentsSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  static List<SongModel> removedup = [];
  @override
  void initState() {
    super.initState();
    init();
    setState(() {});
  }

  Future init() async {
    await RecentSongsController.getRecentSongs();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FavoriteDB.favoriteSongs;
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: FutureBuilder(
          future: RecentSongsController.getRecentSongs(),
          builder: (context, items) {
            return ValueListenableBuilder(
              valueListenable: RecentSongsController.recentsNotifier,
              builder: (BuildContext context, List<SongModel> recentValue,
                  Widget? child) {
                if (recentValue.isEmpty) {
                  return Lottie.asset('assets/images/play.json',
                      height: 89, width: 100);
                } else {
                  final temp = recentValue.reversed.toList();
                  removedup = temp.toSet().toList();

                  return FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                        sortType: SongSortType.TITLE,
                        orderType: OrderType.ASC_OR_SMALLER,
                        uriType: UriType.EXTERNAL,
                        ignoreCase: true,
                      ),
                      builder: (BuildContext context, item) {
                        if (item.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (item.data!.isEmpty) {
                          return const Center(
                            child: Text('No Songs Found'),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              removedup.length > 10 ? 10 : removedup.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: GestureDetector(
                                onTap: () {
                                  MusicStore.player.setAudioSource(
                                      MusicStore.createSongList(removedup),
                                      initialIndex: index);

                                  MusicStore.player.play();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowPlaying(
                                        playerSong: MusicStore.playingSong,
                                      ),
                                    ),
                                  );
                                  // MusicStore.player.stop();
                                },
                                child: Column(
                                  children: [
                                    QueryArtworkWidget(
                                        quality: 100,
                                        artworkBorder:
                                            BorderRadius.circular(20),
                                        artworkHeight:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        artworkWidth:
                                            MediaQuery.of(context).size.width *
                                                0.34,
                                        artworkFit: BoxFit.fill,
                                        id: removedup[index].id,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
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
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Icon(
                                            Icons.music_note_rounded,
                                            color: Colors.blueGrey[600],
                                          ),
                                        )),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Center(
                                        child: Text(
                                          removedup[index].title,
                                          overflow: TextOverflow.clip,
                                          softWrap: false,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                }
              },
            );
          },
        ),
      ),
    );
  }
}
