import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/database/recent_songs_db.dart';
import 'package:musicplayer/model/music_player_model.dart';
import 'package:musicplayer/screens/splash.dart';

class PlaylistDB {
  static ValueNotifier<List<MusicPlayer>> playlistNotifier = ValueNotifier([]);
  static Future<void> addPlaylist(MusicPlayer value) async {
    final playlistDb = Hive.box<MusicPlayer>('playlistDB');
    playlistNotifier.value.add(value);
    await playlistDb.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final PlayListDb = Hive.box<MusicPlayer>('playlistDB');
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(PlayListDb.values);

    playlistNotifier.notifyListeners();
  }

  static Future<void> DeletePlayList(int index) async {
    final PlayListDb = Hive.box<MusicPlayer>('playlistDB');

    await PlayListDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> appReset(context) async {
    final playListDb = Hive.box<MusicPlayer>('playlistDB');
    final musicDb = Hive.box<int>('favoriteDB');
    final dbBox = await Hive.openBox('recentsNotifier');

    await musicDb.clear();
    await playListDb.clear();
    await dbBox.clear();
    RecentSongsController.recentPlayed.clear();
    FavoriteDB.favoriteSongs.value.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }
}
