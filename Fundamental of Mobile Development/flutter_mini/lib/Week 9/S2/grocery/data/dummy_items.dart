
import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

final dummyGroceryItems = [
  const GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: GroceryCategory.dairy),
  const GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: GroceryCategory.fruit),
  const GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: GroceryCategory.meat),
];
