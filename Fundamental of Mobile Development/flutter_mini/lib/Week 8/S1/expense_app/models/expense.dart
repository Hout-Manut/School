import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

enum ExpenseType {
  food(Icons.fastfood),
  travel(Icons.local_airport),
  leisure(Icons.confirmation_number_sharp),
  work(Icons.work);

  const ExpenseType(this.icon);

  final IconData icon;
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  Expense.food({
    required this.title,
    required this.amount,
    required this.date,
  })  : category = ExpenseType.work,
        id = uuid.v4();

  Expense.travel({
    required this.title,
    required this.amount,
    required this.date,
  })  : category = ExpenseType.travel,
        id = uuid.v4();

  Expense.leisure({
    required this.title,
    required this.amount,
    required this.date,
  })  : category = ExpenseType.leisure,
        id = uuid.v4();

  Expense.work({
    required this.title,
    required this.amount,
    required this.date,
  })  : category = ExpenseType.work,
        id = uuid.v4();
}
