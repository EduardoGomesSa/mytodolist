import 'package:flutter/material.dart';

class TaskAddModal extends StatelessWidget {
  const TaskAddModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Ajusta o padding inferior ao teclado
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Nova Tarefa',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Ação para salvar a tarefa
                        Navigator.pop(context); // Fecha o modal após a ação
                      },
                      child: const Text('Salvar Tarefa'),
                    ),
                  ],
                ),
              );
  }
}