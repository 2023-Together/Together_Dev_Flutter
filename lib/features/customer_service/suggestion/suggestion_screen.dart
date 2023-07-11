import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({
    super.key,
    required this.isLogined,
  });

  final bool isLogined;

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

  void _textOnChange(String value) {
    setState(() {
      _isThereSearchValue = _contentController.text.trim().isNotEmpty;
    });
  }

  Future<void> _onSubmitFinishButton() async {
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
        fontSize: 16,
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
            Gaps.v10,
            _title(title: "건의 내용"),
            Gaps.v10,
            SWAGTextField(
              hintText:
                  widget.isLogined ? "추가 되었으면 하는 내용을 입력해주세요." : "로그인을 해야합니다!",
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
