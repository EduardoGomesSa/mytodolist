import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(45))),
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
                ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 15),
                  child: Row(children: [
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Ou',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.grey,
                    )),
                  ]),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.register);
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue)),
                  child: const Text('Não tem uma conta? Crie aqui'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
