import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  Duration duration = const Duration();
  Duration position = const Duration();

  bool _isPlaying = true;
  int currentIndex = 0;

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
    playSong();
  }

  void playSong() {
    MusicStore.player.durationStream.listen(
      (d) {
        if (mounted) {
          setState(() {
            duration = d!;
          });
        }
      },
    );

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
          },
          icon: const Icon(Icons.arrow_back_ios_new),
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(position.toString().split(".")[0]),
              ),
              Expanded(
                child: Slider(
                  min: const Duration(microseconds: 0).inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  max: duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      changeToSeconds(value.toInt());
                      value = value;
                    });
                  },
                  thumbColor: Colors.blueGrey[900],
                  activeColor: Colors.blueGrey,
                  inactiveColor: Colors.blueGrey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(duration.toString().split(".")[0]),
              ),
            ],
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
                  onPressed: () {
                    setState(() {
                      if (_isPlaying) {
                        MusicStore.player.pause();
                      } else {
                        MusicStore.player.play();
                      }
                      _isPlaying = !_isPlaying;
                      setState(() {});
                    });
                  },
                  elevation: 5.0,
                  fillColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 35.0,
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
                  child: Icon(
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

  void changeToSeconds(int seconds) {
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
