import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:musicplayer/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MusicPlayerAdapter().typeId)) {
    Hive.registerAdapter(MusicPlayerAdapter());
  }
  await Hive.openBox<int>('favoriteDB');
  await Hive.openBox<MusicPlayer>('playlistDB');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(useMaterial3: true),
      /**/
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
