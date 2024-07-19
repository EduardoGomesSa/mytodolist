class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  DateTime? createdAt;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.token,
  })
}
