import 'package:flutter/material.dart';

class ClubPostUpdateScreen extends StatelessWidget {
  const ClubPostUpdateScreen({super.key});

  AppBar _appBar() {
    return AppBar(
      title: const Text("동아리 게시글 수정"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(),
    );
  }
}
