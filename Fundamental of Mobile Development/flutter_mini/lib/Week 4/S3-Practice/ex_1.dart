import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Custom buttons"),
      ),
      body: Column(
        children: [
          Center(child: SelectionButton()),
          SizedBox(height: 10),
          Center(child: SelectionButton()),
          SizedBox(height: 10),
          Center(child: SelectionButton()),
          SizedBox(height: 10),
          Center(child: SelectionButton()),
        ],
      ),
    ),
  ));
}

class SelectionButton extends StatefulWidget {
  static const Color textColor = Colors.black;
  static const Color selectedTextColor = Colors.white;
  static const Color buttonColor = Color(0xFFE3F2FD); // Same as blue[50]
  static const Color selectedButtonColor = Color(0xFF2196F3); // blue[500]

  const SelectionButton({super.key});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  bool selected = false;

  String get label => selected ? "Selected" : "Not selected";

  Color get textColor =>
      selected ? SelectionButton.selectedTextColor : SelectionButton.textColor;
  Color get buttonColor => selected
      ? SelectionButton.selectedButtonColor
      : SelectionButton.buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 100,
      child: ElevatedButton(
          onPressed: () => setState(() {
                selected = !selected;
              }),
          style: ElevatedButton.styleFrom(
              foregroundColor: textColor, backgroundColor: buttonColor),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 32,
            ),
          )),
    );
  }
}
