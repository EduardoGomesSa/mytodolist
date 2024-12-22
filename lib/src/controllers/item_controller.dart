import 'dart:async';

import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/models/item_model.dart';
import 'package:mytodolist/src/repositories/item_offline_repository.dart';
import 'package:mytodolist/src/repositories/item_repository.dart';

class ItemController extends GetxController {
  final AuthController auth;
  final ItemRepository repository;
  final TaskController taskController;
  final ItemOfflineRepository offlineRepository;

  ItemController({
    required this.auth,
    required this.repository,
    required this.taskController,
    required this.offlineRepository,
  });

  RxBool isLoading = false.obs;
  ItemModel item = ItemModel();

  Future getItemsTask({required int id}) async {
    isLoading.value = true;

    await taskController.getById(id: id);

    isLoading.value = false;
  }

  Future post() async {
    isLoading.value = true;

    ApiResult result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.insert(
        token: token,
        model: item,
      );
    } else {
      result = await offlineRepository.insert(item: item);
    }

    if (!result.isError) {
      await taskController.getById(id: item.taskId!);
    }

    isLoading.value = false;
  }

  Future renew() async {
    isLoading.value = true;

    ApiResult<bool> result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.update(token: token, model: item);
    } else {
      result = await offlineRepository.update(item: item);
    }

    if (!result.isError) {
      await taskController.getById(id: item.taskId!);
    }

    isLoading.value = false;
  }

  Future delete({required int id, required int taskId}) async {
    isLoading.value = true;

    ApiResult<bool> result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.delete(token: token, id: id);
    } else {
      result = await offlineRepository.delete(id: id);
    }

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
    isLoading.value = true;

    ApiResult<bool> result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.changeStatus(
        token: token,
        id: id,
        status: status,
      );
    } else {
      result = await offlineRepository.changeStatus(
        id: id,
        status: status,
      );
    }

    if (!result.isError) {
      await taskController.getById(id: taskId);
    }

    isLoading.value = false;
  }
}
