import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/models/user_model.dart';

class ProfileController extends GetxController {
  final AuthController auth;

  ProfileController({
    required this.auth,
  });

  UserModel user = UserModel();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    getUser();
  }

  Future getUser() async {
    isLoading.value = true;
    user = auth.user;
    isLoading.value = false;
  }
}
