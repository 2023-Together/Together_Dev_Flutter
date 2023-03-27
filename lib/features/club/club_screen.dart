import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/features/club/locationListBottomSheet.dart';
import 'package:swag_cross_app/features/club/post_write_page.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  AppBar _appBarWidget() {
    return AppBar(
      title: const Text("커뮤니티"),
      actions: const [LocationListBottomSheet()],
    );
  }

  _social(IconData icon, int count) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF7D7D7D),
        ),
        const SizedBox(width: 5),
        Text(
          "$count",
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFF7D7D7D),
          ),
        ),
      ],
    );
  }

  Widget _postWidget({
    required String title,
    required String content,
    required String writer,
    required DateTime writeTime,
    required int viewCount,
    required int likeCount,
    required int commentCount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "$writer · 46분전",
                style: const TextStyle(
                  color: Color(0xFF7D7D7D),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "조회수 $viewCount",
                      style: const TextStyle(
                        color: Color(0xFF7D7D7D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  height: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              _social(FontAwesomeIcons.heart, likeCount),
              const SizedBox(width: 10),
              _social(FontAwesomeIcons.comment, commentCount),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      color: const Color(0xFFDBDBDB),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView.separated(
        itemCount: 5, //게시글 개수
        itemBuilder: (context, index) {
          return _postWidget(
            title: "[진주나뭇잎] 팀원을 모집합니다.",
            content:
                "[진주나뭇잎]팀원을 모집합니다. 진주나 가까운 지역에\n서 주로 봉사를 하는데 열심히 하실 분들 많이 오...",
            writer: "투게더",
            writeTime: DateTime.now(),
            viewCount: 5,
            likeCount: 12,
            commentCount: 5,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6524FF),
        child: const Icon(FontAwesomeIcons.pen),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const PostWritePage();
              },
            ),
          );
        },
      ),
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}