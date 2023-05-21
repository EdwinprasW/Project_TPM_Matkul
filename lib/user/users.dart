class User{

  int id;
  String username;
  String password;

  User(
      this.id,
      this.username,
      this.password,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    int.parse(json["id"]),
    json["username"],
    json["password"],
  );

  Map<String, dynamic> toJson() =>
      {
        'username' : username,
        'password' : password,

      };

}