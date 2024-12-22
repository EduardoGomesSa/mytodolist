import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/models/item_model.dart';
import 'package:mytodolist/src/repositories/databases/db.dart';

class ItemOfflineRepository {
  //ItemOfflineRepository();

  Future<ApiResult<ItemModel>> insert({required ItemModel item}) async {
    final db = await Db.connection();

    var saved = await db.insert('items', {
      'task_id': item.taskId,
      'name': item.name,
      'status': 'ativo',
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    if (saved > 0) {
      return ApiResult<ItemModel>();
    }

    return ApiResult<ItemModel>(
      message: "Não foi possível cadastrar o item. Tente novamente!",
      isError: true,
    );
  }

  Future<ApiResult<bool>> update({required ItemModel item}) async {
    final db = await Db.connection();

    var updated = await db.update('items', {
      'name': item.name,
    });

    if (updated > 0) {
      return ApiResult<bool>(
        message: "Item atualizado com sucesso!",
        isError: false,
      );
    }

    return ApiResult(
        message: "Erro ao atualizar item. Tente novamente!", isError: true);
      
  }
}
