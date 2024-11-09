import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class TaskAddModal extends StatelessWidget {
  TaskAddModal({super.key});

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return
     SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Nova Tarefa',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  label: "Título",
                  icon: Icons.title,
                  controller: titleController,
                  onSaved: (value) {
                    controller.task.name = value;
                  },
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  label: 'Descrição',
                  icon: Icons.abc,
                  controller: descriptionController,
                  onSaved: (value) {
                    controller.task.description = value;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: GetX<TaskController>(builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
          
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
          
                                controller.post();
                              }
                              //Navigator.pop(context);
                            },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Salvar Tarefa'),
                    );
                  }),
                )
              ],
            ),
          )),
    );
  }
}
