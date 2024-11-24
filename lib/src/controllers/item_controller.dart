import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/models/item_model.dart';
import 'package:mytodolist/src/repositories/item_repository.dart';
import 'package:mytodolist/src/repositories/task_repository.dart';

class ItemController extends GetxController {
  final AuthController auth;
  final ItemRepository repository;
  final TaskRepository taskRepository;

  ItemController({
    required this.auth,
    required this.repository,
    required this.taskRepository,
  });

  RxBool isLoading = false.obs;
  ItemModel item = ItemModel();

  Future post() async {
    String token = auth.user.token!;

    isLoading.value = true;

    ApiResult result = await repository.insert(
      token: token,
      model: item,
    );

    if (!result.isError) {
      await taskRepository.getById(token: token, id: 1);
    }

    isLoading.value = false;
  }
}
