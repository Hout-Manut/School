import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Favorite cards"),
      ),
      body: Column(
        children: [
          FavoriteCard(title: "title", description: "description"),
          FavoriteCard(title: "title", description: "description"),
          FavoriteCard(title: "title", description: "description"),
          FavoriteCard(title: "title", description: "description"),
        ],
      ),
    ),
  ));
}

class FavoriteCard extends StatefulWidget {
  final String title;
  final String description;

  const FavoriteCard({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool isFavorite = false;

  Icon get icon {
    if (isFavorite) {
      return Icon(
        Icons.favorite,
        color: Colors.red,
      );
    }
    return Icon(Icons.favorite_border, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() {
              isFavorite = !isFavorite;
            }),
            icon: icon,
          )
        ],
      ),
    );
  }
}
