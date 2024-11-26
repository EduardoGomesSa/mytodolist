import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/item_add_modal.dart';
import 'package:mytodolist/src/core/widgets/task_card_widget.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key, required this.model});

  final TaskModel model;
  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Tarefa"),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.blue,
            child: Column(
              children: [
                const Text("TAREFA"),
                TaskCardWidget(
                    task: model,
                    controller: controller,
                    onShowModalEditTask: () {}),
                Text(model.description ?? ''),
                Text(model.createdAt.toString()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              builder: (context) {
                return ItemAddModal(taskId: model.id!);
              });
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
