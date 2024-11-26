class ItemModel {
  int? id;
  String? name;
  String? description;
  String? status;
  int? taskId;

  ItemModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.taskId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'task_id': taskId,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
}
