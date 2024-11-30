import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskAddModal extends StatefulWidget {
  const TaskAddModal({super.key, this.task});

  final TaskModel? task;

  @override
  State<TaskAddModal> createState() => _TaskAddModalState();
}

class _TaskAddModalState extends State<TaskAddModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final controller = Get.find<TaskController>();
  final FocusNode titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.task?.name ?? '');
    descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                label: "Título",
                icon: Icons.title,
                controller: titleController,
                focusNode: titleFocusNode,
                onSaved: (value) {
                  controller.task.value.name = value;
                },
              ),
              const SizedBox(height: 16),
              TextFieldWidget(
                label: 'Descrição',
                icon: Icons.abc,
                controller: descriptionController,
                onSaved: (value) {
                  controller.task.value.description = value;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: GetX<TaskController>(builder: (controller) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (widget.task == null) {
                                controller.post();
                              } else {
                                controller.task.value.id = widget.task!.id;
                                controller.renew();
                              }
                              Navigator.of(context).pop();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(widget.task == null
                                  ? 'Salvar Tarefa'
                                  : 'Editar Tarefa'),
                            ),
                          ),
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
