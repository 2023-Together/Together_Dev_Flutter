class UserModel {
  final String loginType;

  UserModel({required this.loginType});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      loginType: json['loginType'],
    );
  }
}
