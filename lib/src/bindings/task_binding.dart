import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/task_controller.dart';
import 'package:mytodolist/src/repositories/task_repository.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskRepository(httpManager: Get.find()));
    Get.put(TaskController(
        auth: Get.find(), repository: Get.find(), appUtils: Get.find()));
  }
}
