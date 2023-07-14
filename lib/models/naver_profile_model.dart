class NaverProfileModel {
  // String nickname;
  // String id;
  // String name;
  // String email;
  // String gender;
  // String age;
  // String birthday;
  // String birthyear;
  // String profileImage;
  // String mobile;

  String userAcid;
  String userPw;
  String userName;
  String userProfileImage;
  String userDef;
  String userType;
  Map<String, dynamic> userSns;

  // NaverProfileModel({
  //   required this.nickname,
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.gender,
  //   required this.age,
  //   required this.birthday,
  //   required this.birthyear,
  //   required this.profileImage,
  //   required this.mobile,
  // });

  NaverProfileModel({
    required this.userAcid,
    required this.userPw,
    required this.userName,
    required this.userProfileImage,
    required this.userDef,
    required this.userType,
    required this.userSns,
  });

  // NaverProfileModel.fromJson(Map<String, dynamic> json)
  //     : userAcid = json['userAcid'],
  //       userPw = json['userPw'],
  //       userName = json['name'],
  //       email = json['email'],
  //       gender = json['gender'],
  //       age = json['age'],
  //       birthday = json['birthday'],
  //       birthyear = json['birthyear'],
  //       userProfileImage = json['profileImage'],
  //       userSns = json;
}