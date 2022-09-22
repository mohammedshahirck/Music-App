// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
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
  Duration _duration = const Duration();
  Duration _position = const Duration();

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
    MusicStore.player.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    MusicStore.player.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
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
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * .75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: QueryArtworkWidget(
              artworkFit: BoxFit.fill,
              keepOldArtwork: true,
              artworkBorder: BorderRadius.circular(20),
              id: widget.playerSong[currentIndex].id,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * .75,
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
          const SizedBox(
            height: 30,
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            widget.playerSong[currentIndex].displayNameWOExt,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            // "${widget.songModel.artist}",

            widget.playerSong[currentIndex].artist.toString() == "<unknown>"
                ? "Unknown Artist"
                : widget.playerSong[currentIndex].artist.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * .01,
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(_position.toString().split(".")[0]),
              ),
              Expanded(
                child: Slider(
                  min: const Duration(microseconds: 0).inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  max: _duration.inSeconds.toDouble(),
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
                child: Text(_duration.toString().split(".")[0]),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.repeat),
                ),
                RawMaterialButton(
                  onPressed: () {},
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
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.skip_next,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shuffle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FavoriteBut(song: widget.playerSong[currentIndex]),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.playlist_add),
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
