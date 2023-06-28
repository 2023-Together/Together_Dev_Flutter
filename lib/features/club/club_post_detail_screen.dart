import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';

class ClubPostDetailScreen extends StatefulWidget {
  const ClubPostDetailScreen({
    super.key,
  });

  @override
  State<ClubPostDetailScreen> createState() => _ClubPostDetailScreenState();
}

class _ClubPostDetailScreenState extends State<ClubPostDetailScreen> {
  int selected = 0; // 게시글 내용, 댓글 toggle state

  List<Map<String, dynamic>> comments = [
    {
      "id": 1,
      "username": "홍길동",
      "comment": "여기 분위기는 어떤가요?",
      "date": "2023-05-22 01:19",
    },
    {
      "id": 2,
      "username": "홍길순",
      "comment": "언제까지 모집하나요?",
      "date": "2023-05-26 11:39",
    },
    {
      "id": 3,
      "username": "임대원",
      "comment": "제가 찾던 동아리입니다!",
      "date": "2023-05-28 15:12",
    },
  ];
  List<String> imgs = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _appBar() {
    return AppBar();
  }

  Widget introScreen() {
    return Column(
      children: [
        Image.asset("assets/images/dog.jpg"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "이것은 제목입니다.",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "이것은 내용입니다.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 200),
            ],
          ),
        ),
      ],
    );
  }

  Widget commentWidget({
    required String comment,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: Colors.grey.withOpacity(0.5),
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget commentScreen() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (var comment in comments)
            commentWidget(comment: comment['comment'], date: comment['date']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/77985708?v=4",
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                            Gaps.h10,
                            Column(
                              children: [
                                const Text(
                                  "user",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 1),
                                    Text(
                                      "120",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (selected == 0) return;
                            setState(() {
                              selected = 0;
                            });
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: selected == 0
                                  ? const Border(
                                      bottom:
                                          BorderSide(color: Color(0xFF6524FF)))
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "내용",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selected == 0
                                      ? const Color(0xFF6524FF)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (selected == 1) return;
                            setState(() {
                              selected = 1;
                            });
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: selected == 1
                                  ? const Border(
                                      bottom:
                                          BorderSide(color: Color(0xFF6524FF)))
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                "댓글 3",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selected == 1
                                      ? const Color(0xFF6524FF)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Offstage(offstage: selected != 0, child: introScreen()),
                Offstage(offstage: selected != 1, child: commentScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
