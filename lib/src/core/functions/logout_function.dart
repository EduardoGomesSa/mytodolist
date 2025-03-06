import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';

abstract class LogoutFunction {
  static logoutConfirmation(
      BuildContext context, Future<dynamic> onLogout) async {
    final controller = Get.find<AuthController>();
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title:
                const Text("Tem certeza que gostaria de sair do aplicativo?"),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await controller.signOut();
                },
                child: const Text("Sim"),
              ),
              const SizedBox(width: 10),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Não",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }
}
