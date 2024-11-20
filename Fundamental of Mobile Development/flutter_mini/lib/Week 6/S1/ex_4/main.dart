import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'jokes.dart';
import 'joke_provider.dart';

Color appColor = Colors.green[300] as Color;

void main() {
  runApp(MaterialApp(home: JokeScreen(jokes)));
}

class JokeScreen extends StatefulWidget {
  final List<Joke> jokes;
  const JokeScreen(this.jokes, {super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => JokeProvider(),
        child: ListView(
          children: [
            for (Joke joke in widget.jokes) JokeCard(joke),
          ],
        ),
      ),
    );
  }
}

class JokeCard extends StatelessWidget {
  final Joke joke;
  const JokeCard(this.joke, {super.key});

  @override
  Widget build(BuildContext context) {
    final providerJoke = Provider.of<JokeProvider>(context);
    bool isFavorite = providerJoke.favoriteJoke == joke;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.question,
                  style: TextStyle(color: appColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  joke.punchline,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: () => providerJoke.favoriteJoke = joke,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ))
        ],
      ),
    );
  }
}
