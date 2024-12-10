import 'package:flutter/material.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/pages/task/task_page.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
    required this.controller,
    required this.onShowModalEditTask,
  });

  final TaskModel task;
  final TaskController controller;
  final VoidCallback onShowModalEditTask;

  @override
  Widget build(BuildContext context) {
    excluirTask() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  const Text("Tem certeza que gostaria de apagar essa tarefa?"),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.delete(id: task.id!);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sim"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Não"),
                ),
              ],
            );
          });
    }

    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TaskPage(model: task))),
      child: Card(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        color: task.status == "ativo"
            ? Colors.blue
            : const Color.fromARGB(255, 149, 204, 229),
        child: ListTile(
          leading: IconButton(
            onPressed: () => controller.changeStatus(
                id: task.id!,
                status: task.status == "ativo" ? "inativo" : "ativo"),
            icon: Icon(
              task.status == "ativo"
                  ? Icons.check_box_outline_blank_sharp
                  : Icons.check_box_outlined,
              size: 30,
            ),
            color: task.status == "ativo" ? Colors.black : Colors.black38,
          ),
          title: Text(
            task.name.toString(),
            style: TextStyle(
                color: task.status == "ativo" ? Colors.black : Colors.black38,
                decoration: task.status == "ativo"
                    ? TextDecoration.none
                    : TextDecoration.lineThrough),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              task.status == "ativo"
                  ? IconButton(
                      onPressed: onShowModalEditTask,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ))
                  : const SizedBox.shrink(),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => excluirTask(),
                icon: Icon(
                  Icons.delete,
                  color: task.status == "ativo" ? Colors.black : Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
