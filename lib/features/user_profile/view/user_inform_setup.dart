import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

class UserInformSetup extends StatefulWidget {
  static const routeName = "user_setup";
  static const routeURL = "/user_setup";

  const UserInformSetup({super.key});

  @override
  State<UserInformSetup> createState() => _UserInformSetupState();
}

class _UserInformSetupState extends State<UserInformSetup> {
  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
          color: Color.fromARGB(255, 152, 152, 152),
          fontSize: 15,
          fontWeight: FontWeight.w700,
          height: 3),
    );
  }

  // 회원 탈퇴
  void onLogoutAllTap(BuildContext context) {
    LoginStorage.resetLoginData();
    context.read<UserProvider>().logout();
    context.pushReplacementNamed(MainNavigation.routeName);
  }

  // 로그아웃
  void onLogoutTap(BuildContext context) {
    context.read<UserProvider>().logout();
    context.pushReplacementNamed(MainNavigation.routeName);
  }

  // // 회원 정보 수정
  // void userInformUpdateTap(BuildContext context) {
  //   context.pushNamed(UserInformUpdate.routeName,
  //       extra: UserInformArgs(
  //           userDid: userDid,
  //           userId: widget.userId,
  //           userPw: widget.userPw,
  //           userName: widget.userName,
  //           userDef: widget.userDef,
  //           userType: widget.userType,
  //           birth: widget.birth));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 30.0),
        child: ListView(
          children: [
            _title(title: "회원 정보"),
            Card(
              elevation: 0,
              child: ListTile(
                title: const Text(
                  "회원 정보 수정",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            _title(title: "서비스"),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "앱 정보",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "이용 약관",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            _title(title: "고객 센터"),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "공지사항",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "자주 묻는 질문 (FnQ)",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            const Card(
              elevation: 0,
              child: ListTile(
                title: Text(
                  "QnA",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            _title(title: "로그아웃"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => onLogoutTap(context),
                title: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () => onLogoutAllTap(context),
                title: const Text(
                  "회원 탈퇴",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                  ),
                ),
                trailing: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
