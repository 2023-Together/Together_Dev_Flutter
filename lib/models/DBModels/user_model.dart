// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int userDid; // 유저 did
  final String userId; // 유저 아이디
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userProfile; // 유저 프로필(base64)
  final String userProfileDescription; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final Map<String, dynamic>
      userSns; // sns연동 데이터 저장 {""naver"":null, ""kakao"": {}}

  UserModel({
    required this.userDid,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userProfile,
    required this.userProfileDescription,
    required this.userType,
    required this.userSns,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userDid: json['user_did'],
      userId: json['user_id'] ?? '',
      userPw: json['user_pw'] ?? '',
      userName: json['user_name'] ?? '',
      userProfile: json['user_pf'] ?? '',
      userProfileDescription: json['user_def'] ?? '',
      userType: json['user_type'] ?? '',
      userSns: json['user_sns'] != null
          ? Map<String, dynamic>.from(json['user_sns'])
          : {},
    );
  }
}
