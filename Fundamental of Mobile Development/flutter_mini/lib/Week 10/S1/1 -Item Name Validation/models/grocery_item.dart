import 'grocery_category.dart';

class GroceryItem {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final GroceryCategory category;

  @override
  String toString() {
    return 'GroceryItem(id: $id, name: $name, quantity: $quantity, category: $category)';
  }
}
