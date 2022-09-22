import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/screens/music_list.dart';
import 'package:musicplayer/screens/settings.dart';

final images = [
  'assets/images/93520497.jpg',
  'assets/images/Hridayam.jpg',
  'assets/images/images.jpg',
  'assets/images/mike.jpg',
  'assets/images/shikhar-yadav-alvida-final-poster2.jpg',
  'assets/images/Sita Rama.jpg',
];
final text1 = [
  'Thallumala',
  'Hridayam',
  'Pakaliruvukal',
  'Mike',
  'Alvida',
  'Seeta Rama',
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(
        0,
        0,
        0,
        0,
      ),
      body: StreamBuilder(
          builder: (
        BuildContext context,
        item,
      ) =>
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Text('Hi There...\nShahir',
                              style: GoogleFonts.sniglet(
                                fontSize: 25,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Albums',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      height: MediaQuery.of(context).size.height * .16,
                      child: GridView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (
                          BuildContext context,
                          index,
                        ) =>
                            Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .13,
                              width: MediaQuery.of(context).size.height * .13,
                              margin: const EdgeInsets.all(
                                1,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.music_note,
                                ),
                              ),
                            ),
                            Text(text1[index]),
                          ],
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Artists',
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      height: 100,
                      child: GridView.builder(
                        itemCount: images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (
                          BuildContext context,
                          index,
                        ) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(images[index]),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}