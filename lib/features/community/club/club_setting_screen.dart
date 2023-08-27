import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/features/community/club/club_select_screen.dart';
import 'package:swag_cross_app/features/community/club/request_club_apply.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';
import 'package:swag_cross_app/providers/club_list_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/constants/httpIp.dart';

class ClubSettingScreenArgs {
  final ClubDataModel clubData;

  ClubSettingScreenArgs({required this.clubData});
}

class ClubSettingScreen extends StatefulWidget {
  static const routeName = "club_setting";
  static const routeURL = "club_setting";
  const ClubSettingScreen({
    super.key,
    required this.clubData,
  });

  final ClubDataModel clubData;

  @override
  State<ClubSettingScreen> createState() => _ClubSettingScreenState();
}

class _ClubSettingScreenState extends State<ClubSettingScreen> {
  final TextEditingController _clubContentController = TextEditingController();

  bool _clubApply = false;
  bool _isClubDef = false;
  int _applyLength = 0;

  @override
  void initState() {
    super.initState();

    _clubApply = widget.clubData.clubRecruiting;
    if (widget.clubData.clubDescription.isNotEmpty) {
      _clubContentController.text = widget.clubData.clubDescription;
    }

    _getApplyLengthDispatch();
  }

  void _requestJoinTap() {
    context.pushNamed(
      RequestClubApply.routeName,
      extra: RequestClubApplyArgs(clubData: widget.clubData),
    );
  }

  void _clubMembersChecTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClubSelectScreen(
          clubData: widget.clubData,
        ),
      ),
    );
  }

  void _onChangeClubRecruiting(bool value) async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/updateClubRecruiting");
    final headers = {'Content-Type': 'application/json'};
    final data = {"clubId": "3", "clubRecruiting": _clubApply ? 1 : 0};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("동아리 신청 여부 변경 : 성공");
      setState(() {
        _clubApply = !_clubApply;
      });
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
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
          onPressed: () async {
            final userData = context.read<UserProvider>().userData;
            final url =
                Uri.parse("${HttpIp.communityUrl}/together/club/deleteClub");
            final headers = {'Content-Type': 'application/json'};
            final data = {
              "clubId": widget.clubData.clubId,
              "clubLeaderId": userData!.userId,
            };

            final response =
                await http.post(url, headers: headers, body: jsonEncode(data));

            if (!mounted) return;
            if (response.statusCode >= 200 && response.statusCode < 300) {
              print("동아리 삭제 : 성공");

              context
                  .read<ClubListProvider>()
                  .myClubGetDispatch(userId: userData.userId);
              context.pop();
              context.pop();
              context.pop();
            } else {
              print("${response.statusCode} : ${response.body}");
            }
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
          onPressed: () async {
            final userData = context.read<UserProvider>().userData;
            final url = Uri.parse(
                "${HttpIp.communityUrl}/together/club/withdrawalClub");
            final headers = {'Content-Type': 'application/json'};
            final data = {
              "memberClubId": widget.clubData.clubId,
              "memberUserId": userData!.userId,
            };

            final response =
                await http.post(url, headers: headers, body: jsonEncode(data));

            if (!mounted) return;
            if (response.statusCode >= 200 && response.statusCode < 300) {
              print("동아리 탈퇴 : 성공");
              context
                  .read<ClubListProvider>()
                  .myClubGetDispatch(userId: userData.userId);
              context.pop();
              context.pop();
              context.pop();
            } else {
              print("${response.statusCode} : ${response.body}");
              context.pop();
              context.pop();
              context.pop();
            }
          },
          child: const Text("예"),
        ),
      ],
    );
  }

  void _modifyClubContent() async {
    final userData = context.read<UserProvider>().userData;
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/updateClubDescription");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "clubId": widget.clubData.clubId,
      "clubLeaderId": userData!.userId,
      "clubDescription": _clubContentController.text,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("동아리 설명 수정 : 성공");
      widget.clubData.clubDescription = _clubContentController.text;
      setState(() {});
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  void _onChangeClubDef(String? value) {
    if (_clubContentController.text.trim().isNotEmpty) {
      setState(() {
        _isClubDef = true;
      });
    }
  }

  Future<void> _getApplyLengthDispatch() async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getJoinClubQueue");
    final headers = {'Content-Type': 'application/json'};
    final data = {"clubId": widget.clubData.clubId};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;

      _applyLength = jsonResponse.length;
      setState(() {});
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

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
  void dispose() {
    _clubContentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>().userData;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("동아리 관리"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            _getApplyLengthDispatch();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ListTile(
                  tileColor: Colors.white,
                  onTap: _clubMembersChecTap,
                  title: const Text("동아리원 목록"),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                  ),
                ),
              ),
              if (widget.clubData.clubLeaderId == userData!.userId)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    tileColor: Colors.white,
                    onTap: _requestJoinTap,
                    title: const Text("동아리 신청 현황"),
                    subtitle: Text("신청자 : $_applyLength명"),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    ),
                  ),
                ),
              if (widget.clubData.clubLeaderId == userData.userId)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ExpansionTile(
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
                        onChanged: _onChangeClubDef,
                      ),
                      ElevatedButton(
                        onPressed: _isClubDef ? _modifyClubContent : null,
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 30),
                        ),
                        child: const Text("수정"),
                      ),
                    ],
                  ),
                ),
              if (widget.clubData.clubLeaderId == userData.userId)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: SwitchListTile.adaptive(
                    tileColor: Colors.white,
                    value: _clubApply,
                    onChanged: (value) => _onChangeClubRecruiting(value),
                    title: const Text("동아리 신청 받기 여부"),
                    subtitle: const Text(
                      "활성화 해야 새로운 동아리원을 신청 받을수 있습니다!",
                      maxLines: 2,
                    ),
                  ),
                ),
              if (widget.clubData.clubLeaderId == userData.userId)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    tileColor: Colors.white,
                    onTap: _requestDeleteTap,
                    title: const Text("동아리 삭제"),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                    ),
                  ),
                ),
              // 동아리원의 기능
              if (widget.clubData.clubLeaderId != userData.userId)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: ListTile(
                    tileColor: Colors.white,
                    onTap: _requestOutTap,
                    title: const Text("동아리 탈퇴"),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
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
