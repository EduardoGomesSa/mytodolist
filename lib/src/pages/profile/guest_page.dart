import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({
    super.key,
    this.hasInternet = true,
    this.isGuest = true,
  });

  final bool hasInternet;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    logoutConfirmation() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title:
                  const Text("Tem certeza que gostaria de sair do aplicativo?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.signOut();
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

    return isGuest
        ? Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Você está como convidado",
                      style: TextStyle(fontSize: 24, color: Colors.black45),
                    ),
                    const Icon(
                      Icons.person_off_outlined,
                      size: 70,
                      color: Colors.black45,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                  "Para ter acesso a mais funcionalidades, registre-se no app"),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/register");
                                  },
                                  child: const Text(
                                    "Clique aqui para criar uma conta",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      logoutConfirmation();
                    },
                    child: const Text("Sair de convidado"),
                  ),
                ),
              )
            ],
          )
        : const Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Você está offline",
                        style: TextStyle(fontSize: 24, color: Colors.black45),
                      ),
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4_rounded,
                        size: 70,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
