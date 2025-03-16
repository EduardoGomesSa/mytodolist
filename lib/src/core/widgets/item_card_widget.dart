import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/models/item_model.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.model,
    required this.onShowModalEditItem,
    required this.isTaskActive,
  });

  final ItemModel model;
  final VoidCallback onShowModalEditItem;
  final bool isTaskActive;

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.find();

    final bool isItemOpen = model.status == "ativo" && isTaskActive;

    excluirItem() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  const Text("Tem certeza que gostaria de apagar esse item?"),
              actions: [
                TextButton(
                  onPressed: () {
                    controller.delete(id: model.id!, taskId: model.taskId!);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Sim"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Não",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          });
    }

    return ListTile(
      leading: IconButton(
        onPressed: () {
          isTaskActive
              ? controller.changeStatus(
                  id: model.id!,
                  taskId: model.taskId!,
                  status: model.status == "ativo" ? "inativo" : "ativo")
              : () {};
        },
        icon: Icon(
          isItemOpen
              ? Icons.check_box_outline_blank_sharp
              : Icons.check_box_outlined,
          size: 30,
        ),
        color: isItemOpen ? Colors.black : Colors.black38,
      ),
      title: Text(
        model.name.toString(),
        style: TextStyle(
            color: isItemOpen ? Colors.black : Colors.black38,
            decoration:
                isItemOpen ? TextDecoration.none : TextDecoration.lineThrough),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isItemOpen
              ? IconButton(
                  onPressed: onShowModalEditItem,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ))
              : const SizedBox.shrink(),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => excluirItem(),
            icon: Icon(
              Icons.delete,
              color: isItemOpen ? Colors.black : Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}
