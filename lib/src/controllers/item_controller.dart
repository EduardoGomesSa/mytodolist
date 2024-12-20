import 'dart:async';

import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/models/item_model.dart';
import 'package:mytodolist/src/repositories/item_repository.dart';

class ItemController extends GetxController {
  final AuthController auth;
  final ItemRepository repository;
  final TaskController taskController;

  ItemController({
    required this.auth,
    required this.repository,
    required this.taskController,
  });

  RxBool isLoading = false.obs;
  ItemModel item = ItemModel();

  Future getItemsTask({required int id}) async {
    isLoading.value = true;

    await taskController.getById(id: id);

    isLoading.value = false;
  }

  Future post() async {
    String token = auth.user.token!;

    isLoading.value = true;

    ApiResult result = await repository.insert(
      token: token,
      model: item,
    );

    if (!result.isError) {
      await taskController.getById(id: item.taskId!);
    }

    isLoading.value = false;
  }

  Future renew() async {
    String token = auth.user.token!;

    isLoading.value = true;

    ApiResult<bool> result = await repository.update(token: token, model: item);

    if (!result.isError) {
      await taskController.getById(id: item.taskId!);
    }

    isLoading.value = false;
  }

  Future delete({required int id, required int taskId}) async {
    String token = auth.user.token!;

    isLoading.value = true;

    ApiResult<bool> result = await repository.delete(token: token, id: id);

    if (!result.isError) {
      await taskController.getById(id: taskId);
    }

    isLoading.value = false;
  }

  Future changeStatus({
    required int id,
    required int taskId,
    required String status,
  }) async {
    String token = auth.user.token!;

    isLoading.value = true;

    ApiResult<bool> result = await repository.changeStatus(
      token: token,
      id: id,
      status: status,
    );

    if (!result.isError) {
      await taskController.getById(id: taskId);
    }

    isLoading.value = false;
  }
}
