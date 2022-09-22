// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:musicplayer/screens/music_list.dart';
// import 'package:musicplayer/screens/music_player.dart';
// import 'package:musicplayer/widget/favoritebutton.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class MusList extends StatefulWidget {
//   final int index;
//   final AsyncSnapshot<List<SongModel>> item;
//   final AudioPlayer player;
//   const MusList(
//       {super.key,
//       required this.index,
//       required this.item,
//       required this.player});

//   @override
//   State<MusList> createState() => _MusListState();
// }

// class _MusListState extends State<MusList> {
//   bool fav = false;
//   Color color = Colors.grey;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const CircleAvatar(
//         child: Icon(
//           Icons.music_note_sharp,
//         ),
//       ),
//       title: Text(
//         widget.item.data![widget.index].displayNameWOExt,
//         maxLines: 1,
//         style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
//       ),
//       subtitle: Text(
//         "${widget.item.data![widget.index].artist}  ",
//         maxLines: 1,
//         overflow: TextOverflow.fade,
//         style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
//       ),
//       trailing: FavoriteBut(song: ListViewMusic.song[index]),
//       onTap: () {
//         // playSong(item.data![index].uri);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => NowPlaying(
//                     songModel: widget.item.data![widget.index],
//                     audioPlayer: widget.player,
//                   )),
//         );
//       },
//     );
//   }
// }

// //   void onpressed() {
// //     if (!fav) {
// //       setState(() {
// //         color = Colors.red;
// //         fav = true;
// //       });
// //     } else {
// //       setState(() {
// //         color = Colors.grey;
// //         fav = false;
// //       });
// //     }
// //   }
// // }
//  //IconButton(
//       //   onPressed: () {
//       //     // onpressed();
//       //   },
//       //   icon: Icon(
//       //     Icons.favorite,
//       //     color: color,
//       //   ),
//       // ),