import 'package:flutter/material.dart';
import 'package:mytodolist/src/core/widgets/item_add_modal.dart';
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
      body: Column(
        children: [
          Expanded(child: Text(model.name!)),
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
                return const ItemAddModal();
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
