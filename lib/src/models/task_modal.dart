import 'package:mytodolist/src/models/item_model.dart';

class TaskModel {
  int? id;
  String? name;
  String? description;
  String? status;
  DateTime? createdAt;
  List<ItemModel>? items;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.status,
    this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'created_at': createdAt,
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
            ? DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int)
            : null,
        items: map['items'] != null
            ? List<ItemModel>.from((map['items'] as List<dynamic>)
                .map<ItemModel>(
                    (e) => ItemModel.fromMap(e as Map<String, dynamic>)))
            : null);
  }
}
