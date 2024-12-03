import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/core/widgets/text_field_widget.dart';
import 'package:mytodolist/src/models/item_model.dart';

class ItemAddModal extends StatefulWidget {
  const ItemAddModal({
    super.key,
    required this.taskId,
    this.model,
  });

  final int taskId;
  final ItemModel? model;

  @override
  State<ItemAddModal> createState() => _ItemAddModalState();
}

class _ItemAddModalState extends State<ItemAddModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final controller = Get.find<ItemController>();
  final FocusNode titleFocusNode = FocusNode();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.model?.name ?? '');

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();

    super.dispose();
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
            children: [
              Text(widget.model == null ?  "Adicionar Item" : 'Editar Item'),
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

                              controller.item.taskId = widget.taskId;
                              
                              if (widget.model == null) {
                                controller.post();
                              } else {
                                controller.item.id = widget.model!.id;
                                controller.renew();
                              }
                              // controller.item.taskId = widget.taskId;
                              // controller.post();
                              Navigator.of(context).pop();
                            }
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(widget.model == null
                                  ? 'Salvar Item'
                                  : 'Editar Item'),
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
