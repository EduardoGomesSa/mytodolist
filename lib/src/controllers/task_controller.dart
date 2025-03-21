import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/repositories/task_offline_repository.dart';
import 'package:mytodolist/src/repositories/task_repository.dart';

class TaskController extends GetxController {
  final AuthController auth;
  final TaskRepository repository;
  final AppUtils appUtils;
  final TaskOfflineRepository offlineRepository;

  TaskController({
    required this.auth,
    required this.repository,
    required this.appUtils,
    required this.offlineRepository,
  });

  RxBool isLoading = false.obs;
  Rx<TaskModel> task = TaskModel().obs;
  RxList<TaskModel> listTask = RxList<TaskModel>([]);

  int countTasks(String status) {
    return listTask.where((task) => task.status == status).length;
  }

  Map<String, int> generateTasksByDay() {
    Map<String, int> tasksByDay = {};

    for (int i = 6; i >= 0; i--) {
      DateTime date = DateTime.now().subtract(Duration(days: i));

      DateTime normalizedDate = DateTime(date.year, date.month, date.day);

      String formattedDate = DateFormat('E', 'pt_BR').format(date);
      tasksByDay[formattedDate] = listTask.where((task) {
        if (task.updatedAt == null) return false;

        DateTime taskDate = DateTime(
            task.updatedAt!.year, task.updatedAt!.month, task.updatedAt!.day);

        return task.status == "inativo" && taskDate == normalizedDate;
      }).length;
    }

    return tasksByDay;
  }

  @override
  void onInit() {
    getAll();

    super.onInit();
  }

  Future getAll() async {
    isLoading.value = true;
    ApiResult<List<TaskModel>> result;
    if (!auth.isGuest.value && auth.hasInternet.value) {
      String token = auth.user.token!;

      result = await repository.getAll(token: token);
    } else {
      result = await offlineRepository.getAll();
    }

    if (!result.isError) {
      listTask.assignAll(result.data!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future getById({required int id}) async {
    isLoading.value = true;

    ApiResult<TaskModel> result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.getById(token: token, id: id);
    } else {
      result = await offlineRepository.getById(id: id);
    }

    if (!result.isError) {
      task.value = result.data!;
    }

    isLoading.value = false;
  }

  Future post() async {
    isLoading.value = true;

    ApiResult result;

    if (!auth.isGuest.value) {
      if (auth.hasInternet.value) {
        String token = auth.user.token!;

        result = await repository.insert(token: token, task: task.value);
      } else {
        result = await offlineRepository.insert(model: task.value);
      }
    } else {
      result = await offlineRepository.insert(model: task.value);
    }

    task.value.id = null;

    if (!result.isError) {
      await getAll();

      appUtils.showToast(message: "Tarefa criada com sucesso!");
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future changeStatus({required String status, required int id}) async {
    isLoading.value = true;

    ApiResult<bool> result;

    if (!auth.isGuest.value && auth.hasInternet.value) {
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
      await getAll();

      if (task.value.id != null && task.value.id! > 0) {
        await getById(id: task.value.id!);
      }

      appUtils.showToast(message: result.message!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }

  Future renew() async {
    isLoading.value = true;

    ApiResult<bool> result;

    if (!auth.isGuest.value) {
      String token = auth.user.token!;

      result = await repository.update(token: token, task: task.value);
    } else {
      result = await offlineRepository.update(model: task.value);
    }

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

    ApiResult<bool> result;

    if (!auth.isGuest.value && auth.hasInternet.value) {
      String token = auth.user.token!;

      result = await repository.delete(token: token, id: id);
    } else {
      result = await offlineRepository.delete(id: id);
    }

    if (!result.isError) {
      if (task.value.id != null && task.value.id! > 0) {
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
