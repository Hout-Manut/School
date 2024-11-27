import 'package:flutter/material.dart';
import 'screens/expenses.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensesScreen(),
    ),
  );
}
