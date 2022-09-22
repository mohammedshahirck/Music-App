import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      // scrollDirection: Axis.horizontal,
      itemBuilder: (
        BuildContext context,
        index,
      ) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 170,
            child: Container(
              height: 170,
              width: 170,
              margin: const EdgeInsets.all(
                5,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  stops: [
                    .3,
                    .5,
                    .7,
                  ],
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueGrey,
                    Colors.white10,
                    Colors.blueGrey,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: MediaQuery.of(context).size.aspectRatio * 100,
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
          Text('song$index'),
        ],
      ),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }
}
