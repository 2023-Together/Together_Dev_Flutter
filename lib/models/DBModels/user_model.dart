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
      userId: json['userId'],
      userEmail: json['userEmail'],
      userPhoneNumber: json['userPhonenumber'],
      userName: json['userName'],
      userNickname: json['userNickname'],
      userGender: json['userGender'],
      userBirthdate: DateTime.parse(json['userBirthdate']),
      userProfileImage: json['userProfileImage'],
      userDef: json['userDef'],
      userType: json['userType'],
      userSns: json['userSns'] != null ? jsonDecode(json['userSns']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userPhonenumber': userPhoneNumber,
      'userName': userName,
      'userNickname': userNickname,
      'userGender': userGender,
      'userBirthdate':
          '${userBirthdate.year}-${userBirthdate.month.toString().padLeft(2, '0')}-${userBirthdate.day.toString().padLeft(2, '0')}',
      'userProfileImage': userProfileImage,
      'userDef': userDef,
      'userType': userType,
      'userSns': userSns != null ? jsonEncode(userSns) : null,
    };
  }

  Map<String, dynamic> toQr() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userPhonenumber': userPhoneNumber,
      'userName': userName,
      'userGender': userGender == 0 ? "남" : "여",
      'userBirthdate':
          '${userBirthdate.year}-${userBirthdate.month.toString().padLeft(2, '0')}-${userBirthdate.day.toString().padLeft(2, '0')}',
      'userProfileImage': userProfileImage,
    };
  }
}
