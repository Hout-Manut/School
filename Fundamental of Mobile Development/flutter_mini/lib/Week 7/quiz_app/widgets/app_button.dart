import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton(
    this.label, {
    super.key,
    required this.onTap,
    this.icon,
  });

  final IconData? icon;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
        ));
  }
}
