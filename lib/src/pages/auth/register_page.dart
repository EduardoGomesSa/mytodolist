import 'package:flutter/material.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        const Expanded(
          child: Column(
            children: [
              Text('Logo'
          )
        ],
      ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 40,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(45))
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWidget(label: 'nome', icon: Icons.person),
            TextFieldWidget(
              label: 'email', icon: Icons.email
            ),
            TextFieldWidget(label: 'senha', icon: Icons.lock, isSecret: true,),
            TextFieldWidget(label: 'confirmar senha', icon: Icons.lock, isSecret: true,),
          ],
        ),
      ),
    ],
    ),);
  }
}