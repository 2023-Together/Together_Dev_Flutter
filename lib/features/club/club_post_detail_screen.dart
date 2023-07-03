import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/club/widgets/club_persistent_tab_bar.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class ClubPostDetailScreenArgs {
  final int postId;

  ClubPostDetailScreenArgs({required this.postId});
}

class ClubPostDetailScreen extends StatefulWidget {
  const ClubPostDetailScreen({
    super.key,
  });

  @override
  State<ClubPostDetailScreen> createState() => _ClubPostDetailScreenState();
}

class _ClubPostDetailScreenState extends State<ClubPostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/dog.jpg"),
          Gaps.v10,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: double.infinity,
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "이것은 제목입니다.",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "이것은 내용입니다.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commentWidget({
    required String comment,
    required String date,
  }) {
    return SingleChildScrollView(
      child: Container(
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
      ),
    );
  }

  Widget commentScreen() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  // shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => commentWidget(
                    comment: comments[index]['comment'],
                    date: comments[index]['date'],
                  ),
                  separatorBuilder: (context, index) => Gaps.v6,
                  itemCount: comments.length,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: SWAGTextField(
                hintText: "등록할 댓글을 입력해주세요..",
                maxLine: 1,
                controller: _commentController,
                onChange: () {
                  print(_commentController.text);
                },
                onSubmitted: () {
                  print(_commentController.text);
                },
                buttonText: "등록",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: selected,
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(),
              // SliverToBoxAdapter : sliver에서 일반 flutter 위젯을 사용할때 쓰는 위젯
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: const Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/77985708?v=4",
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                                Gaps.h10,
                                Column(
                                  children: [
                                    Text(
                                      "user",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.thumbsUp,
                                          color: Colors.blue,
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
                      // TabBar(
                      //   tabs: [
                      //     Tab(text: '내용'),
                      //     Tab(text: '댓글 3'),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: ClubPersistentTabBar(),
                pinned: true,
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Offstage(
                  offstage: false,
                  child: introScreen(),
                ),
                Offstage(
                  offstage: false,
                  child: commentScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
