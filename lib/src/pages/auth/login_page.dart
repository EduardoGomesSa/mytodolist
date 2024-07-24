import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFieldWidget(
                      controller: emailTextController,
                      icon: Icons.email,
                      label: 'Email',
                    ),
                    TextFieldWidget(
                      controller: passwordTextController,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                    ),
                    SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Entrar'),
                        )),
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
                    SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue)),
                        child: const Text('Não tem uma conta? Crie aqui'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
