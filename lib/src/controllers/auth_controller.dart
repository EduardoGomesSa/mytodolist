import 'package:get/get.dart';
import 'package:mytodolist/src/core/routes/app_routes_pages.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/models/user_model.dart';
import 'package:mytodolist/src/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final AppUtils appUtils;

  AuthController({
    required this.repository,
    required this.appUtils,
  });

  RxBool isLoading = false.obs;
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future signUp() async {
    isLoading.value = true;

    ApiResult<UserModel> result = await repository.signUp(user);
    if (!result.isError) {
      user = result.data!;
      appUtils.showToast(message: "Usuário cadastrado com sucesso");
      Get.offAllNamed(AppRoutes.login);
    } else {
      appUtils.showToast(message: result.message!, isError: true);
    }

    isLoading.value = false;
  }

  Future signIn({required String email, required String password}) async {
    isLoading.value = true;

    ApiResult<UserModel> result =
        await repository.signIn(email: email, password: password);

    if (!result.isError) {
      user = result.data!;
      Get.offAllNamed(AppRoutes.home);
    } else {
      appUtils.showToast(message: result.message!, isError: true);
    }

    isLoading.value = false;
  }

  Future validateToken() async {
    String? token = await appUtils.getLocalData(key: 'user-token');

    if (token != null) {
      ApiResult<UserModel> result = await repository.validateToken(token);

      if (!result.isError) {
        user = result.data!;
        Get.offAllNamed(AppRoutes.home);
      } else {
        appUtils.showToast(message: result.message!, isError: true);
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future signOut() async {
    String? token = await appUtils.getLocalData(key: 'user-token');
    await appUtils.removeLocalData(key: 'user-token');

    var result = await repository.signOut(token: token ?? "");

    if (!result.isError) {
      appUtils.showToast(message: result.message!);
      Get.offAllNamed(AppRoutes.login);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }
  }

  Future deleteAccount({required int id}) async {
    String token = user.token!;

    var result = await repository.deleteAccount(token: token, id: id);

    if (!result.isError) {
      appUtils.showToast(message: result.message!);
      Get.offAllNamed(AppRoutes.login);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }
  }
}
