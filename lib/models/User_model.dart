class User{

  String userId;
  String username;
  String email;
  User.fromMap(Map<String, dynamic> data)
      : userId = data["userId"],
        email = data["email"];

}