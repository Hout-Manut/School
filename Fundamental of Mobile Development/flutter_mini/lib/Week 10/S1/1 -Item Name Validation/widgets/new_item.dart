import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

Uuid uuid = Uuid();


class NewItem extends StatefulWidget {
  final NewItemMode mode;
  final GroceryItem? editItem;
  final void Function(GroceryItem) onSubmit;

  const NewItem({
    super.key,
    required this.onSubmit,
    this.mode = NewItemMode.create,
    this.editItem,
  });

  const NewItem.edit({
    super.key,
    required this.onSubmit,
    required this.editItem,
    this.mode = NewItemMode.edit,
  });

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

enum NewItemMode {
  create,
  edit;
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();
  
  String _enteredName = '';
  String _enteredQuantity = '1';
  GroceryCategory? _selectedCategory;
  late String _id;

  @override
  void initState() {
    if (widget.mode == NewItemMode.edit) {
      _enteredName = widget.editItem!.name;
      _enteredQuantity = widget.editItem!.quantity.toString();
      _selectedCategory = widget.editItem!.category;
      _id = widget.editItem!.id;
    } else {
      _id = uuid.v4();
    }
    super.initState();
  }

  void _saveItem() {
    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      // 2 - Save the form to get last entered values
      _formKey.currentState!.save();

      GroceryItem newItem = GroceryItem(
        id: _id,
        name: _enteredName,
        quantity: int.parse(_enteredQuantity),
        category: _selectedCategory!,
      );
      // print(newItem);
      widget.onSubmit(newItem);
      Navigator.pop(context);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  String? validateTitle(String? value) {
    if (value == null ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateQuantity(String? newQuantity) {
    int? quantity = int.tryParse(newQuantity ?? "");
    if (quantity == null) {
      return "Enter a number.";
    } else if (quantity < 1) {
      return "Quantity must be a positive number.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String submit;
    switch (widget.mode) {
      case NewItemMode.create:
        title = "Add a new item";
        submit = "Add Item";
      case NewItemMode.edit:
        title = "Edit an item";
        submit = "Edit Item";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _enteredQuantity,
                      validator: validateQuantity,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      onSaved: (value) {
                        _enteredQuantity = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: _selectedCategory,
                      validator: (value) {
                        if (value == null) return "Select a category";
                        return null;
                      },
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCategory = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text(submit),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
