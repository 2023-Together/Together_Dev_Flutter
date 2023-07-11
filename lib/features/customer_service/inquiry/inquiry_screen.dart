import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class InquiryScreen extends StatefulWidget {
  const InquiryScreen({
    super.key,
    required this.isLogined,
  });

  final bool isLogined;

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  late TextEditingController _contentController;
  late TextEditingController _emailController;

  bool _isThereSearchValue = false;

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

  void _textOnChange(String value) {
    setState(() {
      _isThereSearchValue = _emailController.text.trim().isNotEmpty &&
          _contentController.text.trim().isNotEmpty;
    });
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

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 53, 50, 50),
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed: widget.isLogined && _isThereSearchValue
              ? _onSubmitFinishButton
              : null,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            backgroundColor: Colors.purple.shade300,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text("등록"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            _title(title: "답변받을 이메일"),
            Gaps.v10,
            SWAGTextField(
              hintText: widget.isLogined ? "메일주소를 입력해주세요." : "로그인을 해야합니다!",
              maxLine: 1,
              controller: _emailController,
              isLogined: true,
              onSubmitted: _onSubmitFinishButton,
              onChanged: _textOnChange,
            ),
            Gaps.v20,
            _title(title: "문의 유형"),
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
            _title(title: "문의 내용"),
            Gaps.v10,
            SWAGTextField(
              hintText: widget.isLogined ? "문의할 내용을 입력해주세요." : "로그인을 해야합니다!",
              maxLine: 10,
              controller: _contentController,
              isLogined: true,
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
