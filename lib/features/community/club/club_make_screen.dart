import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ClubMakeScreen extends StatefulWidget {
  static const routeName = "club_edit";
  static const routeURL = "/club_edit";
  const ClubMakeScreen({super.key});

  @override
  State<ClubMakeScreen> createState() => _ClubMakeScreenState();
}

class _ClubMakeScreenState extends State<ClubMakeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isThereSearchValue = false;
  bool _isRequest = false;

  void _textOnChange(String? value) {
    setState(() {
      _isThereSearchValue = _titleController.text.trim().isNotEmpty &&
          _contentController.text.trim().isNotEmpty;
    });
  }

  Future<void> _onSubmitFinishButton() async {
    print("제목 : ${_titleController.text}");
    print("내용 : ${_contentController.text}");
  }

  void _onChangeCheckBox(bool? value) {
    if (value == null) return;
    setState(() {
      _isRequest = value;
    });
  }

  void _onTapCheckBoxText() {
    setState(() {
      _isRequest = !_isRequest;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
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
                controller: _titleController,
                onSubmitted: () {
                  print(_titleController.text);
                },
                onChanged: _textOnChange,
              ),
              Gaps.v40,
              Text(
                "상세 설명",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Gaps.v10,
              SWAGTextField(
                hintText: "동아리의 주요 활동 내용을 입력해주세요.",
                maxLine: 6,
                controller: _contentController,
                onSubmitted: () {
                  print(_contentController.text);
                },
                onChanged: _textOnChange,
              ),
              Gaps.v20,
              Row(
                children: [
                  Checkbox.adaptive(
                    value: _isRequest,
                    onChanged: _onChangeCheckBox,
                  ),
                  GestureDetector(
                    onTap: _onTapCheckBoxText,
                    child: const Text("동아리원 모집 여부"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
