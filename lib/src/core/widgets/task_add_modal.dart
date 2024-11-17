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
  final FocusNode titleFocusNode =
      FocusNode(); // Define o FocusNode para o campo título

  @override
  Widget build(BuildContext context) {
    // Força o foco no campo de título assim que o modal é exibido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(titleFocusNode);
    });

    return SingleChildScrollView(
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
                focusNode: titleFocusNode,
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
                              Navigator.of(context).pop();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Salvar Tarefa'),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
