import 'package:flutter/material.dart';
import 'screen/device_converter.dart';
 
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 252, 115, 47),
                Color.fromARGB(255, 201, 79, 17),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const DeviceConverter(),
        ),
      ),
    ));
}
