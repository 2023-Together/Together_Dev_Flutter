import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_persistent_tab_bar.dart';
import 'package:swag_cross_app/features/widget_tools/swag_custom_indicator.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostDetailScreenArgs {
  final int postId;
  final String category;
  final String title;
  final String content;
  final List<String> images;
  final String date;
  final String user;
  final int tabBarSelected;

  PostDetailScreenArgs({
    required this.postId,
    required this.category,
    required this.title,
    required this.content,
    required this.images,
    required this.date,
    required this.user,
    required this.tabBarSelected,
  });
}

class PostDetailScreen extends StatefulWidget {
  static const routeName = "post_detail";
  static const routeURL = "/post_detail";
  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.category,
    required this.images,
    required this.title,
    required this.content,
    required this.date,
    required this.user,
    required this.tabBarSelected,
  });

  final int postId;
  final String category;
  final String title;
  final String content;
  final List<String> images;
  final String date;
  final String user;
  final int tabBarSelected;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();

  int currentIntroPage = 0;

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

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget introScreen() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        if (widget.images.isNotEmpty)
          Column(
            children: [
              SizedBox(
                width: size.width,
                height: 350,
                child: PageView.builder(
                  onPageChanged: (value) => setState(() {
                    currentIntroPage = value;
                  }),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => context.push,
                      child: Image.asset(
                        widget.images[index],
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              Gaps.v10,
              SWAGCustomIndicator(
                currentNoticeIndex: currentIntroPage,
                noticeItemLength: widget.images.length,
              ),
            ],
          ),
        Gaps.v10,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          width: size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v20,
              Text(
                widget.content,
                style: const TextStyle(
                  fontSize: 18,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                onSubmitted: () {
                  print(_commentController.text);
                  _commentController.text = "";
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
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: widget.tabBarSelected,
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                actions: [
                  PopupMenuButton<String>(
                    offset: const Offset(0, 25),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            print("게시글 수정");
                            context.pushNamed(
                              PostEditScreen.routeName,
                              extra: PostEditScreenArgs(
                                id: widget.postId,
                                category: widget.category,
                                title: widget.title,
                                content: widget.content,
                                images: widget.images,
                                isCategory: true,
                              ),
                            );
                          },
                          child: const Text("수정"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            print("게시글 삭제");
                          },
                          child: const Text("삭제"),
                        ),
                      ];
                    },
                    child: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              // SliverToBoxAdapter : sliver에서 일반 flutter 위젯을 사용할때 쓰는 위젯
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
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
                                    Text(
                                      widget.user,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Row(
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
                            Text(
                              widget.date,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
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
