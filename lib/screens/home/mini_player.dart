import 'package:flutter/material.dart';
import 'package:musicplayer/custom_widget/text_animation.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    MusicStore.player.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: const Color.fromARGB(255, 216, 231, 244),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: MediaQuery.of(context).size.height * 0.08,
      width: double.infinity,

      ///height: 70,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NowPlaying(
                playerSong: MusicStore.playingSong,
              ),
            ),
          );
        },
        iconColor: const Color.fromARGB(255, 180, 147, 147),
        textColor: const Color.fromARGB(255, 9, 9, 9),
        leading: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: CircleAvatar(
              child: QueryArtworkWidget(
                artworkQuality: FilterQuality.high,
                artworkFit: BoxFit.fill,
                artworkBorder: BorderRadius.circular(30),
                nullArtworkWidget: CircleAvatar(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.blueGrey, Colors.white, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.music_note_rounded,
                      color: Colors.blueGrey[600],
                    ),
                  ),
                ),
                id: MusicStore.playingSong[MusicStore.player.currentIndex!].id,
                type: ArtworkType.AUDIO,
              ),
            ),
          ),
        ),
        title: AnimatedText(
          text: MusicStore
              .playingSong[MusicStore.player.currentIndex!].displayNameWOExt,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            "${MusicStore.playingSong[MusicStore.player.currentIndex!].artist}",
            style:
                const TextStyle(fontSize: 11, overflow: TextOverflow.ellipsis),
          ),
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  if (MusicStore.player.playing) {
                    await MusicStore.player.pause();
                    setState(() {});
                  } else {
                    await MusicStore.player.play();
                    setState(() {});
                  }
                },
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
              IconButton(
                  onPressed: (() async {
                    if (MusicStore.player.hasNext) {
                      await MusicStore.player.seekToNext();
                      await MusicStore.player.play();
                    } else {
                      await MusicStore.player.play();
                    }
                  }),
                  icon: const Icon(
                    Icons.skip_next,
                    size: 35,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
