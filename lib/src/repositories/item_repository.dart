import 'package:mytodolist/src/core/services/http_manager.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/urls.dart';
import 'package:mytodolist/src/models/item_model.dart';

class ItemRepository {
  final HttpManager httpManager;

  ItemRepository({required this.httpManager});

  Future<ApiResult<ItemModel>> insert({
    required String token,
    required ItemModel model,
  }) async {
    const String endpoint = "${Url.base}/items";

    Map<String, dynamic> body = model.toMap();

    final response = await httpManager.request(
      url: endpoint,
      method: HttpMethods.post,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['data'] != null) {
      ItemModel item = ItemModel.fromMap(response['data']);

      return ApiResult<ItemModel>(data: item);
    }

    return ApiResult(
        message: "Não foi possível cadastrar o item. Tente novamente!",
        isError: true);
  }

  Future<ApiResult<bool>> update(
      {required String token, required ItemModel model}) async {
    const String endpoint = "${Url.base}/items";

    Map<String, dynamic> body = model.toMap();

    final response = await httpManager.request(
      url: endpoint,
      method: HttpMethods.put,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['message'] != null) {
      return ApiResult<bool>(message: "Item atualizado com sucesso!");
    }

    return ApiResult(
        message: "Erro ao atualizar item. Tente novamente!", isError: true);
  }
}
