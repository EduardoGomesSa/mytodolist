import 'package:flutter/material.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Logo')],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TextFieldWidget(
                  icon: Icons.email,
                  label: 'email',
                ),
                const TextFieldWidget(
                  icon: Icons.lock,
                  label: 'password',
                  isSecret: true,
                ),

                OutlinedButton(onPressed: (){}, child: const Text('Entrar'))
              ],
            ),
          )
        ],
      ),
    );
  }
}