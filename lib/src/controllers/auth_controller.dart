import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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
  RxBool isGuest = false.obs;
  RxBool hasInternet = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    monitorInternetConnection();

    await validateToken();
  }

  Future checkUserIsGuest() async {
    //isLoading.value = true;

    isGuest.value = await appUtils.checkUserIsGuest();

    //isLoading.value = false;
  }

  Future createUserGuest() async {
    isLoading.value = true;

    await appUtils.removeLocalData(key: 'user-token');
    var userCreated = await appUtils.createUserGuest();
    isGuest.value = userCreated;

    if (userCreated) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      appUtils.showToast(
        message: "Não foi possível entrar como convidado. Tente novamente!",
        isError: true,
      );
    }

    isLoading.value = false;
  }

  Future signUp() async {
    isLoading.value = true;

    ApiResult<UserModel> result = await repository.signUp(user);
    if (!result.isError) {
      user = result.data!;
      var removed = await appUtils.removeUserGuest();
      isGuest.value = removed ? false : true;

      appUtils.showToast(message: "Usuário cadastrado com sucesso");
      Get.offAllNamed(AppRoutes.home);
    } else {
      appUtils.showToast(message: result.message!, isError: true);
    }

    isLoading.value = false;
  }

  Future signIn({required String email, required String password}) async {
    isLoading.value = true;

    var removed = await appUtils.removeUserGuest();
    isGuest.value = removed ? false : true;

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

    if (hasInternet.value) {
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
        var userIsGuest = await appUtils.checkUserIsGuest();
        if (userIsGuest) {
          isGuest.value = userIsGuest;
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      }
    } else {
      var userIsGuest = await appUtils.checkUserIsGuest();
      if (userIsGuest) {
        isGuest.value = userIsGuest;
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  Future signOut() async {
    if (isGuest.value) {
      await appUtils.removeUserGuest();
      appUtils.showToast(message: "Logout realizado com sucesso!");
      Get.offAllNamed(AppRoutes.login);
      isLoading.value = false;
    } else {
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
  }

  Future deleteAccount() async {
    String token = user.token!;

    var result = await repository.deleteAccount(token: token, id: user.id!);

    if (!result.isError) {
      appUtils.showToast(message: result.message!);
      Get.offAllNamed(AppRoutes.login);
    } else {
      appUtils.showToast(message: result.message!, isError: result.isError);
    }
  }

  void monitorInternetConnection() async {
    while (true) {
      bool isConnected = await InternetConnection().hasInternetAccess;

      hasInternet.value = isConnected;

      await Future.delayed(const Duration(seconds: 15));
    }
  }
}
