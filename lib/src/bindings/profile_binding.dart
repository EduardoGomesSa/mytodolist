import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(auth: Get.find()));
  }
}
