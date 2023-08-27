import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_update.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class UserInformInquiry extends StatelessWidget {
  static const routeName = "user_inquiry";
  static const routeURL = "/user_inquiry";

  const UserInformInquiry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>().userData;

    DateTime? _birthday = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원 정보",
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24, vertical: Sizes.size16),
        child: Column(
          children: [
            UserDataBox(
              data: userData!.userEmail,
              name: "이메일",
              hint: "네이버에서 정보를 가져와주세요!",
            ),
            Text(
              "＃ 이메일을 통해 SNS 로그인이 진행되어 임의로 변경을 할 수 없습니다!",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Gaps.v10,
            UserDataBox(
              data: userData.userNickname,
              name: "닉네임(SNS)",
              hint: "네이버에서 가져온 정보",
            ),
            Gaps.v10,
            UserDataBox(
              data: userData.userName,
              name: "이름(실명)",
              hint: "봉사 신청 기능에 사용될 실명",
            ),
            Gaps.v10,
            UserDataBox(
              data: _birthday != null
                  ? '${_birthday!.year}-${_birthday!.month.toString().padLeft(2, '0')}-${_birthday!.day.toString().padLeft(2, '0')}'
                  : '없음',
              name: "생년월일",
              hint: "유저 생년월일",
            ),
            Gaps.v10,
            UserDataBox(
              data: userData.userPhoneNumber,
              name: "전화번호",
              hint: "유저 전화번호",
            ),
            Gaps.v10,
            Text(
              "＃ 하나의 핸드폰 번호를 여러개의 계정에 중복으로 등록할 수 없습니다!",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Gaps.v16,
            ElevatedButton(
              onPressed: () {
                context.pushNamed(UserInformUpdate.routeName);
              },
              child: Text("정보 수정"),
            ),
          ],
        ),
      )),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.data,
    required this.name,
    required this.hint,
  });

  final String name;
  final String data;
  final String hint;

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
            flex: 3,
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
                data.trim().isEmpty ? hint : data,
                style: data.trim().isEmpty
                    ? Theme.of(context).textTheme.labelLarge
                    : Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
