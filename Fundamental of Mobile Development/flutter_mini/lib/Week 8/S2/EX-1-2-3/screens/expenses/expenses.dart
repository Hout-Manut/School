import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expenses_form.dart';
import 'expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  // tracks the removed expense with their index.
  final List<(int, Expense)> _removedExpenses = [];

  void onExpenseRemoved(Expense expense, int index) {
    _removedExpenses.add((index, expense));
    _registeredExpenses.remove(expense);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted."),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: "Undo",
        onPressed: undo,
        textColor: Colors.blue[100],
      ),
    ));
    setState(() {});
  }

  void onExpenseCreated(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(
        onCreated: onExpenseCreated,
      ),
    );
  }

  void undo() {
    setState(() {
      // get the last removed expense.
      (int, Expense) redoExpense = _removedExpenses.removeLast();
      _registeredExpenses.insert(redoExpense.$1, redoExpense.$2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddPressed,
          )
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: ExpensesList(
        expenses: _registeredExpenses,
        onExpenseRemoved: onExpenseRemoved,
      ),
    );
  }
}
