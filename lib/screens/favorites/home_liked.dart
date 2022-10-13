import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeLiked extends StatefulWidget {
  const HomeLiked({super.key});

  @override
  State<HomeLiked> createState() => _HomeLikedState();
}

class _HomeLikedState extends State<HomeLiked> {
  static List<SongModel> homefavor = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  void initState() {
    initialize();
    super.initState();
    setState(() {});
  }

  Future initialize() async {
    await FavoriteDB.favoriteSongs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: FutureBuilder(
          builder: (context, items) {
            return ValueListenableBuilder(
              valueListenable: FavoriteDB.favoriteSongs,
              builder: (context, List<SongModel> favorData, Widget? child) {
                if (favorData.isEmpty) {
                  return Lottie.asset('assets/images/fav.json',
                      height: 80, width: 80);
                } else {
                  final temp = favorData.reversed.toList();
                  homefavor = temp.toSet().toList();
                  return FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      sortType: SongSortType.TITLE,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return Center(
                            child: Lottie.asset('assets/images/fav.json',
                                height: 80, width: 80));
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            homefavor.length > 10 ? 10 : homefavor.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: GestureDetector(
                              onTap: () {
                                //List<SongModel> hnewlist = [...homefavor];
                                MusicStore.player.setAudioSource(
                                    MusicStore.createSongList(homefavor),
                                    initialIndex: index);
                                // MusicStore.player.stop();
                                MusicStore.player.play();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlaying(
                                      playerSong: homefavor,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  QueryArtworkWidget(
                                    artworkFit: BoxFit.fill,
                                    id: homefavor[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.16,
                                      width: MediaQuery.of(context).size.width *
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
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        Icons.music_note_rounded,
                                        color: Colors.blueGrey[600],
                                      ),
                                    ),
                                    artworkBorder: const BorderRadius.all(
                                      Radius.circular(
                                        10,
                                      ),
                                    ),
                                    artworkWidth:
                                        MediaQuery.of(context).size.width *
                                            0.34,
                                    artworkHeight:
                                        MediaQuery.of(context).size.height *
                                            0.16,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    child: Center(
                                      child: Text(
                                        homefavor[index].title,
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
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
