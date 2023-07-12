// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginDataModel {
  String? loginType;
  String? id;
  String? password;

  LoginDataModel({
    this.loginType,
    this.id,
    this.password,
  });

  LoginDataModel.fromJson(Map<String, dynamic> json)
      : loginType = json["loginType"],
        id = json["id"],
        password = json["password"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["loginType"] = loginType;
    data["id"] = id;
    data["password"] = password;
    return data;
  }
}
