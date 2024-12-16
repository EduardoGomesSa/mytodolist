import 'package:get/get.dart';
import 'package:mytodolist/src/core/utils/app_utils.dart';
import 'package:mytodolist/src/repositories/task_offline_repository.dart';

class TaskOfflineController extends GetxController {
  final TaskOfflineRepository repository;
  final AppUtils appUtils;

  TaskOfflineController({
    required this.repository,
    required this.appUtils,
  });

  
}
