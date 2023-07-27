import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({
    super.key,
  });

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  late TextEditingController _contentController;
  late TextEditingController _emailController;

  bool _isThereSearchValue = false;
  String? _emailError;

  String _category = "";
  final List<String> _categoryList = [
    "",
    "계정",
    "오류",
    "기능",
    "신고",
    "기타",
  ];

  @override
  void initState() {
    super.initState();

    _contentController = TextEditingController();
    _emailController = TextEditingController();
  }

  void _onChangeOption(String option) {
    setState(() {
      _category = option;
    });
  }

  Future<void> _onSubmitFinishButton() async {
    print("메일 : ${_emailController.text}");
    print("유형 : $_category");
    print("내용 : ${_contentController.text}");
  }

  void _emailOnChange(String? value) {
    _validateEmail(_emailController.text);
    _textOnChange(value);
  }

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue =
          (_emailError == null && _emailController.text.trim().isNotEmpty) &&
              _contentController.text.trim().isNotEmpty;
    });
  }

  bool _validateEmail(String value) {
    print(context.read<UserProvider>().isLogined);
    // 이메일 정규식 패턴
    RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9]+\.)+[a-zA-Z]{2,}$');
    if (value.isEmpty) {
      setState(() {
        _emailError = '이메일을 입력해주세요.';
      });
      return false;
    } else if (!emailRegex.hasMatch(value)) {
      setState(() {
        _emailError = '올바른 이메일 주소를 입력해주세요.';
      });
      return false;
    }
    setState(() {
      _emailError = null;
    });
    return true;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.read<UserProvider>().isLogined;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size8,
          horizontal: Sizes.size12,
        ),
        child: ElevatedButton(
          onPressed:
              isLogined && _isThereSearchValue ? _onSubmitFinishButton : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
          ),
          child: Text(isLogined ? "등록" : "로그인을 해야합니다!"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            Text(
              "답변받을 이메일",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            SWAGTextField(
              hintText: "메일주소를 입력해주세요.",
              maxLine: 1,
              controller: _emailController,
              onSubmitted: _onSubmitFinishButton,
              onChanged: _emailOnChange,
              errorText: _emailError,
            ),
            Gaps.v20,
            Text(
              "문의 유형",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            SWAGStateDropDownButton(
              initOption: _category,
              onChangeOption: _onChangeOption,
              title: "카테고리를 선택",
              options: _categoryList,
              isExpanded: true,
              width: double.infinity,
              height: 60,
              fontSize: 18,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            Gaps.v20,
            Text(
              "문의 내용",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Gaps.v10,
            SWAGTextField(
              hintText: "문의할 내용을 입력해주세요.",
              maxLine: 10,
              controller: _contentController,
              onSubmitted: _onSubmitFinishButton,
              onChanged: _textOnChange,
            ),
            Gaps.v10,
          ],
        ),
      ),
    );
  }
}
