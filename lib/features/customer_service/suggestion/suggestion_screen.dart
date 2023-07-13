import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

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
    print("내용 : ${_contentController.text}");
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
