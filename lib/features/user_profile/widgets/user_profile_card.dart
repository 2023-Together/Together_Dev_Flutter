import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class UserProfileCard extends StatelessWidget {
  final String userDid; // 유저 did
  final String userId; // 유저 아이디
  final String userPw; // 유저 비밀번호
  final String userName; // 유저 이름
  final String userDef; // 유저 프로필 설명
  final String userType; // 봉사자, 기관 구분용
  final String birth; // 유저 생일

  const UserProfileCard({
    super.key,
    required this.userDid,
    required this.userId,
    required this.userPw,
    required this.userName,
    required this.userDef,
    required this.userType,
    required this.birth,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // context.pushNamed(
        //   UserInformUpdate.routeName,
        //   extra: UserInformArgs(
        //     userDid: userDid,
        //     userId: userId,
        //     userPw: userPw,
        //     userName: userName,
        //     userDef: userDef,
        //     userType: userType,
        //     birth: birth,
        //   ),
        // );
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
