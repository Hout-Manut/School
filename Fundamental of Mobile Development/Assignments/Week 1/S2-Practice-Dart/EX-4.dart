// Map of pizza prices
const pizzaPrices = {
  'margherita': 5.5,
  'pepperoni': 7.5,
  'vegetarian': 6.5,
};
void main() {
  // Example order
  const order = ['margherita', 'pepperoni', 'pineapple'];

  var totalPrice = getTotalPrice(order);
  print("Total: \$$totalPrice");
}

// Your code
double getTotalPrice(List<String> order) {
  double totalPrice = 0.0;
  order.forEach((key) {
    double? price = pizzaPrices[key];
    if (price != null) {
      totalPrice += price;
    } else {
      print("$key pizza is not on the menu.");
    }
  });
  return totalPrice;
}

