// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentSongsController {
  static ValueNotifier<List<SongModel>> recentsNotifier = ValueNotifier([]);
  static List<dynamic> recentPlayed = [];

  static Future<void> addRecentlyPlayed(item) async {
    final dbBox = await Hive.openBox('recentsNotifier');
    await dbBox.add(item);
    getRecentSongs();
    recentsNotifier.notifyListeners();
  }

  static Future<void> getRecentSongs() async {
    final dbBox = await Hive.openBox('recentsNotifier');
    recentPlayed = dbBox.values.toList();
    displayRecents();
    recentsNotifier.notifyListeners();
  }

  static Future<void> displayRecents() async {
    final dbBox = await Hive.openBox('recentsNotifier');
    final recentsItems = dbBox.values.toList();
    recentsNotifier.value.clear();
    recentPlayed.clear();
    for (int i = 0; i < recentsItems.length; i++) {
      for (int j = 0; j < AllMusic.song.length; j++) {
        if (recentsItems[i] == AllMusic.song[j].id) {
          recentsNotifier.value.add(AllMusic.song[j]);
          recentPlayed.add(AllMusic.song[j]);
        }
      }
    }
    recentPlayed.reversed.toList();
    // recentsNotifier.notifyListeners();
  }
}
