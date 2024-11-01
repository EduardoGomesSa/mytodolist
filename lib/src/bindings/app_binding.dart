import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/services/http_manager.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/repositories/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HttpManager());
    Get.put(AppUtils());
    Get.put(AuthRepository(httpManager: Get.find(), appUtils: Get.find()));
    Get.put(AuthController(repository: Get.find(), appUtils: Get.find()));
  }
}
