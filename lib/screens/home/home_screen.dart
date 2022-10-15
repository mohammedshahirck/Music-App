import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/screens/favorites/home_liked.dart';
import 'package:musicplayer/screens/home/home_recents.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/screens/setting/settings.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<SongModel> song = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      setState(() {});
    }

    Permission.storage.request();
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image(
                        image:
                            const AssetImage('assets/images/apple-music.png'),
                        height: MediaQuery.of(context).size.height * .12,
                        width: MediaQuery.of(context).size.width * .12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SettingScreen();
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
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
                // HomeScreen.album = item.data!;

                if (!FavoriteDB.isInitialized) {
                  FavoriteDB.initialize(item.data!);
                }
                MusicStore.songCopy = item.data!;

                return CarouselSlider.builder(
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    return ValueListenableBuilder(
                      valueListenable: RecentSongsController.recentsNotifier,
                      builder: (BuildContext context,
                          List<SongModel> recentValue, Widget? child) {
                        return GestureDetector(
                          onTap: () {
                            MusicStore.player.stop();

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
                                        //item.data!
                                      )),
                            );
                          },
                          child: ListView(
                            children: [
                              QueryArtworkWidget(
                                keepOldArtwork: true,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                size: 2000,
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                artworkFit: BoxFit.fill,
                                nullArtworkWidget: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
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
                                    MediaQuery.of(context).size.width * 0.25,
                                artworkHeight:
                                    MediaQuery.of(context).size.height * 0.16,
                              ),
                              Text(
                                item.data![index].title,
                                style: const TextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  options: CarouselOptions(
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    aspectRatio: 16 / 90,
                    height: 200,
                    viewportFraction: 0.4,
                    autoPlay: true,
                    autoPlayCurve: Curves.easeInQuint,
                    enlargeCenterPage: true,
                  ),
                  itemCount: item.data!.length,
                );
                // });
                // SizedBox(
                //   height: 10,
                // );
              }),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recents',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const HomeRecentsSongs(),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Text(
              'Liked Songs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const HomeLiked(),
        ],
      ),
    );
  }
}
