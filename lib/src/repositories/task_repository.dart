import 'package:mytodolist/src/core/services/http_manager.dart';
import 'package:mytodolist/src/core/utils/api_result.dart';
import 'package:mytodolist/src/core/utils/urls.dart';
import 'package:mytodolist/src/models/task_model.dart';

class TaskRepository {
  final HttpManager httpManager;

  TaskRepository({
    required this.httpManager,
  });

  Future<ApiResult<List<TaskModel>>> getAll({required String token}) async {
    const String endpoint = "${Url.base}/tasks";

    final response = await httpManager.request(
      url: endpoint,
      method: HttpMethods.get,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['data'] != null) {
      List<TaskModel> listTasks = TaskModel.fromList(response['data'] as List);

      return ApiResult<List<TaskModel>>(data: listTasks);
    } else {
      String message = response['error'] ??
          "Não foi possível buscar as tarefas. Tente novamente!";
      return ApiResult<List<TaskModel>>(message: message, isError: true);
    }
  }

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

  Future<ApiResult<bool>> changeStatus(
      {required String token, required int id, required String status}) async {
    const String endpoint = "${Url.base}/tasks/status";

    final Map<String, dynamic> body = {'id': id, 'status': status};

    final response = await httpManager.request(
        url: endpoint,
        method: HttpMethods.put,
        body: body,
        headers: {'Authorization': 'Bearer $token'});

    if (response['message'] != null) {
      return ApiResult<bool>(message: "status da tarefa atualizado com sucesso!");
    }

    return ApiResult<bool>(
        message: "Status da tarefa não foi atualizado", isError: true);
  }

  Future<ApiResult<bool>> delete({
    required String token,
    required int id,
  }) async {
    const String endpoint = "${Url.base}/tasks";

    Map<String, dynamic> body = {'id': id};

    final response = await httpManager.request(
      url: endpoint,
      method: HttpMethods.delete,
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response['message'] != null) {
      return ApiResult<bool>(message: "Tarefa excluída com sucesso");
    }

    return ApiResult<bool>(
        message: "Não foi possível apagar esta tarefa. Tente novamente", isError: true);
  }
}
