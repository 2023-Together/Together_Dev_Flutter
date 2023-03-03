import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/route_manager.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main/main_page.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({
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
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  SNSType _loginPlatform = SNSType.none;

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
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');

      print(result.account);

      setState(() {
        _loginPlatform = SNSType.naver;
      });
    }
  }

  // 네이버 회원가입
  void _signUpForNaver(BuildContext context) async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    final response = await FlutterNaverLogin.currentAccount();

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');

      print("result : ${result.account}");
      print("response : $response");

      setState(() {
        _loginPlatform = SNSType.naver;
      });
    }
  }

  // 카카오 로그인
  void _signInForKakao(BuildContext context) {
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
    Get.off(() => const MainPage());
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
    Get.off(() => const MainPage());
  }

  void signOut() async {
    switch (_loginPlatform) {
      case SNSType.facebook:
        break;
      case SNSType.google:
        break;
      case SNSType.kakao:
        break;
      case SNSType.naver:
        await FlutterNaverLogin.logOut();
        break;
      case SNSType.apple:
        break;
      case SNSType.none:
        break;
    }

    setState(() {
      _loginPlatform = SNSType.none;
    });
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
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (_loginPlatform != SNSType.none)
              ElevatedButton(
                onPressed: signOut,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff0165E1),
                  ),
                ),
                child: const Text('로그아웃'),
              ),
          ],
        ),
      ),
    );
  }
}
