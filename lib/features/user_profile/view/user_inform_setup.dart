import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/providers/main_navigation_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

import 'package:http/http.dart' as http;

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
  // void onLogoutAllTap(BuildContext context) {
  //   LoginStorage.resetLoginData();
  //   context.read<UserProvider>().logout();
  //   context.pushReplacementNamed(MainNavigation.routeName);
  // }

  // 로그아웃
  void onLogoutTap(BuildContext context) {
    context.read<UserProvider>().logout();
    LoginStorage.resetLoginData();
    context.read<MainNavigationProvider>().changeIndex(0);
    context.pop();
  }

  void _onDeleteTap(BuildContext context) async {
    final url = Uri.parse("http://59.4.3.198:80/together/delete");
    final data = {
      "userId": "${context.read<UserProvider>().userData?.userId}",
    };

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (!context.mounted) return;
      context.read<UserProvider>().logout();
      context.read<MainNavigationProvider>().changeIndex(0);
      context.pop();
    } else {
      print("삭제 실패");
      print("${response.statusCode} : ${response.body}");
    }
  }

  // // 회원 정보 수정
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title: "회원 정보"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "회원 정보 조회",
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
                onTap: () {
                  context.pushNamed(
                    NoticeScreen.routeName,
                  );
                },
                title: const Text(
                  "공지사항",
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
            _title(title: "고객 센터"),
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  context.pushNamed(
                    CustomerServiceScreen.routeName,
                    extra: CustomerServiceScreenArgs(
                      initSelectedIndex: 0,
                    ),
                  );
                },
                title: const Text(
                  "자주 묻는 질문 (FnQ)",
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
                onTap: () {
                  context.pushNamed(
                    CustomerServiceScreen.routeName,
                    extra: CustomerServiceScreenArgs(
                      initSelectedIndex: 1,
                    ),
                  );
                },
                title: const Text(
                  "건의하기",
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
                onTap: () => _onDeleteTap(context),
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
