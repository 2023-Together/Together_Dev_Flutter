import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/club/request_club_apply.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ClubSettingScreen extends StatefulWidget {
  static const routeName = "club_setting";
  static const routeURL = "club_setting";
  const ClubSettingScreen({super.key});

  @override
  State<ClubSettingScreen> createState() => _ClubSettingScreenState();
}

class _ClubSettingScreenState extends State<ClubSettingScreen> {
  final TextEditingController _clubContentController = TextEditingController();

  bool _clubApply = false;

  void _requestJoinTap() {
    context.pushNamed(RequestClubApply.routeName);
  }

  void _requestDeleteTap() {
    swagPlatformDialog(
      context: context,
      title: "동아리 삭제",
      message: "정말로 해당 동아리를 삭제 하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(
              MainNavigation.routeName,
              extra: MainNavigationArgs(initSelectedIndex: 2),
            );
          },
          child: const Text("예"),
        ),
      ],
    );
  }

  void _requestOutTap() {
    swagPlatformDialog(
      context: context,
      title: "동아리 탈퇴",
      message: "정말로 해당 동아리를 탈퇴 하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () {
            context.goNamed(
              MainNavigation.routeName,
              extra: MainNavigationArgs(initSelectedIndex: 2),
            );
          },
          child: const Text("예"),
        ),
      ],
    );
  }

  void _modifyClubContent() {}

  // void _DelegationClubMasterTap() {
  //   swagPlatformDialog(
  //     context: context,
  //     title: "동아리장 위임",
  //     message: "정말로 해당 동아리를 삭제 하시겠습니까?",
  //     actions: [
  //       TextButton(
  //         onPressed: () => context.pop(),
  //         child: const Text("아니오"),
  //       ),
  //       TextButton(
  //         onPressed: () {
  //           context.goNamed(
  //             MainNavigation.routeName,
  //             extra: MainNavigationArgs(initSelectedIndex: 2),
  //           );
  //         },
  //         child: const Text("예"),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("동아리 관리"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          children: [
            ListTile(
              tileColor: Colors.white,
              onTap: _requestJoinTap,
              title: const Text("동아리 신청 현황"),
              subtitle: const Text("신청자 : n명"),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
            ),
            Gaps.v6,
            ExpansionTile(
              title: const Text("동아리 설명 수정"),
              collapsedShape: const BeveledRectangleBorder(),
              shape: const BeveledRectangleBorder(),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              children: [
                SWAGTextField(
                  hintText: "수정할 동아리 설명을 입력해주세요",
                  maxLine: 4,
                  controller: _clubContentController,
                ),
                ElevatedButton(
                  onPressed: _clubContentController.text.trim().isNotEmpty
                      ? _modifyClubContent
                      : null,
                  child: const Text("수정"),
                ),
              ],
            ),
            Gaps.v6,
            SwitchListTile.adaptive(
              tileColor: Colors.white,
              value: _clubApply,
              onChanged: (value) => setState(() {
                _clubApply = !_clubApply;
              }),
              title: const Text("동아리 신청 받기 여부"),
              subtitle: const Text(
                "활성화 해야 새로운 동아리원을 신청 받을수 있습니다!",
                maxLines: 2,
              ),
            ),
            // Gaps.v6,
            // // 동아리장의 기능
            // const ListTile(
            //   tileColor: Colors.white,
            //   title: Text("동아리장 위임"),
            // ),
            Gaps.v6,
            ListTile(
              tileColor: Colors.white,
              onTap: _requestDeleteTap,
              title: const Text("동아리 삭제"),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
            ),
            Gaps.v6,
            // 동아리원의 기능
            ListTile(
              tileColor: Colors.white,
              onTap: _requestOutTap,
              title: const Text("동아리 탈퇴"),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
