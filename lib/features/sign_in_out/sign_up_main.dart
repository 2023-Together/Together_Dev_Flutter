import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_out/sign_in_main.dart';

class SignUpMain extends StatelessWidget {
  const SignUpMain({super.key});

  void _onSignInTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInMain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: Container(),
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
                onTap: () => _onSignInTap(context),
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
