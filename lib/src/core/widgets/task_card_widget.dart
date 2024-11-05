import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      color: Colors.blue,
      child: ListTile(
        leading: Icon(Icons.check_box_outline_blank_sharp, size: 30, color: Colors.white,),
        title: Text("Fazer caminhada"),
        trailing: Row(
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
