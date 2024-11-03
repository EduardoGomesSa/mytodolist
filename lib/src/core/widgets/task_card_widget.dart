import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      color: Colors.blue,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
          width: 25,
          height: 25,
        ),
        title: const Text("Fazer caminhada"),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Icon(Icons.edit, color: Colors.black,),
          SizedBox(width: 10),
          Icon(Icons.delete, color: Colors.black)
        ],),
      ),
    );
  }
}
