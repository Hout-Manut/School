import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';
import '../data/dummy_items.dart';

enum ListMode {
  normal,
  selection;
}

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = List.from(dummyGroceryItems);
  final Set<int> _selectedItems = {};
  ListMode mode = ListMode.normal;

  void _addItem() {
    Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          onSubmit: (newItem) => setState(() => _groceryItems.add(newItem)),
        ),
      ),
    );
  }

  void _editItem(int index) {
    Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          editItem: _groceryItems[index],
          onSubmit: (newItem) => setState(() => _groceryItems[index] = newItem),
        ),
      ),
    );
  }

  void _enterSelectMode(int index) {
    mode = ListMode.selection;
    _selectedItems.add(index);
    setState(() {});
  }

  void _deleteItems() {
    for (int index in _selectedItems) {
      _groceryItems.removeAt(index);
    }
    _leaveSelectMode();
  }

  void _leaveSelectMode() {
    mode = ListMode.normal;
    _selectedItems.clear();
    setState(() {});
  }

  void _selectItem(int index) {
    if (_selectedItems.contains(index)) {
      _selectedItems.remove(index);
    } else {
      _selectedItems.add(index);
    }
    setState(() {});
  }

  void Function(int) _onTap() {
    switch (mode) {
      case ListMode.normal:
        return _editItem;
      case ListMode.selection:
        return _selectItem;
    }
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    GroceryItem targetItem = _groceryItems.removeAt(oldIndex);
    _groceryItems.insert(newIndex, targetItem);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_groceryItems.isNotEmpty) {
      content = ReorderableListView.builder(
        onReorder: _onReorder,
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(
          key: Key('$index'),
          _groceryItems[index],
          onTap: () => _onTap()(index),
          onLongPress: () => _enterSelectMode(index),
          mode: mode,
          onSelect: () => _selectItem(index),
          selected: _selectedItems.contains(index),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: mode == ListMode.normal
            ? const Text('Your Groceries')
            : Text('${_selectedItems.length} item(s) selected'),
        actions: [
          mode == ListMode.normal
              ? IconButton(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                )
              : IconButton(
                  onPressed: _deleteItems,
                  icon: const Icon(Icons.delete),
                ),
        ],
        leading: mode == ListMode.normal ? null : IconButton(
                  onPressed: _leaveSelectMode,
                  icon: const Icon(Icons.arrow_back),
                ),
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(
    this.groceryItem, {
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.mode,
    required this.onSelect,
    this.selected = false,
  });

  final void Function() onTap;
  final void Function() onLongPress;
  final void Function() onSelect;
  final bool selected;
  final ListMode mode;
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    Widget leading;

    switch (mode) {
      case ListMode.normal:
        leading = Container(
          width: 24,
          height: 24,
          color: groceryItem.category.color,
        );
      case ListMode.selection:
        leading = Checkbox(value: selected, onChanged: (value) => onSelect());
    }

    return ListTile(
      onLongPress: onLongPress,
      title: Text(groceryItem.name),
      leading: leading,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Text(
          groceryItem.quantity.toString(),
        ),
      ),
      onTap: onTap,
    );
  }
}
