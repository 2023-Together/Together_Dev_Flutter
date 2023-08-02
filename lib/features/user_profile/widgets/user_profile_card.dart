import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';

class UserProfileCard extends StatelessWidget {
  final String userId; // 유저 아이디
  final String userEmail;  // 유저 이메일
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userNickName;  // 유저 닉네임
  final String userGender;  // 유저 성별
  final String userPhoneNumber;  // 유저 전화번호
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String userBirthDate; // 유저 생일

  const UserProfileCard({
    super.key,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userNickName,
    required this.userEmail,
    required this.userDef,
    required this.userType,
    required this.userBirthDate,
    required this.userGender,
    required this.userPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(
          UserInformUpdate.routeName,
          extra: UserInformArgs(
            userId: userId,
            userEmail: userEmail,
            userPw: userPw,
            userName: userName,
            userNickName: userNickName,
            userDef: userDef,
            userGender: userGender,
            userType: userType,
            userBirthDate: userBirthDate,
            userPhoneNumber: userPhoneNumber,
          ),
        );
      },
      leading: const CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(
          "https://avatars.githubusercontent.com/u/77985708?v=4",
        ),
      ),
      title: Text(
        userName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Sizes.size18,
        ),
      ),
      subtitle: const Text(
        "SWAG 동아리",
        style: TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: Sizes.size40,
      ),
    );
  }
}
