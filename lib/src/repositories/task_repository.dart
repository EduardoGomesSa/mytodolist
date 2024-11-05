import 'package:mytodolist/src/core/services/http_manager.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/core/utils/urls.dart';
import 'package:mytodolist/src/models/task_modal.dart';

class TaskRepository {
  final HttpManager httpManager;

  TaskRepository({
    required this.httpManager,
  });

  Future<ApiResult<TaskModel>> insert(
      {required String token, TaskModel? task}) async {
    const String endpoint = "${Url.base}/tasks";

    Map<String, dynamic> body = task!.toMap();

    final response = await httpManager.request(
      url: endpoint,
      method: HttpMethods.post,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['data'] != null) {
      TaskModel model = TaskModel.fromMap(response['data']);

      return ApiResult<TaskModel>(data: model);
    } else {
      String message = response['error'] ??
          'Não foi possível cadastrar a tarefa, Tente novamente!';

      return ApiResult<TaskModel>(message: message, isError: true);
    }
  }
}
