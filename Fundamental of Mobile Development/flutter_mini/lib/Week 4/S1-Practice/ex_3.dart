import 'package:flutter/material.dart';

enum IconPosition { left, right }

enum ButtonType {
  primary(backgroundColor: Colors.blue),
  secondary(backgroundColor: Colors.green),
  disabled(backgroundColor: Color(0xFFE2E2E2), color: Colors.grey);

  const ButtonType({
    required this.backgroundColor,
    this.color = const Color(0xFF575858),
  });

  final Color backgroundColor;
  final Color color;
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Custom buttons")),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            children: [
              CustomButton(
                label: "Submit",
                icon: Icons.check,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                label: "Time",
                icon: Icons.access_time,
                iconPosition: IconPosition.right,
                buttonType: ButtonType.secondary,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                label: "Account",
                icon: Icons.account_tree,
                iconPosition: IconPosition.right,
                buttonType: ButtonType.disabled,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconPosition iconPosition;
  final ButtonType buttonType;

  const CustomButton({
    required this.label,
    required this.icon,
    this.iconPosition = IconPosition.left,
    this.buttonType = ButtonType.primary,
    super.key,
  });

  List<Widget> getChildren() {
    List<Widget> children = [
      Icon(
        icon,
        color: buttonType.color,
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: TextStyle(color: buttonType.color),
      ),
    ];
    if (iconPosition == IconPosition.right) {
      return children.reversed.toList();
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: buttonType.backgroundColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getChildren(),
      ),
    );
  }
}
