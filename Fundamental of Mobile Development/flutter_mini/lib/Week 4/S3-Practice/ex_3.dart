import 'package:flutter/material.dart';

List<String> images = [
  "assets/images/w4/bird.jpg",
  "assets/images/w4/bird2.jpg",
  "assets/images/w4/insect.jpg",
  "assets/images/w4/girl.jpg",
  "assets/images/w4/man.jpg",
];

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Why this line ? Can you explain it ?
      home: GalleryScreen(imagePaths: images)));
}

class GalleryScreen extends StatefulWidget {
  final List<String> imagePaths;

  const GalleryScreen({
    required this.imagePaths,
    super.key,
  });

  @override
  State<GalleryScreen> createState() => _GalleryState();
}

class _GalleryState extends State<GalleryScreen> {
  int currentPage = 0;

  int get imageLength => widget.imagePaths.length;

  void nextPage() {
    setState(() {
      currentPage = (currentPage + 1) % imageLength;
    });
  }

  void previousPage() {
    setState(() {
      if (currentPage == 0) {
        currentPage = imageLength - 1;
      } else {
        currentPage = currentPage - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: previousPage,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next image',
              onPressed: nextPage,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x60000000),
                  offset: Offset(0, 4),
                  blurRadius: 40,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              widget.imagePaths[currentPage],
            ),
          ),
        ),
      ),
    );
  }
}
