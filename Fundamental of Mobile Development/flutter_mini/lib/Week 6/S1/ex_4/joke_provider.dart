import 'package:flutter/material.dart';

import 'jokes.dart';

class JokeProvider with ChangeNotifier {
  Joke? _favoriteJoke;

  Joke? get favoriteJoke => _favoriteJoke;

  set favoriteJoke(Joke? newJoke) {
    if (newJoke != _favoriteJoke) {
      _favoriteJoke = newJoke;
    } else {
      _favoriteJoke = null;
    }
    notifyListeners();
  }
}
