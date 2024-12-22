import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/repositories/databases/db.dart';

class TaskOfflineRepository {
  Future<ApiResult<List<TaskModel>>> getAll() async {
    final db = await Db.connection();

    var tasks = await db.query('tasks', orderBy: 'created_at DESC');

    if (tasks.isNotEmpty) {
      List<TaskModel> listTasks = TaskModel.fromList(tasks as List);
      return ApiResult(data: listTasks);
    }

    String message = "Não foi possível buscar as tarefas. Tente novamente!";
    return ApiResult<List<TaskModel>>(message: message, isError: true);
  }

  Future<ApiResult<TaskModel>> getById({required int id}) async {
    final db = await Db.connection();

    var response = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (response.isNotEmpty) {
      var task = TaskModel.fromMap(response as Map<String, dynamic>);

      return ApiResult(data: task);
    }

    return ApiResult(
      message: "Não foi possível buscar esta tarefa. Tente novamente",
      isError: true,
    );
  }

  Future<ApiResult<bool>> insert({required TaskModel model}) async {
    final db = await Db.connection();

    var saved = await db.transaction((txn) async {
      final taskId = await txn.insert('tasks', {
        'name': model.name,
        'description': model.description,
        'status': 'ativo',
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (model.items != null && model.items!.isNotEmpty) {
        for (var item in model.items!) {
          await txn.insert('items', {
            'task_id': taskId,
            'name': item.name,
            'status': 'ativo',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
        }
      }

      return taskId > 0 ? 1 : 0;
    });

    if (saved > 0) {
      return ApiResult<bool>(data: true, message: "Tarefa criada com sucesso!");
    }

    return ApiResult<bool>(
      data: false,
      message: "Não foi possível cadastrar a tarefa. Tente novamente!",
      isError: true,
    );
  }

  Future<ApiResult<bool>> update({required TaskModel model}) async {
    final db = await Db.connection();

    Map<String, dynamic> updateData = {};
    int updated = 0;

    if (model.name != null || model.name != "") {
      updateData['name'] = model.name;
    }

    if (model.description != null) {
      updateData['description'] = model.description;
    }

    if (updateData.isNotEmpty) {
      updated = await db.update(
        'tasks',
        updateData,
        where: 'id = ?',
        whereArgs: [model.id],
      );
    }

    return updated > 0
        ? ApiResult<bool>(
            message: "Tarefa atualizada com sucesso!",
            isError: false,
          )
        : ApiResult<bool>(
            message: "Tarefa não foi atualizada. Tente novamente!",
            isError: true,
          );
  }

  Future<ApiResult<bool>> changeStatus({
    required int id,
    required String status,
  }) async {
    final db = await Db.connection();

    var changed = await db.update(
      'tasks',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );

    return changed > 0
        ? ApiResult<bool>(
            message: "Status da tarefa atualizado com sucesso!",
            isError: false,
          )
        : ApiResult<bool>(
            message: "Status da tarefa não foi atualizado",
            isError: true,
          );
  }

  Future<ApiResult<bool>> delete({required int id}) async {
    final db = await Db.connection();

    var deleted = await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    return deleted > 0
        ? ApiResult<bool>(
            message: "Tarefa excluída com sucesso",
            isError: false,
          )
        : ApiResult<bool>(
            message: "Não foi possível apagar esta tarefa. Tente novamente",
            isError: true,
          );
  }
}
