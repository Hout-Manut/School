import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../data/dummy_items.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ListView.builder(
          itemCount: dummyGroceryItems.length,
          itemBuilder: (context, index) {
            GroceryItem item = dummyGroceryItems[index];
            return ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: item.category.color),
              ),
              title: Text(item.name),
              subtitle: Text(item.category.label),
              trailing: Icon(Icons.more_vert),
              onTap: () {},
            );
          });

      return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewItem())),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content,
      );
    }
    return content;
  }
}
