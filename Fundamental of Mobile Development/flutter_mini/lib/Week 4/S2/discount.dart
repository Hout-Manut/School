import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: DiscountCard(price: 100),
      ),
    ),
  ));
}

class DiscountCard extends StatefulWidget {
  final double price;
  final double discountRate;

  String getPriceString(bool discount) {
    if (discount) {
      return "\$${price - (price * discountRate)}";
    }
    return "\$$price";
  }

  const DiscountCard({
    required this.price,
    this.discountRate = 0.25,
    super.key,
  });

  @override
  State<DiscountCard> createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  bool discounted = false;
  late String displayPrice;

  @override
  void initState() {
    super.initState();
    displayPrice = widget.getPriceString(discounted);
  }

  void onPress() {
    setState(() {
      discounted = true;
      displayPrice = widget.getPriceString(discounted);
    });
  }


  Color? get backgroundColor => !discounted ? Colors.grey[900] : const Color.fromARGB(255, 255, 40, 194);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 200,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              displayPrice,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Text(
              !discounted ? "No Discount" : "Discount !",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: 20,),
          Center(

            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white),
                fixedSize: Size(150, 25),
              ),
              onPressed: onPress,
              child: Text(
                "Apply Discount", style: TextStyle(fontSize:  16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
