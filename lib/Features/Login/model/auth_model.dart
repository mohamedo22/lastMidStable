// AuthModel and User Classes
class AuthModel {
  User? user;
  bool? stat; // Keep the name as `stat`
  String? message;

  AuthModel({this.user, this.stat, this.message});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    stat = json["status"]; // Map "status" from JSON to `stat`
    message = json["message"];
  }

  static List<AuthModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(AuthModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["status"] = stat; // Map `stat` to "status" in JSON
    _data["message"] = message;
    return _data;
  }
}

class User {
  int? userId; // Keep the name as `userId`
  String? username;
  String? nationalId; // Keep the name as `nationalId`
  String? birthDate;
  String? phone;
  String? password;
  String? email;
  String? address;
  String? token; // Add `token` field

  User({
    this.userId,
    this.username,
    this.nationalId,
    this.birthDate,
    this.phone,
    this.password,
    this.email,
    this.address,
    this.token, // Include `token` in the constructor
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json["userId"]; // Map "id" from JSON to `userId`
    username = json["username"];
    nationalId = json["national_Id"]; // Map "national_Id" from JSON to `nationalId`
    birthDate = json["birthDate"];
    phone = json["phone"];
    password = json["password"];
    email = json["email"];
    address = json["address"];
    token = json["token"]; // Map "token" from JSON to `token`
  }

  static List<User> fromList(List<Map<String, dynamic>> list) {
    return list.map(User.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = userId; // Map `userId` to "id" in JSON
    _data["username"] = username;
    _data["national_Id"] = nationalId; // Map `nationalId` to "national_Id" in JSON
    _data["birthDate"] = birthDate;
    _data["phone"] = phone;
    _data["password"] = password;
    _data["email"] = email;
    _data["address"] = address;
    _data["token"] = token; // Map `token` to "token" in JSON
    return _data;
  }
}