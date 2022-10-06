// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:musicplayer/model/music_player_model.dart';

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
}
