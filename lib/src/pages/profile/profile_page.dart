import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/bar_chart_widget.dart';
import 'package:mytodolist/src/core/widgets/pie_chart_widget.dart';
import 'package:mytodolist/src/pages/profile/guest_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final controllerTask = Get.find<TaskController>();

    deleteAccountConfirmation() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text(
                  "Tem certeza que gostaria de excluir sua conta? Essa ação não poderá ser desfeita"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    controller.deleteAccount();
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil'),
        ),
        body: controller.hasInternet.value && !controller.isGuest.value
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: Card(
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.user.name.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "No app desde ${controller.user.formattedCreatedAt}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total de tarefas: ${controllerTask.listTask.length}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      "Tarefas concluídas: ${controllerTask.countTasks('inativo')}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      "Tarefas em aberto: ${controllerTask.countTasks('ativo')}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 70),
                          child: Center(
                            child: Text(
                              "Suas estatísticas",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: PieChartWidget(
                            totalTarefas: controllerTask.listTask.length,
                            tarefasAbertas: controllerTask.countTasks("ativo"),
                            tarefasConcluidas:
                                controllerTask.countTasks("inativo"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: BarChartWidget(
                                tasksByDay:
                                    controllerTask.generateTasksByDay()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
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
                            child: const Text("Sair"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 20, right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onPressed: () {
                              deleteAccountConfirmation();
                            },
                            child: const Text(
                              "Excluir conta",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : GuestPage(
                hasInternet: controller.hasInternet.value,
                isGuest: controller.isGuest.value,
              ),
      ),
    );
  }
}
