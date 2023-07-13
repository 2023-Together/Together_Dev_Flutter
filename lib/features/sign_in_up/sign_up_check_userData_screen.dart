import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_up_id_pw_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class SignUpCheckUserDataScreenArgs {
  const SignUpCheckUserDataScreenArgs({
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.profileImage,
    required this.mobile,
  });

  final String name;
  final String email;
  final String gender;
  final String birthday;
  final String profileImage;
  final String mobile;
}

class SignUpCheckUserDataScreen extends StatelessWidget {
  static const routeName = "signup_check_userData";
  static const routeURL = "signup_check_userData";

  const SignUpCheckUserDataScreen({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthday,
    required this.profileImage,
    required this.mobile,
  });

  final String name;
  final String email;
  final String gender;
  final String birthday;
  final String profileImage;
  final String mobile;

  void _onDataCheckSubmitted(BuildContext context) {
    swagPlatformDialog(
      context: context,
      title: "주의!",
      message:
          "이후에 개인정보를 수정하려면 NAVER에서 정보를 수정하고 다시 요청해야 합니다!\n이정보가 당신의 정보가 맞습니까?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () => context.pushNamed(
            SignUpIdPwScreen.routeName,
            extra: SignUpIdPwScreenArgs(
              name: name,
              email: email,
              gender: gender,
              birthday: birthday,
              profileImage: profileImage,
              mobile: mobile,
            ),
          ),
          child: const Text("예"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("네이버 정보확인"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gaps.v10,
            UserDataBox(
              name: "이름",
              data: name.replaceRange(1, 2, "*"),
            ),
            UserDataBox(
              name: "이메일",
              data: email,
            ),
            UserDataBox(
              name: "성별",
              data: gender == "M" ? "남" : "여",
            ),
            UserDataBox(
              name: "생년월일",
              data: birthday,
            ),
            UserDataBox(
              name: "전화번호",
              data: mobile,
            ),
            Gaps.v20,
            Text(
              "주의사항 : 현재의 데이터 중에서 틀린 부분이 있으면 네이버계정 정보를 수정후 다시 회원가입을 시도하시기 바랍니다!",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Gaps.v10,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size10,
        ),
        child: ElevatedButton(
          onPressed: () => _onDataCheckSubmitted(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.size16,
            ),
            child: Text("확인완료"),
          ),
        ),
      ),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.data,
    required this.name,
  });

  final String name;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.size5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Gaps.h10,
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Text(
                data,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
