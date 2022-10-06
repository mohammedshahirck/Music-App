import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/screens/favorites/favorites.dart';
import 'package:musicplayer/screens/home/carosal_list.dart';
import 'package:musicplayer/screens/home/home_function.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/screens/settings.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<AlbumModel> album = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    requestPermission();
    init();

    RecentSongsController.displayRecents();
    super.initState();
  }

  void requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
    Permission.storage.request();
  }

  Future init() async {
    await Permission.storage.request();
    const HomeScreen();
    // await getAllPlaylist();
    await RecentSongsController.displayRecents();
    // await FavoriteDB.getAllSongs();
    // const Favorites(song: ,);
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Settings();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Text('Hi There..\nShahir',
                    style: GoogleFonts.sniglet(
                      fontSize: 30,
                      // fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
          FutureBuilder<List<SongModel>>(
              future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true),
              builder: (BuildContext context, item) {
                if (item.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (item.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Songs Found',
                    ),
                  );
                }
                AllMusic.song = item.data!;

                if (!FavoriteDB.isInitialized) {
                  FavoriteDB.initialize(item.data!);
                }
                MusicStore.songCopy = item.data!;
                return ValueListenableBuilder(
                    valueListenable: RecentSongsController.recentsNotifier,
                    builder: (BuildContext context, List<SongModel> recentValue,
                        Widget? child) {
                      return CarouselSlider.builder(
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            GestureDetector(
                          onTap: () {
                            MusicStore.player.setAudioSource(
                              MusicStore.createSongList(item.data!),
                              initialIndex: itemIndex,
                            );
                            MusicStore.player.play();
                            RecentSongsController.addRecentlyPlayed(
                                AllMusic.song = item.data!);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NowPlaying(playerSong: item.data!)),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QueryArtworkWidget(
                                keepOldArtwork: true,
                                quality: 100,
                                id: item.data![itemIndex].id,
                                type: ArtworkType.AUDIO,
                                artworkFit: BoxFit.fill,
                                nullArtworkWidget: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
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
                                    borderRadius: BorderRadius.circular(20),
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
                                    MediaQuery.of(context).size.width * 0.34,
                                artworkHeight:
                                    MediaQuery.of(context).size.height * 0.16,
                              ),
                              // Text(
                              //   item.data![itemIndex].title,
                              //   style: const TextStyle(),
                              //   maxLines: 1,
                              //   overflow: TextOverflow.clip,
                              // ),
                            ],
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1200),
                          aspectRatio: 16 / 90,
                          height: 155,
                          viewportFraction: 0.4,
                          autoPlay: true,
                          autoPlayCurve: Curves.easeInQuint,
                          enlargeCenterPage: true,
                        ),
                        itemCount: 10,
                      );
                    });
                // SizedBox(
                //   height: 10,
                // );
                // const Text(
                //   'Recents',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // )
              }),
          HomeRecentsSongs(),
        ],
      ),
    );
  }
}
 // SafeArea(
  //         child: SingleChildScrollView(
  //       physics: const ScrollPhysics(),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(right: 20, top: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) {
  //                       return const Settings();
  //                     }));
  //                   },
  //                   icon: const Icon(Icons.settings_outlined),
  //                 ),
  //               ],
  //             ),
  //           ),

  //           Padding(
  //             padding: const EdgeInsets.only(
  //               left: 20,
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Albums',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: const Icon(
  //                     Icons.arrow_forward_ios,
  //                     size: 20,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.only(
  //               left: 10,
  //             ),
  //             height: MediaQuery.of(context).size.height * .16,
  //             child: GridView.builder(
  //               itemCount: images.length,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (
  //                 BuildContext context,
  //                 index,
  //               ) =>
  //                   Column(
  //                 children: [
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * .13,
  //                     width: MediaQuery.of(context).size.height * .13,
  //                     margin: const EdgeInsets.all(
  //                       1,
  //                     ),
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                         image: AssetImage(images[index]),
  //                         fit: BoxFit.fill,
  //                       ),
  //                       borderRadius: BorderRadius.circular(20),
  //                     ),
  //                     child: const Center(
  //                       child: Icon(
  //                         Icons.music_note,
  //                       ),
  //                     ),
  //                   ),
  //                   Text(text1[index]),
  //                 ],
  //               ),
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 1,
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Artists',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //                 IconButton(
  //                   onPressed: () {},
  //                   icon: const Icon(
  //                     Icons.arrow_forward_ios,
  //                     size: 20,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.only(
  //               left: 10,
  //             ),
  //             height: 100,
  //             child: GridView.builder(
  //               itemCount: images.length,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (
  //                 BuildContext context,
  //                 index,
  //               ) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: CircleAvatar(
  //                     backgroundImage: AssetImage(images[index]),
  //                   ),
  //                 );
  //               },
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 1,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     )),
  //   );
  // }

  // albumsongs() async {
  //   AlbumSortType.ALBUM;
  //   OrderType.ASC_OR_SMALLER;

  //   // DEFAULT:
  //   // AlbumSortType.ALBUM,
  //   // OrderType.ASC_OR_SMALLER
  //   List<AlbumModel> Album = await _audioQuery.queryAlbums();