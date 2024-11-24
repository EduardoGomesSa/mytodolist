import 'package:get/get.dart';
import 'package:mytodolist/src/models/item_model.dart';

class ItemController extends GetxController {
  RxBool isLoading = false.obs;
  ItemModel item = ItemModel();
}
