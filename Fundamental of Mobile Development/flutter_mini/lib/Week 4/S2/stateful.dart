import 'dart:math';

import 'package:flutter/material.dart';

List<Image> diceImages = [
  Image.asset(
    'assets/images/dice-1.png',
    width: 200,
  ),
  Image.asset(
    'assets/images/dice-2.png',
    width: 200,
  ),
  Image.asset(
    'assets/images/dice-3.png',
    width: 200,
  ),
  Image.asset(
    'assets/images/dice-4.png',
    width: 200,
  ),
  Image.asset(
    'assets/images/dice-5.png',
    width: 200,
  ),
  Image.asset(
    'assets/images/dice-6.png',
    width: 200,
  ),
];

Random rand = Random();

// String activeDiceImage = diceImage2;

// class DiceRoller extends StatelessWidget {
//   const DiceRoller({super.key});

//   @override
//   Widget build(context) {
// }

void main() => runApp(
      const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepPurple,
          body: Center(child: DiceScreen()),
        ),
      ),
    );

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceScreen> {
  late Image activeDiceImage;

  void rollDice() {
    int outcome = rand.nextInt(6);
    activeDiceImage = diceImages[outcome];
  }

  void reroll() {
    setState(() {
      rollDice();
    });
  }

  @override
  void initState() {
    rollDice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: reroll,
          child: activeDiceImage,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: reroll,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
