import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteDB {
  static bool isInitialized = false;
  static final musicDb = Hive.box<int>('favoriteDB');
  static ValueNotifier<List<SongModel>> favoriteSongs = ValueNotifier([]);

  static initialize(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
        favoriteSongs.value.add(song);
      }
    }
    isInitialized = true;
  }

  static isfavor(SongModel song) {
    if (musicDb.values.contains(song.id)) {
      return true;
    }

    return false;
  }

  static add(SongModel song) async {
    musicDb.add(song.id);
    favoriteSongs.value.add(song);
    FavoriteDB.favoriteSongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }

    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDb.delete(deletekey);
    favoriteSongs.value.removeWhere((song) => song.id == id);
  }
}
