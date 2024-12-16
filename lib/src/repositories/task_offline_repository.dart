import 'package:mytodolist/src/models/task_model.dart';
import 'package:mytodolist/src/repositories/databases/db.dart';

class TaskOfflineRepository {
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
