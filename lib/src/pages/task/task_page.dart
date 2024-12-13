import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/widgets/item_add_modal.dart';
import 'package:mytodolist/src/core/widgets/item_card_widget.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key, required this.model});

  final TaskModel model;
  final TaskController controller = Get.find<TaskController>();
  final ItemController itemController = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemController.getItemsTask(id: model.id!);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Tarefa"),
      ),
      body: Column(
        children: [
          GetX<TaskController>(
              init: controller,
              builder: (controller) {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Card(
                  margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: [
                        const Text("TAREFA"),
                        ListTile(
                          leading: IconButton(
                            onPressed: () => controller.changeStatus(
                                id: model.id!,
                                status: model.status == "ativo"
                                    ? "inativo"
                                    : "ativo"),
                            icon: Icon(
                              model.status == "ativo"
                                  ? Icons.check_box_outline_blank_sharp
                                  : Icons.check_box_outlined,
                              size: 30,
                            ),
                            color: Colors.white,
                          ),
                          title: Text(
                            model.name.toString(),
                            style: TextStyle(
                                color: model.status == "ativo"
                                    ? Colors.black
                                    : Colors.black38,
                                decoration: model.status == "ativo"
                                    ? TextDecoration.none
                                    : TextDecoration.lineThrough),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              model.status == "ativo"
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ))
                                  : const SizedBox.shrink(),
                              IconButton(
                                onPressed: () {
                                  controller.delete(id: model.id!);

                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: model.status == "ativo"
                                      ? Colors.black
                                      : Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 80),
                              child: Text(model.description ?? ''),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(model.createdAt.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
          const SizedBox(height: 15),
          Expanded(
              child: GetX<TaskController>(
                  init: controller,
                  builder: (controller) {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.task.value.items == null ||
                        controller.task.value.items!.isEmpty) {
                      return const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task,
                            size: 80,
                            color: Colors.black38,
                          ),
                          Center(
                            child: Text(
                              "Nenhum item nessa tarefa",
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const Center(
                          child: Text(
                            "ITENS",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: controller.task.value.items!.length,
                              itemBuilder: (_, index) {
                                return ItemCardWidget(
                                  model: controller.task.value.items![index],
                                  onShowModalEditItem: () =>
                                      showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                    builder: (context) {
                                      return ItemAddModal(
                                        taskId: model.id!,
                                        model:
                                            controller.task.value.items![index],
                                      );
                                    },
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  }))
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
                return ItemAddModal(taskId: model.id!);
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
