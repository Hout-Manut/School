import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Container(
        padding: const EdgeInsets.all(50),
        margin: const EdgeInsets.all(40),
        color: Colors.blue[300],
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: const Center(
            child: Text(
              "CADT STUDENTS",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

// Scaffold acts as a base of the app, allowing changes like background color and app bar.
