import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_out/sign_up_main.dart';
import 'package:swag_cross_app/features/sign_in_out/widgets/auth_button.dart';

class SignInMain extends StatelessWidget {
  const SignInMain({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpMain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          children: const [
            Gaps.v36,
            SignInButton(
              icon: FontAwesomeIcons.houseChimney, // 추후 네이버 아이콘 삽입 예정
              text: "네이버 로그인",
              signType: SignType.naver,
              authType: AuthType.signIn,
            ),
            Gaps.v16,
            SignInButton(
              icon: FontAwesomeIcons.house, // 추후 카카오 아이콘 삽입 예정
              text: "카카오 로그인",
              signType: SignType.kakao,
              authType: AuthType.signIn,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "계정이 없으신가요?",
                style: TextStyle(
                  fontSize: Sizes.size18,
                ),
              ),
              Gaps.h10,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: const Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: Sizes.size18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
