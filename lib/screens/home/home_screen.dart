import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/screens/home/home_function.dart';
import 'package:musicplayer/screens/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final images = [
  'assets/images/93520497.jpg',
  'assets/images/Hridayam.jpg',
  'assets/images/images.jpg',
  'assets/images/mike.jpg',
  'assets/images/shikhar-yadav-alvida-final-poster2.jpg',
  'assets/images/Sita Rama.jpg',
];
final text1 = [
  'Thallumala',
  'Hridayam',
  'Pakaliruvukal',
  'Mike',
  'Alvida',
  'Seeta Rama',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<AlbumModel> album = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
          const Text(
            'Recents',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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