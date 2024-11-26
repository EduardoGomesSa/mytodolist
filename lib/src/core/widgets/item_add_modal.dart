import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';

class ItemAddModal extends StatefulWidget {
  const ItemAddModal({super.key, required this.taskId});

  final int taskId;

  @override
  State<ItemAddModal> createState() => _ItemAddModalState();
}

class _ItemAddModalState extends State<ItemAddModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final controller = Get.find<ItemController>();
  final FocusNode titleFocusNode = FocusNode();
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
            children: [
              const Text("Adicionar item"),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: "Nome",
                icon: Icons.abc,
                focusNode: titleFocusNode,
                controller: titleController,
                onSaved: (value) {
                  controller.item.name = value;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: GetX<ItemController>(builder: (controller) {
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
                              // if (widget.task == null) {
                              //   controller.post();
                              // } else {
                              //   controller.task.id = widget.task!.id;
                              //   controller.renew();
                              // }
                              controller.item.taskId = widget.taskId;
                              controller.post();
                              Navigator.of(context).pop();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text("Salvar Item"),
                              // child: Text(widget.task == null
                              //     ? 'Salvar Tarefa'
                              //     : 'Editar Tarefa'),
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
