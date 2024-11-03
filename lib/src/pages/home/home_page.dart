import 'package:flutter/material.dart';
import 'package:mytodolist/src/core/widgets/task_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            TaskCardWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        
        child: const Icon(Icons.add, color: Colors.black,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
