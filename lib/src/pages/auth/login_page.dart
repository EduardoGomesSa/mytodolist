import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
import 'package:mytodolist/src/core/services/validators.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text('Funcionou PORRAAAAA'),
    // );
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Logo'),
                  ),
                ],
              ),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                    controller: emailTextController,
                    icon: Icons.email,
                    label: 'Email',
                    validator: emailvalidator,
                  ),
                  TextFieldWidget(
                    controller: passwordTextController,
                    icon: Icons.lock,
                    label: 'Senha',
                    isSecret: true,
                    validator: passwordValidator,
                  ),
                  SizedBox(
                      height: 50,
                      child: GetX<AuthController>(builder: (controller) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    controller.signIn(
                                        email: emailTextController.text,
                                        password: passwordTextController.text);
                                  }
                                },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Entrar'),
                        );
                      })),
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
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerRight
                      ),
                      child: const Text('Não tem uma conta? Crie aqui'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blue)),
                        child: const Text('Entrar como convidado'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
