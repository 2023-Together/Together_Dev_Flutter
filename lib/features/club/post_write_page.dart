import 'package:flutter/material.dart';
import 'package:swag_cross_app/features/club/locationListBottomSheet.dart';

class PostWritePage extends StatelessWidget {
  const PostWritePage({super.key});

  onTap(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("활동 지역 선택"),
            centerTitle: false,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            child: ListView(
              children: [
                for (var location in LocationListBottomSheet.locations)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    child: Text(
                      location,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textField({
    required String hintText,
    required int maxLines,
  }) {
    return TextField(
      maxLines: maxLines,
      cursorColor: const Color(0xFf6524FF),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF767676).withOpacity(0.5),
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

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text("게시글 작성"),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            "완료",
            style: TextStyle(
              color: Color(0xFF6524FF),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(title: "제목"),
          const SizedBox(height: 10),
          _textField(hintText: "글 제목을 입력해주세요.", maxLines: 1),
          const SizedBox(height: 40),
          _title(title: "내용"),
          const SizedBox(height: 10),
          _textField(hintText: "내용을 입력해주세요.", maxLines: 14),
          const SizedBox(height: 40),
          _title(title: "활동 지역"),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              onTap(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFDBDBDB),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("전국", style: TextStyle(fontSize: 20)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBarWidget(),
      body: _bodyWidget(context),
    );
  }
}
