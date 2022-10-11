import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/database/favorite_db.dart';
import 'package:musicplayer/widget/favoritebutton.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key, required this.playerSong});
  final List<SongModel> playerSong;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration position = const Duration();
  Duration musicLength = const Duration();

  bool _isPlaying = true;
  int currentIndex = 0;

  String time(Duration duration) {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    final hours = twodigits(duration.inHours);
    final minutes = twodigits(
      duration.inMinutes.remainder(60),
    );
    final seconds = twodigits(
      duration.inSeconds.remainder(60),
    );

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }

  Widget slider() => Slider.adaptive(
      thumbColor: Colors.blueGrey[900],
      activeColor: Colors.blueGrey,
      inactiveColor: Colors.blueGrey[200],
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: ((value) {
        onchanged(value.toInt());
        value = value;
      }));

  @override
  void initState() {
    MusicStore.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {
          currentIndex = index;
        });
      }
    });
    super.initState();
    playSongs();
  }

  void playSongs() {
    MusicStore.player.durationStream.listen((Duration? d) {
      try {
        if (mounted) {
          if (d == null) {
            return;
          }
          setState(() {
            musicLength = d;
          });
        }
      } catch (e) {
        log(e.toString());
      }
    });

    MusicStore.player.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          position = p;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            FavoriteDB.favoriteSongs.notifyListeners();
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
          ),
        ),
        // actions: const [],
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * .65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: QueryArtworkWidget(
              quality: 100,
              artworkFit: BoxFit.fill,
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(20),
              id: widget.playerSong[currentIndex].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * .75,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * .75,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: MediaQuery.of(context).size.aspectRatio * 80,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: MediaQuery.of(context).size.aspectRatio * 93,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: MediaQuery.of(context).size.aspectRatio * 88,
                        child: Icon(
                          Icons.music_note_rounded,
                          size: 60,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            widget.playerSong[currentIndex].title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            widget.playerSong[currentIndex].artist.toString() == "<unknown>"
                ? "Unknown Artist"
                : widget.playerSong[currentIndex].artist.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          slider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time(position),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  time(musicLength - position),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.volume_up),
                  color: Colors.black,
                  onPressed: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust volume",
                      divisions: 10,
                      min: 0,
                      max: 1,
                      value: MusicStore.player.volume,
                      stream: MusicStore.player.volumeStream,
                      onChanged: MusicStore.player.setVolume,
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {
                      MusicStore.player.loopMode == LoopMode.one
                          ? MusicStore.player.setLoopMode(LoopMode.off)
                          : MusicStore.player.setLoopMode(LoopMode.one);
                    },
                    child: StreamBuilder<LoopMode>(
                      stream: MusicStore.player.loopModeStream,
                      builder: (context, snapshot) {
                        final loopMode = snapshot.data;
                        if (LoopMode.one == loopMode) {
                          return const Icon(
                            Icons.repeat_one,
                            color: Colors.black,
                            size: 25,
                          );
                        } else {
                          return const Icon(
                            Icons.repeat,
                            color: Colors.black,
                            size: 25,
                          );
                        }
                      },
                    )),
                RawMaterialButton(
                  onPressed: () async {
                    if (MusicStore.player.hasPrevious) {
                      _isPlaying = true;
                      await MusicStore.player.seekToPrevious();
                      await MusicStore.player.play();
                    } else {
                      await MusicStore.player.play();
                    }
                  },
                  elevation: 5.0,
                  fillColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.skip_previous_sharp,
                    size: 20.0,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      setState(() {});
                      MusicStore.player.pause();
                    } else {
                      MusicStore.player.play();
                    }
                    _isPlaying = !_isPlaying;
                    setState(() {});
                  },
                  elevation: 5.0,
                  fillColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: StreamBuilder<bool>(
                    stream: MusicStore.player.playingStream,
                    builder: (context, snapshot) {
                      bool? playingStage = snapshot.data;
                      if (playingStage != null && playingStage) {
                        return const Icon(
                          Icons.pause,
                          size: 35,
                        );
                      } else {
                        return const Icon(
                          Icons.play_arrow,
                          size: 35,
                        );
                      }
                    },
                  ),
                ),
                RawMaterialButton(
                  onPressed: () async {
                    if (MusicStore.player.hasNext) {
                      _isPlaying = true;
                      await MusicStore.player.seekToNext();
                      await MusicStore.player.play();
                    } else {
                      await MusicStore.player.play();
                    }
                  },
                  elevation: 2.0,
                  fillColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.skip_next,
                    size: 20,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.shuffle,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FavoriteBut(song: widget.playerSong[currentIndex]),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.playlist_add),
              ),
            ],
          )
        ],
      )),
    );
  }

  void onchanged(int seconds) {
    Duration duration = Duration(seconds: seconds);
    MusicStore.player.seek(duration);
  }
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                thumbColor: Colors.blueGrey[900],
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey[200],
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
