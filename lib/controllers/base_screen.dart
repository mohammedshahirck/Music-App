// import 'package:get/get.dart';
// import 'package:musicplayer/database/recent_songs_db.dart';
// import 'package:musicplayer/screens/favorites/favorites.dart';
// import 'package:musicplayer/screens/home/home_screen.dart';
// import 'package:permission_handler/permission_handler.dart';

// class BottomController extends GetxController {
//   final RecentSongsController _controller = Get.put(RecentSongsController());

//   @override
//   void onInit() {
//     init();
//     super.onInit();
//   }

//   Future init() async {
//     await Permission.storage.request();
//     const HomeScreen();
//     // await getAllPlaylist();
//     await RecentSongsController.displayRecents();
//     // await FavoriteDB.getAllSongs();
//     const Favorites();
//     update();
//   }
// }
