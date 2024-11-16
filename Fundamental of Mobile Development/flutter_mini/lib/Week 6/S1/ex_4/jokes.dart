List<Joke> jokes = [
  Joke("Why don’t skeletons fight each other?", "They don’t have the guts."),
  Joke("What do you call fake spaghetti?", "An impasta."),
  Joke("Why don’t eggs tell jokes?", "They’d crack each other up."),
  Joke("What do you call cheese that isn’t yours?", "Nacho cheese."),
  Joke(
      "Why can’t your nose be 12 inches long?", "Because then it’d be a foot."),
  Joke("What’s orange and sounds like a parrot?", "A carrot."),
  Joke("Why did the bicycle fall over?", "It was two tired."),
  Joke("What’s brown and sticky?", "A stick."),
  Joke("Why don’t scientists trust atoms?", "Because they make up everything."),
  Joke("Why did the scarecrow win an award?",
      "He was outstanding in his field."),
  Joke("What do you call a bear with no teeth?", "A gummy bear."),
  Joke("How do you organize a space party?", "You planet."),
  Joke("Why did the golfer bring two pairs of pants?",
      "In case he got a hole in one."),
  Joke("Why are ghosts bad liars?", "Because you can see right through them."),
  Joke("What do you call a snowman with a six-pack?", "An abdominal snowman."),
];

class Joke {
  final String question;
  final String punchline;

  Joke(this.question, this.punchline);
}
