import 'package:flutter/material.dart';

enum Products {
  dart(
      title: "Dart",
      description: "the best object language",
      imagePath: "images/dart.png"),
  flutter(
      title: "Flutter",
      description: "the best mobile widet library",
      imagePath: "images/flutter.png"),
  firebase(
      title: "Firebase",
      description: "the best cloud database",
      imagePath: "images/firebase.png");

  final String title;
  final String description;
  final String imagePath;

  const Products(
      {required this.title,
      required this.description,
      required this.imagePath});
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Container(
        color: Colors.blue,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductCard(product: Products.dart),
              SizedBox(height: 10),
              ProductCard(product: Products.flutter),
              SizedBox(height: 10),
              ProductCard(product: Products.firebase),
            ],
          ),
        ),
      ),
    ),
  ));
}

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product.imagePath,
            height: 100,
          ),
          Text(product.title, style: const TextStyle(fontSize: 38)),
          Text(product.description, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
