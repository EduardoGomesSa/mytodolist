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

    String message =
          "Não foi possível buscar as tarefas. Tente novamente!";
      return ApiResult<List<TaskModel>>(message: message, isError: true);
  }

  Future<int> insert(TaskModel model) async {
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

    return saved;
  }
}
