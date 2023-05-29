import 'package:flutter/material.dart';

class ClubPostWritePage extends StatelessWidget {
  const ClubPostWritePage({super.key});

  AppBar _appBar() {
    return AppBar(
      title: const Text("동아리 게시글 작성"),
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
