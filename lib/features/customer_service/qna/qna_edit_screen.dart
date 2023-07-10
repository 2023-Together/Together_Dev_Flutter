import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class QnAEditScreenArgs {
  final int id;
  final String title;
  final String content;

  QnAEditScreenArgs({
    required this.id,
    required this.title,
    required this.content,
  });
}

class QnAEditScreen extends StatefulWidget {
  static const routeName = "qna_edit";
  static const routeURL = "qna_edit";

  const QnAEditScreen({
    super.key,
    this.id,
    this.title,
    this.content,
  });

  final int? id;
  final String? title;
  final String? content;

  @override
  State<QnAEditScreen> createState() => _QnAEditScreenState();
}

class _QnAEditScreenState extends State<QnAEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  late bool _isThereSearchValue =
      _titleController.text.isNotEmpty && _contentController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.title ?? "");
    _contentController = TextEditingController(text: widget.content ?? "");
  }

  Future<void> _onSubmitFinishButton() async {
    print("제목 : ${_titleController.text}");
    print("내용 : ${_contentController.text}");
  }

  void _textOnChange(String value) {
    setState(() {
      _isThereSearchValue = _titleController.text.isNotEmpty &&
          _contentController.text.isNotEmpty;
    });
  }

  SliverAppBar _appBar() {
    return const SliverAppBar(
      title: Text("QnA 작성"),
    );
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
          onPressed: _titleController.text.trim().isNotEmpty &&
                  _contentController.text.trim().isNotEmpty
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            _appBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v10,
                    _title(title: "제목"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "글 제목을 입력해주세요.",
                      maxLine: 1,
                      controller: _titleController,
                      isLogined: true,
                      onSubmitted: () {
                        print(_titleController.text);
                      },
                      onChanged: _textOnChange,
                    ),
                    Gaps.v40,
                    _title(title: "내용"),
                    Gaps.v10,
                    SWAGTextField(
                      hintText: "내용을 입력해주세요.",
                      maxLine: 6,
                      controller: _contentController,
                      isLogined: true,
                      onSubmitted: () {
                        print(_contentController.text);
                      },
                      onChanged: _textOnChange,
                    ),
                    Gaps.v10,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
