import 'package:flutter/material.dart';
import '../models/grocery_category.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _nameValidator(String? newString) {
    if (newString == null || newString.isEmpty) {
      return "Name cannot be empty.";
    }
    return null;
  }
  String? _quantityValidator(String? newQuantity) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: _nameValidator,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: _quantityValidator,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: '1',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      validator: (category) {
                        if (category == null){
                          return "Please select a category";
                        }
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
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => {_formKey.currentState!.reset()},
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      if (_formKey.currentState!.validate()) {}
                    },
                    child: const Text('Add Item'),
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
