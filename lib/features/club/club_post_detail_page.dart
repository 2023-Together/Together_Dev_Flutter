import 'package:flutter/material.dart';

class ClubPostDetailPage extends StatefulWidget {
  int id;

  ClubPostDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<ClubPostDetailPage> createState() => _ClubPostDetailPageState();
}

class _ClubPostDetailPageState extends State<ClubPostDetailPage> {
  int selected = 0;

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

  AppBar _appBar() {
    return AppBar();
  }

  Widget introScreen() {
    return Column(
      children: [
        Image.asset("assets/images/dog.jpg"),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "소개",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                """xxx동아리입니다!
xxx동아리에서 새로운 부원을 모집합니다!
지원 방법은 밑에 신청 하기 버튼을 누르거나
http://open.kakao.com/o/sdkfj 동아리 단톡방에 들
어오셔서 신청해주세요!

가입조건 : XX세 이상, 고양이를 사랑하는 마음
활동: 주 2회
모집기간: 5/15 ~ 6/15
합격자 발표: 6/15 중
    
저희 동아리는 밝고 활발한 분들이 많습니다!!""",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
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
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xFFf2f2f2),
                              child: Image.asset("assets/images/dog.jpg"),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                const Text(
                                  "고사모",
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
                        ElevatedButton(
                          onPressed: () {},
                          style: const ButtonStyle(),
                          child: const Text("신청하기"),
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
                                "동아리소개",
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
