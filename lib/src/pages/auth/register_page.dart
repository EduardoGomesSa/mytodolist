import 'package:flutter/material.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Column(
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
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(45),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TextFieldWidget(
                  label: 'nome',
                  icon: Icons.person,
                ),
                const TextFieldWidget(
                  label: 'email',
                  icon: Icons.email,
                ),
                const TextFieldWidget(
                  label: 'senha',
                  icon: Icons.lock,
                  isSecret: true,
                ),
                const TextFieldWidget(
                  label: 'confirmar senha',
                  icon: Icons.lock,
                  isSecret: true,
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cadastrar'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
