import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({
    super.key,
  });

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  late TextEditingController _contentController;

  bool _isThereSearchValue = false;

  @override
  void initState() {
    super.initState();

    _contentController = TextEditingController();
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = _contentController.text.trim().isNotEmpty;
    });
  }

  Future<void> _onSubmitFinishButton() async {
    final userData = context.read<UserProvider>().userData;
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/post/createSuggestion");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "postUserId": userData!.userId,
      "postContent": _contentController.text,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (!mounted) return;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("게시물 삭제 : 성공");
      swagPlatformDialog(
        context: context,
        title: "등록 성공",
        message: "건의 내용의 전달이 완료되었습니다!",
        actions: [
          TextButton(
            onPressed: () {
              _contentController.text = "";
              context.pop();
            },
            child: const Text("알겠습니다"),
          ),
        ],
      );
    } else {
      print(response.statusCode);
      print(response.body);
      swagPlatformDialog(
        context: context,
        title: "등록 실패",
        message: "건의 내용의 전달이 실패하였습니다!",
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("알겠습니다"),
          ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed:
              isLogined && _isThereSearchValue ? _onSubmitFinishButton : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(isLogined ? "등록" : "로그인을 해야합니다!"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v10,
            Text(
              "건의 내용",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            SWAGTextField(
              hintText: "추가 되었으면 하는 기능을 입력해주세요.",
              maxLine: 10,
              controller: _contentController,
              onChanged: _textOnChange,
            ),
            Gaps.v10,
          ],
        ),
      ),
    );
  }
}