import 'package:get/get.dart';
import 'package:mytodolist/src/controllers/auth_controller.dart';
import 'package:mytodolist/src/models/item_model.dart';
import 'package:mytodolist/src/repositories/item_repository.dart';

class ItemController extends GetxController {
  final AuthController auth;
  final ItemRepository repository;

  ItemController({
    required this.auth,
    required this.repository,
  });

  RxBool isLoading = false.obs;
  ItemModel item = ItemModel();
}
