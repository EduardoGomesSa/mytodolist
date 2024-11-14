import 'package:flutter/material.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      color: Colors.blue,
      child: ListTile(
        leading: const Icon(
          Icons.check_box_outline_blank_sharp,
          size: 30,
          color: Colors.white,
        ),
        title: Text(task.name.toString()),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Icon(Icons.delete, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
