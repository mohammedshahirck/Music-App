import 'package:flutter/material.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../now_playing.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDB.favoriteSongs,
        builder: (BuildContext ctx, List<SongModel> favorData, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Favorites',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  letterSpacing: 2,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
                  // FavoriteDB.favoriteSongs.value.isEmpty
                  //     ? const Center(
                  //         child: Text(
                  //         'No Favorites songs',
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold),
                  //       ))
                  //     :
                  ListView(
                children: [
                  FutureBuilder(builder: (context, item) {
                    return ValueListenableBuilder(
                      valueListenable: FavoriteDB.favoriteSongs,
                      builder: (BuildContext ctx, List<SongModel> favorData,
                          Widget? child) {
                        return favorData.isEmpty
                            ? const Center(
                                child: Text(
                                'No Favorites songs',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ))
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (ctx, index) {
                                  return ListTile(
                                    onTap: () {
                                      List<SongModel> newlist = [...favorData];
                                      // MusicStore.player.stop();
                                      MusicStore.player.setAudioSource(
                                          MusicStore.createSongList(newlist),
                                          initialIndex: index);
                                      MusicStore.player.play();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (ctx) {
                                          return NowPlaying(
                                            playerSong: MusicStore.playingSong,
                                          );
                                        }),
                                      );
                                    },
                                    leading: QueryArtworkWidget(
                                      id: favorData[index].id,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: CircleAvatar(
                                        radius: 25,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.16,
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
                                                BorderRadius.circular(40),
                                          ),
                                          child: Icon(
                                            Icons.music_note_rounded,
                                            color: Colors.blueGrey[600],
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      favorData[index].displayNameWOExt,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    subtitle: Text(
                                      favorData[index].artist.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          FavoriteDB.favoriteSongs
                                              .notifyListeners();
                                          FavoriteDB.delete(
                                              favorData[index].id);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete_sweep,
                                          color: Colors.red,
                                          size: 30,
                                        )),
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return const Divider();
                                },
                                itemCount: favorData.length);
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}
