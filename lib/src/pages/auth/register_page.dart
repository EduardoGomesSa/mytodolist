import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
import 'package:mytodolist/src/core/services/validators.dart';
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
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.blue,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: Text('Logo'))],
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      )),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFieldWidget(
                          label: 'nome',
                          icon: Icons.person,
                          controller: nameTextController,
                          validator: nameValidator,
                          onSaved: (value) {
                            controller.user.name = value;
                          },
                        ),
                        TextFieldWidget(
                          label: 'email',
                          icon: Icons.email,
                          controller: emailTextController,
                          validator: emailvalidator,
                          onSaved: (value) {
                            controller.user.email = value;
                          },
                        ),
                        TextFieldWidget(
                          label: 'senha',
                          icon: Icons.lock,
                          isSecret: true,
                          controller: passwordTextController,
                          validator: passwordValidator,
                          onSaved: (value) {
                            controller.user.password = value;
                          },
                        ),
                        TextFieldWidget(
                          label: 'confirmar senha',
                          icon: Icons.lock,
                          isSecret: true,
                          controller: passwordConfirmedController,
                          validator: passwordValidator,
                        ),
                        SizedBox(
                          height: 45,
                          child: GetX<AuthController>(builder: (controller) {
                            return ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
            
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
            
                                        if (passwordTextController.value ==
                                            passwordConfirmedController.value) {
                                          controller.signUp();
                                        } else {
                                          controller.appUtils.showToast(
                                              message:
                                                  "Senha de confirmação está diferente",
                                              isError: true);
                                        }
                                      }
                                    },
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text('Cadastrar'),
                            );
                          }),
                        ),
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
                        Get.toNamed(AppRoutes.login);
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue)),
                      child: const Text('Já possui uma conta? Clique aqui para entrar'),
                    ),
                  ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.login);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
