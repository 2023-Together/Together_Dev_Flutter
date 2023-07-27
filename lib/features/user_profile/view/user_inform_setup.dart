import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/providers/main_navigation_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

class UserInformSetup extends StatelessWidget {
  static const routeName = "user_setup";
  static const routeURL = "/user_setup";

  const UserInformSetup({super.key});

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 152, 152, 152),
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 3,
      ),
    );
  }

  // 회원 탈퇴
  void onLogoutAllTap(BuildContext context) {
    LoginStorage.resetLoginData();
    context.read<UserProvider>().logout();
    context.read<MainNavigationProvider>().changeIndex(0);
    context.pushReplacementNamed(MainNavigation.routeName);
  }

  // 로그아웃
  void onLogoutTap(BuildContext context) {
    context.read<UserProvider>().logout();
    LoginStorage.resetLoginData();
    context.read<MainNavigationProvider>().changeIndex(0);
    context.goNamed(MainNavigation.routeName);
  }

  // // 회원 정보 수정
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              trailing: IconButton(
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
                onPressed: () {
                  // context.pushNamed(
                  //   UserInformUpdate.routeName,
                  //   extra: UserInformArgs(
                  //       userDid: userDid,
                  //       userId: userId,
                  //       userPw: userPw,
                  //       userName: userName,
                  //       userDef: userDef,
                  //       userType: userType,
                  //       birth: birth),
                  // );
                },
              ),
            ),
          ),
          _title(title: "서비스"),
          Card(
            elevation: 0,
            child: ListTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LicensePage(),
                ),
              ),
              title: const Text(
                "앱 정보(라이센스)",
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
          Card(
            elevation: 0,
            child: ListTile(
              onTap: () => context.pushNamed(NoticeScreen.routeName),
              title: const Text(
                "공지사항",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
                onPressed: () {
                  context.pushNamed(
                    NoticeScreen.routeName,
                  );
                },
              ),
            ),
          ),
          _title(title: "고객 센터"),
          Card(
            elevation: 0,
            child: ListTile(
              onTap: () => context.pushNamed(
                CustomerServiceScreen.routeName,
                extra: CustomerServiceScreenArgs(initSelectedIndex: 0),
              ),
              title: const Text(
                "자주 묻는 질문 (FnQ)",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
                onPressed: () {
                  context.pushNamed(
                    CustomerServiceScreen.routeName,
                    extra: CustomerServiceScreenArgs(
                      initSelectedIndex: 0,
                    ),
                  );
                },
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: ListTile(
              onTap: () => context.pushNamed(
                CustomerServiceScreen.routeName,
                extra: CustomerServiceScreenArgs(initSelectedIndex: 1),
              ),
              title: const Text(
                "건의하기",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.chevron_right_rounded,
                  size: Sizes.size24,
                ),
                onPressed: () {
                  context.pushNamed(
                    CustomerServiceScreen.routeName,
                    extra: CustomerServiceScreenArgs(
                      initSelectedIndex: 1,
                    ),
                  );
                },
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
    );
  }
}
