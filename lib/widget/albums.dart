// favorite

// import 'package:flutter/material.dart';

// import 'package:musicplayer/database/favorite_functions.dart';
// import 'package:musicplayer/screens/music_player.dart';
// import 'package:musicplayer/widget/music_store.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class Favorites extends StatefulWidget {
//   const Favorites({super.key});

//   @override
//   State<Favorites> createState() => _FavoritesState();
// }

// class _FavoritesState extends State<Favorites> {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: FavoriteDB.favoriteSongs,
//       builder: ((context, List<SongModel> favorData, Widget? child) {
//         return Scaffold(
//           body: CustomScrollView(
//             slivers: <Widget>[
//               SliverAppBar(
//                 // backgroundColor: Colors.blueGrey,
//                 pinned: true,
//                 floating: true,
//                 expandedHeight: 200,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: Container(
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50),
//                           bottomRight: Radius.circular(50),
//                         ),
//                         color: Colors.blueGrey),
//                   ),
//                   centerTitle: true,
//                   title: const Text(
//                     'F A V O R I T E S',
//                     style: TextStyle(fontSize: 25),
//                   ),
//                 ),
//                 leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                   ),
//                 ),
//                 centerTitle: true,
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     ValueListenableBuilder(
//                       valueListenable: FavoriteDB.favoriteSongs,
//                       builder: ((BuildContext context,
//                           List<SongModel> favorData, Widget? child) {
//                         return ListTile(
//                             leading: QueryArtworkWidget(
//                               id: favorData[index].id,
//                               type: ArtworkType.AUDIO,
//                               nullArtworkWidget: CircleAvatar(
//                                 radius:
//                                     MediaQuery.of(context).size.width * 0.075,
//                                 backgroundColor: Colors.blue,
//                                 child: const Icon(
//                                   Icons.music_note,
//                                 ),
//                               ),
//                             ),
//                             title: Text(
//                               favorData[index].displayNameWOExt,
//                               maxLines: 1,
//                               overflow: TextOverflow.fade,
//                               style: const TextStyle(fontSize: 15),
//                             ),
//                             subtitle: Text(
//                               favorData[index].artist.toString(),
//                               maxLines: 1,
//                               overflow: TextOverflow.fade,
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                             trailing: IconButton(
//                               onPressed: () {
//                                 FavoriteDB.favoriteSongs.notifyListeners();
//                                 FavoriteDB.delete(favorData[index].id);
//                                 setState(() {});
//                                 const snackbar = SnackBar(
//                                   backgroundColor:
//                                       Color.fromARGB(255, 255, 255, 255),
//                                   content: Text(
//                                     'Song removed from favorites',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   duration: Duration(
//                                     milliseconds: 500,
//                                   ),
//                                 );
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(snackbar);
//                               },
//                               icon: const Icon(Icons.heart_broken_rounded),
//                             ),
//                             onTap: () {
//                               List<SongModel> newlist = [...favorData];
//                               setState(() {});
//                               MusicStore.player.stop();
//                               MusicStore.player.setAudioSource(
//                                   MusicStore.createSongList(newlist),
//                                   initialIndex: index);
//                               MusicStore.player.play();
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: ((context) => NowPlaying(
//                                         playerSong: newlist,
//                                       )),
//                                 ),
//                               );
//                             });
//                       }),
//                     );
//                   },
//                   // 40 list items
//                   childCount: favorData.length,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class Album extends StatefulWidget {
//   const Album({super.key});

//   @override
//   State<Album> createState() => _AlbumState();
// }

// class _AlbumState extends State<Album> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(slivers: [
//         SliverAppBar(
//           backgroundColor: Colors.transparent,
//           pinned: true,
//           floating: true,
//           expandedHeight: 300,
//           flexibleSpace: FlexibleSpaceBar(
//             background: Container(
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50),
//                     bottomRight: Radius.circular(50),
//                   ),
//                   color: Colors.blueGrey),
//             ),
//             centerTitle: true,
//             title: const Text(
//               'F A V O R I T E S',
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context, true);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//             ),
//           ),

//           centerTitle: true,
//           // title: Text('A L B U M S'),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return ListTile(
//                 title: Text('Music $index'),
//               );
//             },
//             // 40 list items
//             childCount: 40,
//           ),
//         ),
//       ]),
//     );
//   }
// }

        // FavoriteDB.favoriteSongs.value.isEmpty
        //     ? Center(
        //         child: Text(
        //           'No Favorite Songs',
        //         ),
        //       )
        //     : ListView(
        //         children: [
        //           ValueListenableBuilder(
        //             valueListenable: FavoriteDB.favoriteSongs,
        //             builder: (BuildContext context,
        //                 List<SongModel> favorData, Widget? child) {
        //               return ListView.builder(
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return ListTile(
        //                     leading: QueryArtworkWidget(
        //                       id: favorData[index].id,
        //                       type: ArtworkType.AUDIO,
        //                       nullArtworkWidget: CircleAvatar(
        //                         radius: MediaQuery.of(context).size.width *
        //                             0.075,
        //                         backgroundColor:
        //                             const Color.fromARGB(255, 43, 42, 42),
        //                         child: const Icon(
        //                           Icons.music_note,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                     title: Text(
        //                       favorData[index].displayNameWOExt,
        //                       maxLines: 1,
        //                       overflow: TextOverflow.fade,
        //                       style: const TextStyle(
        //                           color: Color.fromARGB(255, 255, 255, 255),
        //                           fontSize: 15),
        //                     ),
        //                     subtitle: Text(
        //                       favorData[index].artist.toString(),
        //                       maxLines: 1,
        //                       overflow: TextOverflow.fade,
        //                       style: const TextStyle(
        //                           color:
        //                               Color.fromARGB(255, 255, 255, 255)),
        //                     ),
        //                     trailing: IconButton(
        //                         onPressed: () {
        //                           FavoriteDB.favoriteSongs
        //                               .notifyListeners();
        //                           FavoriteDB.delete(favorData[index].id);
        //                           setState(() {});
        //                           const snackbar = SnackBar(
        //                               backgroundColor: Color.fromARGB(
        //                                   255, 255, 255, 255),
        //                               content: Text(
        //                                 'Song removed from favorites',
        //                                 style:
        //                                     TextStyle(color: Colors.black),
        //                               ),
        //                               duration:
        //                                   Duration(milliseconds: 500));
        //                           ScaffoldMessenger.of(context)
        //                               .showSnackBar(snackbar);
        //                         },
        //                         icon: const Icon(
        //                           Icons.delete,
        //                           color: Colors.white,
        //                           size: 30,
        //                         )),
        //                   );
        //                 },
        //               );
        //             },
        //           )
        //         ],
        //       ),