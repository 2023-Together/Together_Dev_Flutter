import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:swag_cross_app/constants/http_ip.dart';

class ClubMakeScreen extends StatefulWidget {
  static const routeName = "club_edit";
  static const routeURL = "/club_edit";
  const ClubMakeScreen({super.key});

  @override
  State<ClubMakeScreen> createState() => _ClubMakeScreenState();
}

class _ClubMakeScreenState extends State<ClubMakeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isThereSearchValue = false;
  bool _isAuthClubName = false;
  String? _clubNameError;
  String? _clubNameHelper;

  Future<void> _onCheckClubName() async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getClubByClubName");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "clubName": _nameController.text,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        _isAuthClubName = true;
        _clubNameHelper = "인증이 완료되었습니다!";
        _textOnChange("");
      });
    } else if (response.statusCode == 409) {
      setState(() {
        _clubNameError = "중복된 닉네임이 존재합니다!";
        _textOnChange("");
      });
    } else {
      print("${response.statusCode} : ${response.body}");
      setState(() {
        _clubNameError = "통신 실패!";
        _textOnChange("");
      });
    }
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = (_isAuthClubName &&
              _clubNameError == null &&
              _clubNameHelper != null) &&
          _contentController.text.trim().isNotEmpty;
    });
  }

  void _onChangeClubName(String? value) {
    setState(() {
      _isAuthClubName = false;
      _clubNameError = null;
      _clubNameHelper = null;
      _textOnChange("");
    });
  }

  Future<void> _onSubmitFinishButton() async {
    final url = Uri.parse("${HttpIp.communityUrl}/together/club/createClub");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "clubLeaderId": "1",
      "clubName": _nameController.text,
      "clubDescription": _contentController.text,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (!mounted) return;
      context.pop();
    } else {
      print("${response.statusCode} : ${response.body}");
      if (!mounted) return;
      swagPlatformDialog(
        context: context,
        title: "오류",
        message: "동아리 생성에 오류가 발생하였습니다!",
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("동아리 등록"),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ElevatedButton(
            onPressed: _isThereSearchValue ? _onSubmitFinishButton : null,
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text("등록"),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
            vertical: Sizes.size6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "동아리 이름",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "동아리 이름을 입력해주세요.",
                maxLine: 1,
                controller: _nameController,
                onChanged: _onChangeClubName,
                buttonText: "중복확인",
                onSubmitted: _onCheckClubName,
                errorText: _clubNameError,
                helperText: _clubNameHelper,
              ),
              Gaps.v40,
              Text(
                "상세 설명",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "동아리의 상세 설명과 활동 내용을 입력해주세요.",
                maxLine: 8,
                controller: _contentController,
                onSubmitted: () {
                  print(_contentController.text);
                },
                onChanged: _textOnChange,
              ),
              // Gaps.v20,
              // SwitchListTile.adaptive(
              //   tileColor: Colors.white,
              //   value: _clubApply,
              //   onChanged: (value) => setState(() {
              //     _clubApply = !_clubApply;
              //   }),
              //   title: const Text("동아리 신청 받기 여부"),
              //   subtitle: const Text(
              //     "활성화 해야 새로운 동아리원을 신청 받을수 있습니다!",
              //     maxLines: 2,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}