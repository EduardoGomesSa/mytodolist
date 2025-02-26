import 'package:mytodolist/src/models/item_model.dart';

class TaskModel {
  int? id;
  String? name;
  String? description;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ItemModel>? items;

  TaskModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.status,
    this.items,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'items': items?.map((e) => e.toMap()).toList(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        id: map['id'] != null ? map['id'] as int : null,
        name: map['name'] != null ? map['name'] as String : null,
        description:
            map['description'] != null ? map['description'] as String : null,
        status: map['status'] != null ? map['status'] as String : null,
        createdAt: map['created_at'] != null
            ? DateTime.parse(map['created_at'] as String)
            : null,
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'] as String)
            : null,
        items: map['items'] != null
            ? List<ItemModel>.from((map['items'] as List<dynamic>)
                .map<ItemModel>(
                    (e) => ItemModel.fromMap(e as Map<String, dynamic>)))
            : null);
  }

  static List<TaskModel> fromList(list) {
    return List<TaskModel>.from(list.map((x) => TaskModel.fromMap(x)));
  }
}
