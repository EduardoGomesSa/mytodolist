import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/task_add_modal.dart';
import 'package:mytodolist/src/core/widgets/task_card_widget.dart';
import 'package:mytodolist/src/pages/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async => taskController.getAll(),
              child: GetX<TaskController>(
                init: taskController,
                builder: (controller) {
                  if (taskController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (taskController.listTask.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task, size: 60, color: Colors.black38,),
                        SizedBox(height: 15),
                        Center(
                            child: Text("Nenhuma tarefa cadastrada",
                                style: TextStyle(fontSize: 18, color: Colors.black38))),
                      ],
                    );
                  }
              
                  return ListView.builder(
                      itemCount: taskController.listTask.length,
                      itemBuilder: (_, index) {
                        return TaskCardWidget(
                          task: taskController.listTask[index],
                          controller: taskController,
                          onShowModalEditTask: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            builder: (context) {
                              return TaskAddModal(
                                  task: taskController.listTask[index]);
                            },
                          ),
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (context) {
              return const TaskAddModal();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
