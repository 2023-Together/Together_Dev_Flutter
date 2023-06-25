import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class ClubPostUpdateScreen extends StatefulWidget {
  static const routeName = "post_update";
  static const routeURL = "/post_update";
  const ClubPostUpdateScreen({super.key});

  @override
  State<ClubPostUpdateScreen> createState() => _ClubPostUpdateScreenState();
}

class _ClubPostUpdateScreenState extends State<ClubPostUpdateScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("동아리 게시글 수정"),
      actions: [
        TextButton(
          child: const Text(
            "완료",
            style: TextStyle(
              color: Color(0xFF6524FF),
              fontSize: 18,
            ),
          ),
          onPressed: () {
            // 글 작성
            var title = _titleController.text;
            var content = _contentController.text;
            if (title == "" || content == "") return;
            print("글작성");
            print("제목: $title");
            print("내용: $content");
          },
        ),
      ],
    );
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF767676),
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _textField({
    required String hintText,
    required int maxLine,
    required TextEditingController controller,
  }) {
    return TextField(
      maxLines: maxLine,
      controller: controller,
      cursorColor: const Color(0xFf6524FF),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF767676).withOpacity(0.7),
          fontSize: 18,
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFDBDBDB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFF6524FF),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF191919),
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(title: "카테고리"),
            Gaps.v10,
            GestureDetector(
              // 게시글 데이터베이스 중 post_tag (무슨 태그 있는진 아직 모름)
              onTap: () {
                // Bottom Sheet 올라와서 tag 선택가능하도록
                print("카테고리 선택");
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "카테고리를 선택해주세요.",
                      style: TextStyle(
                        color: const Color(0xFF767676).withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            Gaps.v40,
            _title(title: "제목"),
            Gaps.v10,
            _textField(
              hintText: "글 제목을 입력해주세요.",
              maxLine: 1,
              controller: _titleController,
            ),
            Gaps.v40,
            _title(title: "내용"),
            Gaps.v10,
            Expanded(
              child: Container(
                child: _textField(
                  hintText: "내용을 입력해주세요.",
                  maxLine: 100,
                  controller: _contentController,
                ),
              ),
            ),
            Gaps.v10,
          ],
        ),
      ),
    );
  }
}
