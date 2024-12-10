import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/repositories/task_repository.dart';

class TaskController extends GetxController {
  final AuthController auth;
  final TaskRepository repository;
  final AppUtils appUtils;

  TaskController({
    required this.auth,
    required this.repository,
    required this.appUtils,
  });

  RxBool isLoading = false.obs;
  Rx<TaskModel> task = TaskModel().obs;
  RxList<TaskModel> listTask = RxList<TaskModel>([]);

  @override
  void onInit() {
    getAll();

    super.onInit();
  }

  Future getAll() async {
    isLoading.value = true;
    String token = auth.user.token!;

    ApiResult<List<TaskModel>> result = await repository.getAll(token: token);

    if (!result.isError) {
      listTask.assignAll(result.data!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future getById({required int id}) async {
    isLoading.value = true;
    String token = auth.user.token!;

    ApiResult<TaskModel> result =
        await repository.getById(token: token, id: id);

    if (!result.isError) {
      task.value = result.data!;
      //task.value.items;
    }

    isLoading.value = false;
  }

  Future post() async {
    isLoading.value = true;

    String token = auth.user.token!;
    task.value.id = null;

    ApiResult<TaskModel> result =
        await repository.insert(token: token, task: task.value);

    if (!result.isError) {
      await getAll();

      appUtils.showToast(message: "tarefa cadastrada com sucesso!");
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future changeStatus({required String status, required int id}) async {
    isLoading.value = true;

    String token = auth.user.token!;

    ApiResult<bool> result = await repository.changeStatus(
      token: token,
      id: id,
      status: status,
    );

    if (!result.isError) {
      await getAll();

      appUtils.showToast(message: result.message!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future renew() async {
    isLoading.value = true;

    String token = auth.user.token!;

    ApiResult<bool> result =
        await repository.update(token: token, task: task.value);

    if (!result.isError) {
      await getAll();

      appUtils.showToast(message: result.message!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future delete({required int id}) async {
    isLoading.value = true;

    String token = auth.user.token!;

    ApiResult<bool> result = await repository.delete(token: token, id: id);

    if (!result.isError) {
      if (task.value.id! > 0) {
        task.value = TaskModel();
      }
      await getAll();
      appUtils.showToast(message: result.message!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }
}
