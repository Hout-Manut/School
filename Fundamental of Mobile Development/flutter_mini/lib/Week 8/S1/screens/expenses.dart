import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredItems = [];

  @override
  void initState() {
    _registeredItems.add(
      Expense.work(
          title: "Flutter Course", amount: 19.99, date: DateTime.now()),
    );
    _registeredItems.add(
      Expense.leisure(title: "Cinema", amount: 15.69, date: DateTime.now()),
    );
    super.initState();
  }

  void onAdd() {
    showModalBottomSheet(context: context, builder: (context) {
      return Text("hello");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text("Expense App"),
        actions: [IconButton(onPressed: onAdd, icon: const Icon(Icons.add))],
      ),
      backgroundColor: Colors.blue.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ExpensesList(registeredItems: _registeredItems),
        ),
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  final List<Expense> _registeredItems;
  ExpensesList({super.key, required List<Expense> registeredItems})
      : _registeredItems = List<Expense>.unmodifiable(registeredItems);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _registeredItems.length,
      itemBuilder: (context, index) =>
          ExpenseItem(index: index, data: _registeredItems[index]),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final Expense data;
  final int index;
  const ExpenseItem({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black.withAlpha(80),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 64,
                  height: 80,
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("\$${data.amount}"),
                  ],
                ),
              ],
            ),
          Row(children: [],)
          ],
        ),
      ),
    );
  }
}
