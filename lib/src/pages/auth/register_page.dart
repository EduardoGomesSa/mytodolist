import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
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
                                Focus.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
