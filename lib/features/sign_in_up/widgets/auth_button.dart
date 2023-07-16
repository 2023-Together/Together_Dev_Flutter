import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_check_userData_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

import 'package:http/http.dart' as http;

class AuthButton extends StatefulWidget {
  const AuthButton({
    super.key,
    required this.signType,
    required this.authType,
    required this.text,
    required this.path,
  });

  final String path;
  final String text;
  final SNSType signType;
  final SignType authType;

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  void initState() {
    super.initState();

    // SecureStorageLogin.loginCheckIsSNS(context, mounted);
  }

  void _onAuthButton(BuildContext context) {
    switch (widget.authType) {
      case SignType.signIn: // 로그인
        switch (widget.signType) {
          case SNSType.naver: // 네이버
            _signInForNaver(context);
            break;
          case SNSType.kakao: // 카카오
            _signInForKakao(context);
            break;
          default:
        }
        break;
      case SignType.signUp: // 회원가입
        switch (widget.signType) {
          case SNSType.naver: // 네이버
            _signUpForNaver(context);
            break;
          case SNSType.kakao: // 카카오
            _signUpForKakao(context);
            break;
          default:
        }
        break;
      default:
    }
  }

  // 네이버 로그인
  void _signInForNaver(BuildContext context) async {
    // 사용횟수가 정해져 있어서 테스트할때 주석을 풀어야함
    // final NaverLoginResult result = await FlutterNaverLogin.logIn();

    // if (!mounted) return;
    // if (result.status == NaverLoginStatus.loggedIn) {
    //   print('accessToken = ${result.accessToken}');

    //   final userData = result.account;
    //   print(userData);

    //   context.read<UserProvider>().login("naver");
    //   context.goNamed(MainNavigation.routeName);
    // } else {
    //   swagPlatformDialog(
    //     context: context,
    //     title: "오류!",
    //     message: result.errorMessage,
    //     actions: [
    //       TextButton(
    //         onPressed: () => context.pop(),
    //         child: const Text("알겠습니다"),
    //       ),
    //     ],
    //   );
    // }

    final url = Uri.parse("http://112.164.125.246:8080/together/selectAllUser");
    final response = await http.get(url, headers: {});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (!mounted) return;
    context.read<UserProvider>().login("naver");
    context.goNamed(MainNavigation.routeName);
  }

  // 네이버 회원가입
  void _signUpForNaver(BuildContext context) async {
    // 사용횟수가 정해져 있어서 테스트할때 주석을 풀어야함
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (!mounted) return;
    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');

      final userData = result.account;
      print(userData);

      // await SecureStorageLogin.saveLoginType("naver");
      context.pushNamed(
        SignUpCheckUserDataScreen.routeName,
        extra: SignUpCheckUserDataScreenArgs(
          name: userData.name,
          email: userData.email,
          gender: userData.gender,
          birthday: "${userData.birthyear}-${userData.birthday}",
          profileImage: userData.profileImage,
          mobile: userData.mobile,
        ),
      );
    } else {
      swagPlatformDialog(
        context: context,
        title: "오류!",
        message: result.errorMessage,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  // 카카오 로그인
  void _signInForKakao(BuildContext context) async {
    // await LoginStorage.saveLoginType("kakao");

    if (!mounted) return;
    context.goNamed(MainNavigation.routeName);
  }

  // 카카오 회원가입
  void _signUpForKakao(BuildContext context) {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const MainPage(),
    //   ),
    //   (route) {
    //     // true : 이전의 페이지들을 유지
    //     // false : 이전의 페이지들을 제거
    //     return true;
    //   },
    // );
    context.goNamed(MainNavigation.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAuthButton(context),
      // FractionallySizedBox : 부모 크기에 비례해서 크기를 정하게 해주는 위젯
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          children: [
            Container(
              height: Sizes.size64,
              // Container 안에 있는 padding의 타입은 EdgeInsets 이다.
              padding: const EdgeInsets.all(Sizes.size14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: Sizes.size1,
                ),
              ),
              // Column : 위젯을 세로로 차례대로 배치
              // Row : 위젯을 가로로 차례대로 배치
              // Stack : 위젯을 위에다가 겹쳐서 배치(레이어 같은 개념)
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/${widget.path}.png',
                      width: Sizes.size40,
                    ),
                  ),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
