import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final formatter = DateFormat.yMd();

  ///
  /// This regex is used to validate value input by allowing digits and only 0 or 1 `decimal point (.)`.
  ///
  /// `\d*` matches 0 to any amount digits, `\.?` matches 0 or 1 of `.`, followed by another `\d*`.\
  /// `^` and `$` marks the start and end of the string.
  ///
  final _valueRegExp = RegExp(r'^-?\d*\.?\d*$');
  // Track the last value, if the new value does not pass the regex, revert it back.
  String _lastValue = "";
  String get title => _titleController.text;

  Category _selectedCategory = Category.food;

  DateTime? selectedDate;

  String get formattedDate {
    return selectedDate == null
        ? "No date selected"
        : formatter.format(selectedDate!);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    // Close modal
    Navigator.pop(context);
  }

  Future<void> _alert(Widget content) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Invalid Input"),
          content: content,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("k bro", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void onAdd() {
    // 1- Get the values from inputs
    String title = _titleController.text;
    String amountString = _valueController.text;

    // 2-1 Validate, use the message as valid flag where null = pass
    Widget? warningContent;
    if (title == "" && amountString == "") {
      warningContent = Text("The title and amount cannot be empty.");
    } else if (title == "") {
      warningContent = Text("The title cannot be empty.");
    } else if (amountString == "") {
      warningContent = Text("The amount cannot be empty");
    } else if (amountString.startsWith("-")) {
      warningContent = Text("The amount cannot be a negative number.");
    }

    // 2-2 Not null means it's not valid.
    if (warningContent != null) {
      _alert(warningContent);
      // Exit the function.
      return;
    }

    // 3- Parse the value, this will never throw an exception.
    double amount = double.parse(amountString);

    // 4- Create the expense
    Expense expense = Expense(
        title: title,
        amount: amount,
        date: selectedDate ?? DateTime.now(),
        category: _selectedCategory);

    // 5- Ask the parent to add the expense
    widget.onCreated(expense);

    // 6- Close modal
    Navigator.pop(context);
  }

  /// A filter to allow a decimal point in the input.
  void filterValueInput(String newString) {
    // the current cursor position.
    TextSelection cursorLocation = _valueController.selection;
    if (_valueRegExp.hasMatch(newString)) {
      // if the new string passes the regex. accept the new string.
      _valueController.text = newString;

      // put the cursor back.
      _valueController.selection =
          TextSelection.collapsed(offset: cursorLocation.baseOffset);

      // override the last value to this string.
      _lastValue = newString;
    } else {
      // revert the value back.
      _valueController.text = _lastValue;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              focusColor: Colors.blue,
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: filterValueInput,
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.digitsOnly,
            // ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              focusColor: Colors.blue,
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: _selectedCategory,
                onChanged: (Category? newCategory) => setState(() {
                  _selectedCategory = newCategory!;
                }),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blueAccent,
                ),
                items: Category.values
                    .map<DropdownMenuItem<Category>>(
                      (category) => DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(formattedDate),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: onAdd, child: const Text('Create')),
            ],
          )
        ],
      ),
    );
  }
}
