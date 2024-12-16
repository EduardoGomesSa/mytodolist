import 'package:get/get.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/repositories/task_offline_repository.dart';

class TaskOfflineController extends GetxController {
  final TaskOfflineRepository repository;
  final AppUtils appUtils;

  TaskOfflineController({
    required this.repository,
    required this.appUtils,
  });

  RxBool isLoading = false.obs;
  Rx<TaskModel> task = TaskModel().obs;
  RxList<TaskModel> listTask = RxList<TaskModel>([]);

  Future getAll() async {
    isLoading.value = true;

    ApiResult<List<TaskModel>> result = await repository.getAll();

    if (!result.isError) {
      listTask.assignAll(result.data!);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }

    isLoading.value = false;
  }
}
