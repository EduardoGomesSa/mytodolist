import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/item_controller.dart';
import 'package:mytodolist/src/repositories/item_repository.dart';

class ItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemRepository(httpManager: Get.find()));
    Get.put(
      ItemController(
        auth: Get.find(),
        repository: Get.find(),
        taskRepository: Get.find(),
      ),
    );
  }
}
