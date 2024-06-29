import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.isSecret,
  });

  final String label;
  final IconData icon;
  final bool isSecret;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: isSecret,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: label,
            isDense: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(18))),
      ),
    );
  }
}
