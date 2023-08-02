import 'dart:convert';

class UserModel {
  int userId;
  String userEmail;
  String userPhoneNumber;
  String userName;
  String userNickname;
  int userGender;
  DateTime userBirthdate;
  String? userProfileImage;
  String? userDef;
  String userType;
  Map<String, dynamic>? userSns;

  UserModel({
    required this.userId,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userName,
    required this.userNickname,
    required this.userGender,
    required this.userBirthdate,
    this.userProfileImage,
    this.userDef,
    required this.userType,
    this.userSns,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      userEmail: json['user_email'],
      userPhoneNumber: json['user_phonenumber'],
      userName: json['user_name'],
      userNickname: json['user_nickname'],
      userGender: json['user_gender'],
      userBirthdate: DateTime.parse(json['user_birthdate']),
      userProfileImage: json['user_profile_image'],
      userDef: json['user_def'],
      userType: json['user_type'],
      userSns: json['user_sns'] != null ? jsonDecode(json['user_sns']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_email': userEmail,
      'user_phonenumber': userPhoneNumber,
      'user_name': userName,
      'user_nickname': userNickname,
      'user_gender': userGender,
      'user_birthdate': userBirthdate.toIso8601String(),
      'user_profile_image': userProfileImage,
      'user_def': userDef,
      'user_type': userType,
      'user_sns': userSns != null ? jsonEncode(userSns) : null,
    };
  }
}