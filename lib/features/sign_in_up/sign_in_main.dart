import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_main.dart';
import 'package:swag_cross_app/features/sign_in_up/widgets/auth_button.dart';

class SignInMain extends StatefulWidget {
  const SignInMain({super.key});

  @override
  State<SignInMain> createState() => _SignInMainState();
}

class _SignInMainState extends State<SignInMain> {
  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpMain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(SecureStorageLogin.getLoginType());
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          children: [
            Gaps.v36,
            SignInButton(
              path: "naver",
              text: "네이버 로그인",
              signType: SNSType.naver,
              authType: SignType.signIn,
            ),
            Gaps.v16,
            SignInButton(
              path: "kakao",
              text: "카카오 로그인",
              signType: SNSType.kakao,
              authType: SignType.signIn,
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
