import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmedController = TextEditingController();

  final controller = Get.find<AuthController>();

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
                TextFieldWidget(
                  label: 'nome',
                  icon: Icons.person,
                  controller: nameTextController,
                ),
                TextFieldWidget(
                  label: 'email',
                  icon: Icons.email,
                  controller: emailTextController,
                ),
                TextFieldWidget(
                  label: 'senha',
                  icon: Icons.lock,
                  isSecret: true,
                  controller: passwordTextController,
                ),
                TextFieldWidget(
                  label: 'confirmar senha',
                  icon: Icons.lock,
                  isSecret: true,
                  controller: passwordConfirmedController,
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
