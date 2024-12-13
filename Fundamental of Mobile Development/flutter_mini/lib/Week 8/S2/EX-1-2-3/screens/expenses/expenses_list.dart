import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onExpenseRemoved,
  });

  final List<Expense> expenses;

  final void Function(Expense, int) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: expenses.isEmpty ? Center(child: Text("No expenses found. Start adding some!")) : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) => onExpenseRemoved(expenses[index], index),
          key: Key(expenses[index].id),
          child: ExpenseItem(expenses[index]),
        ),
      ),
    );
  }
}
