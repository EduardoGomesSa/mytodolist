import 'package:flutter/material.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/models/item_model.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({
    super.key,
    required this.model,
    required this.controller,
  });

  final ItemModel model;
  final ItemController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      color: model.status == "ativo"
          ? Colors.blue
          : const Color.fromARGB(255, 149, 204, 229),
      child: ListTile(
        leading: IconButton(
          onPressed: () => controller.changeStatus(
              id: model.id!,
              status: model.status == "ativo" ? "inativo" : "ativo"),
          icon: Icon(
            model.status == "ativo"
                ? Icons.check_box_outline_blank_sharp
                : Icons.check_box_outlined,
            size: 30,
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
