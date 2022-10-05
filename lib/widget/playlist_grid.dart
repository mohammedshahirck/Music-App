import 'package:flutter/material.dart';

class PlaylistGrid extends StatelessWidget {
  const PlaylistGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo.shade200,
            // image: DecorationImage(
            //   image: AssetImage(images[index]),
            //   fit: BoxFit.fill,
            // ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Icon(
              Icons.playlist_play,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ],
    );
  }
}
