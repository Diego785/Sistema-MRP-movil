class User {
  String id = "";
  String name = "";
  String email = "";
  String avatar = "";

  User(id, name, email, avatar) {
    this.id;
    this.name;
    this.email;
    this.avatar;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'];
}
