// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:musicplayer/database/recent_songs_db.dart';
// import 'package:musicplayer/screens/all_music.dart';
// import 'package:musicplayer/screens/now_playing.dart';
// import 'package:musicplayer/widget/music_store.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class CarosuelList extends StatefulWidget {
//   const CarosuelList({super.key});

//   @override
//   State<CarosuelList> createState() => _CarosuelListState();
// }

// class _CarosuelListState extends State<CarosuelList> {
//   final OnAudioQuery _audioQuery = OnAudioQuery();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<SongModel>>(
//         future: _audioQuery.querySongs(
//             sortType: null,
//             orderType: OrderType.ASC_OR_SMALLER,
//             uriType: UriType.EXTERNAL,
//             ignoreCase: true),
//         builder: (BuildContext context, item) {
//           if (item.data == null) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (item.data!.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No Songs Found',
//               ),
//             );
//           }

//           return ValueListenableBuilder(
//               valueListenable: RecentSongsController.recentsNotifier,
//               builder: (BuildContext context, List<SongModel> recentValue,
//                   Widget? child) {
//                 return CarouselSlider.builder(
//                   itemBuilder: (BuildContext context, int itemIndex,
//                           int pageViewIndex) =>
//                       GestureDetector(
//                     onTap: () {
//                       MusicStore.player.setAudioSource(
//                         MusicStore.createSongList(item.data!),
//                         initialIndex: itemIndex,
//                       );
//                       MusicStore.player.play();
//                       RecentSongsController.addRecentlyPlayed(
//                           AllMusic.song = item.data!);

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 NowPlaying(playerSong: item.data!)),
//                       );
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         QueryArtworkWidget(
//                           keepOldArtwork: true,
//                           quality: 100,
//                           id: item.data![itemIndex].id,
//                           type: ArtworkType.AUDIO,
//                           artworkFit: BoxFit.fill,
//                           nullArtworkWidget: Container(
//                             width: MediaQuery.of(context).size.width * 0.35,
//                             height: MediaQuery.of(context).size.height * 0.10,
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Colors.blueGrey,
//                                   Colors.white,
//                                   Colors.black
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Icon(
//                               Icons.music_note_rounded,
//                               color: Colors.blueGrey[600],
//                             ),
//                           ),
//                           artworkBorder: const BorderRadius.all(
//                             Radius.circular(
//                               10,
//                             ),
//                           ),
//                           artworkWidth:
//                               MediaQuery.of(context).size.width * 0.34,
//                           artworkHeight:
//                               MediaQuery.of(context).size.height * 0.16,
//                         ),
//                         // Text(
//                         //   item.data![itemIndex].title,
//                         //   style: const TextStyle(),
//                         //   maxLines: 1,
//                         //   overflow: TextOverflow.clip,
//                         // ),
//                       ],
//                     ),
//                   ),
//                   options: CarouselOptions(
//                     autoPlayAnimationDuration:
//                         const Duration(milliseconds: 1200),
//                     aspectRatio: 16 / 90,
//                     height: 155,
//                     viewportFraction: 0.4,
//                     autoPlay: true,
//                     autoPlayCurve: Curves.easeInQuint,
//                     enlargeCenterPage: true,
//                   ),
//                   itemCount: 10,
//                 );
//               });
//         });
//   }
// }
