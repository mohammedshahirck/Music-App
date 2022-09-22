import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Search',
            style:
                TextStyle(fontSize: 36, color: Color.fromARGB(255, 5, 31, 53)),
          ),
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
                style: const TextStyle(color: Color.fromARGB(255, 5, 31, 53)),
                decoration: InputDecoration(
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
            // Padding(
            //   padding: const EdgeInsets.only(left: 18),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         'Recently',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: const Icon(
            //           Icons.arrow_forward_ios,
            //           size: 20,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: const EdgeInsets.only(
            //     left: 10,
            //   ),
            //   height: 150,
            //   child: GridView.builder(
            //     itemCount: images.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (
            //       BuildContext context,
            //       index,
            //     ) =>
            //         Container(
            //       width: 150,
            //       margin: const EdgeInsets.all(
            //         5,
            //       ),
            //       decoration: BoxDecoration(
            //         image: DecorationImage(
            //           image: AssetImage(
            //             images[index],
            //           ),
            //           fit: BoxFit.fill,
            //         ),
            //         borderRadius: BorderRadius.circular(
            //           20,
            //         ),
            //         color: Colors.blue,
            //       ),
            //       child: const Center(
            //         child: Icon(
            //           Icons.music_note,
            //         ),
            //       ),
            //     ),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 1,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
