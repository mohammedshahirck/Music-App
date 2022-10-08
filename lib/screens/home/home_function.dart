import 'package:flutter/material.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeAlbum extends StatefulWidget {
  const HomeAlbum({super.key});

  @override
  State<HomeAlbum> createState() => _HomeAlbumState();
}

class _HomeAlbumState extends State<HomeAlbum> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class HomeArtist extends StatefulWidget {
  const HomeArtist({super.key});

  @override
  State<HomeArtist> createState() => _HomeArtistState();
}

class _HomeArtistState extends State<HomeArtist> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: FutureBuilder(
          future: RecentSongsController.displayRecents(),
          builder: (context, items) {
            return ValueListenableBuilder(
              valueListenable: RecentSongsController.recentsNotifier,
              builder: (BuildContext context, List<SongModel> recentValue,
                  Widget? child) {
                if (recentValue.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Song Played ',
                      style: TextStyle(fontSize: 15),
                    ),
                  );
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
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              removedup.length > 10 ? 10 : removedup.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: GestureDetector(
                                onTap: () {
                                  RecentSongsController.addRecentlyPlayed(
                                      item.data);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowPlaying(
                                        playerSong: removedup,
                                      ),
                                    ),
                                  );

                                  MusicStore.player.stop();
                                  MusicStore.player.setAudioSource(
                                      MusicStore.createSongList(removedup),
                                      initialIndex: index);
                                  MusicStore.player.play();
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              
                    

            
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// class Allsongs extends StatefulWidget {
//   const Allsongs({super.key});

//   @override
//   State<Allsongs> createState() => _AllsongsState();
// }

// class _AllsongsState extends State<Allsongs> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
