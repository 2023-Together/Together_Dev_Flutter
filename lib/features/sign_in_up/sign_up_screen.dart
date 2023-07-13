import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_up/enums/login_platform.dart';
import 'package:swag_cross_app/features/sign_in_up/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = "signup";
  static const routeURL = "/signup";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          children: [
            Gaps.v36,
            SignInButton(
              path: "naver",
              text: "네이버 회원가입",
              signType: SNSType.naver,
              authType: SignType.signUp,
            ),
          ],
        ),
      ),
    );
  }
}
