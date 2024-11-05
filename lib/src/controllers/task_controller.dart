import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/models/task_modal.dart';
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
  TaskModel task = TaskModel();
  RxList<TaskModel> listTask = RxList<TaskModel>([]);
  
}
