import 'package:flutter/material.dart';

enum GroceryCategory {
  vegetables('Vegetables', Color.fromARGB(255, 0, 255, 128)),
  fruit('Fruit', Color.fromARGB(255, 145, 255, 0)),
  meat('Meat', Color.fromARGB(255, 255, 102, 0)),
  dairy('Dairy', Color.fromARGB(255, 0, 208, 255)),
  carbs('Carbs', Color.fromARGB(255, 0, 60, 255)),
  sweets('Sweets', Color.fromARGB(255, 255, 149, 0)),
  spices('Spices', Color.fromARGB(255, 255, 187, 0)),
  convenience('Convenience', Color.fromARGB(255, 191, 0, 255)),
  hygiene('Hygiene', Color.fromARGB(255, 149, 0, 255)),
  other('Other', Color.fromARGB(255, 0, 225, 255));

  final String label;
  final Color color;

  const GroceryCategory(this.label, this.color);
}
