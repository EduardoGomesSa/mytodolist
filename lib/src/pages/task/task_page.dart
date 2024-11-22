import 'package:flutter/material.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, required this.model});

  final TaskModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Tarefa"),
      ),
    );
  }
}
