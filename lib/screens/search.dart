import 'package:flutter/material.dart';
import 'package:musicplayer/screens/all_music.dart';
import 'package:musicplayer/screens/now_playing.dart';
import 'package:musicplayer/widget/music_store.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  late List<SongModel> _allSongs;
  List<SongModel> _getedSongs = [];

  void loadAllSongList() async {
    _allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    _getedSongs = _allSongs;
  }

  void search(String typedKeyword) {
    List<SongModel> results = [];
    if (typedKeyword.isEmpty) {
      results = _allSongs;
    } else {
      results = _allSongs
          .where(
            (element) => element.title.toLowerCase().contains(
                  typedKeyword.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      _getedSongs = results;
    });
  }

  @override
  void initState() {
    loadAllSongList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                onChanged: (String value) => search(value),
                style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: const Color.fromARGB(255, 215, 214, 215),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 5, 31, 53),
                  ),
                ),
              ),
            ),
            (_getedSongs.isEmpty)
                ? Container()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _getedSongs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: _getedSongs[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.blueGrey,
                                    Colors.white,
                                    Colors.black
                                  ],
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
                          title: Text(
                            _getedSongs[index].title,
                          ),
                          subtitle: Text(
                            "${_getedSongs[index].artist}",
                            maxLines: 1,
                          ),
                          onTap: () {
                            _getedSongs;
                            FocusScope.of(context).unfocus();
                            MusicStore.player.setAudioSource(
                              MusicStore.createSongList(AllMusic.song),
                              initialIndex: index,
                            );
                            MusicStore.player.play();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NowPlaying(playerSong: AllMusic.song)));
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
