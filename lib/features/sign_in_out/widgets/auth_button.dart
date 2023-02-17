import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main/main_page.dart';

// SNS 타입 지정
enum SignType {
  facebook,
  google,
  kakao,
  naver,
  apple,
  none, // logout
}

// 로그인 / 로그아웃 타입 지정
enum AuthType {
  signIn, // 로그인
  signUp, // 로그아웃
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.signType,
    required this.authType,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
  final SignType signType;
  final AuthType authType;

  void _onAuthButton(BuildContext context) {
    switch (authType) {
      case AuthType.signIn: // 로그인
        switch (signType) {
          case SignType.naver: // 네이버
            _signInForNaver(context);
            break;
          case SignType.kakao: // 카카오
            _signInForKakao(context);
            break;
          default:
        }

        break;
      case AuthType.signUp: // 회원가입
        switch (signType) {
          case SignType.naver: // 네이버
            _signUpForNaver(context);
            break;
          case SignType.kakao: // 카카오
            _signUpForKakao(context);
            break;
          default:
        }
        break;
      default:
    }
  }

  // 네이버 로그인
  void _signInForNaver(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) {
        // true : 이전의 페이지들을 유지
        // false : 이전의 페이지들을 제거
        return true;
      },
    );
  }

  // 네이버 회원가입
  void _signUpForNaver(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) {
        // true : 이전의 페이지들을 유지
        // false : 이전의 페이지들을 제거
        return true;
      },
    );
  }

  // 카카오 로그인
  void _signInForKakao(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) {
        // true : 이전의 페이지들을 유지
        // false : 이전의 페이지들을 제거
        return true;
      },
    );
  }

  // 카카오 회원가입
  void _signUpForKakao(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainPage(),
      ),
      (route) {
        // true : 이전의 페이지들을 유지
        // false : 이전의 페이지들을 제거
        return true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAuthButton(context),
      // FractionallySizedBox : 부모 크기에 비례해서 크기를 정하게 해주는 위젯
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
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
                child: FaIcon(icon),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
