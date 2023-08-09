import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

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
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');

      final userData = result.account;
      print(userData);

      final url = Uri.parse("http://59.4.3.198:80/together/login");
      // final headers = {'Content-Type': 'application/json'};
      final data = {"userEmail": userData.email};

      final response = await http.post(url, body: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse.isEmpty) {
          print("로그인 실패");
          if (!mounted) return;
          swagPlatformDialog(
            context: context,
            title: "로그인 실패!",
            message: "로그인이 실패하였습니다!",
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("알겠습니다"),
              ),
            ],
          );
        } else {
          if (!mounted) return;
          context.read<UserProvider>().login(UserModel.fromJson(jsonResponse));
          LoginStorage.saveLoginData(email: userData.email);
          context.pop();
        }
      } else {
        print("로그인 실패");
        if (!mounted) return;
        swagPlatformDialog(
          context: context,
          title: "로그인 실패!",
          message: "${response.statusCode} : ${response.body}",
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("알겠습니다"),
            ),
          ],
        );
      }
    } else {
      if (!mounted) return;
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

  // 네이버 회원가입
  void _signUpForNaver(BuildContext context) async {
    if (!mounted) return;
    final UserModel updateData = UserModel(
      userId: 3,
      userEmail: "dlwogus1027@naver.com",
      userPhoneNumber: "01049049193",
      userName: "이재현",
      userNickname: "푸른함대앤디",
      userGender: 0,
      userBirthdate: DateTime.parse("1999-10-27"),
      userDef: "안녕하세요!",
      userType: "user",
    );

    context.read<UserProvider>().login(updateData);
    context.pop();
  }

  // 카카오 로그인
  void _signInForKakao(BuildContext context) async {
    // await LoginStorage.saveLoginType("kakao");

    context.pop();
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

    context.pop();
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
