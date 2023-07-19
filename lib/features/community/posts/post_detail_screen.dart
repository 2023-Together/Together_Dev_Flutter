import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_persistent_tab_bar.dart';
import 'package:swag_cross_app/features/community/widgets/comment_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_custom_indicator.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

class PostDetailScreenArgs {
  final int postId;
  final String category;
  final String? title;
  final String? content;
  final List<String>? images;
  final String date;
  final String user;
  final int tabBarSelected;

  PostDetailScreenArgs({
    required this.postId,
    required this.category,
    this.title,
    this.content,
    this.images,
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
    this.images,
    this.title,
    this.content,
    required this.date,
    required this.user,
    required this.tabBarSelected,
  });

  final int postId;
  final String category;
  final String? title;
  final String? content;
  final List<String>? images;
  final String date;
  final String user;
  final int tabBarSelected;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final PageController _imagesPageController = PageController();

  int _currentIndicatorPage = 0;
  bool _showRightArrow = true;
  bool _showLeftArrow = false;

  List<String> imgs = [];

  @override
  void initState() {
    super.initState();

    if (widget.images != null) {
      if (widget.images!.length == 1) {
        _showRightArrow = false;
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    _imagesPageController.dispose();
    super.dispose();
  }

  Widget introScreen() {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          if (widget.images != null)
            if (widget.images!.isNotEmpty)
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: 350,
                        child: PageView.builder(
                          onPageChanged: (value) => setState(() {
                            _currentIndicatorPage = value;
                            if (widget.images!.length > 1) {
                              if (value == 0) {
                                _showRightArrow = true;
                                _showLeftArrow = false;
                              } else if (value == widget.images!.length - 1) {
                                _showRightArrow = false;
                                _showLeftArrow = true;
                              } else {
                                _showRightArrow = true;
                                _showLeftArrow = true;
                              }
                            }
                          }),
                          controller: _imagesPageController,
                          itemCount: widget.images!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => context.push,
                              child: Image.asset(
                                widget.images![index],
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        left: 10,
                        height: 350,
                        child: AnimatedOpacity(
                          opacity: _showLeftArrow ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imagesPageController.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease);
                                _currentIndicatorPage =
                                    _currentIndicatorPage - 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.9),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_left_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        height: 350,
                        child: AnimatedOpacity(
                          opacity: _showRightArrow ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imagesPageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease);
                                _currentIndicatorPage =
                                    _currentIndicatorPage + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.9),
                              ),
                              child: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v10,
                  SWAGCustomIndicator(
                    currentIndex: _currentIndicatorPage,
                    itemLength: widget.images!.length,
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
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                Gaps.v10,
                if (widget.content != null)
                  Text(
                    widget.content!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              ],
            ),
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
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = comments[index];
                  return CommentCard(
                    username: item['username'],
                    date: item['date'],
                    comment: item['comment'],
                    id: item['id'],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v6,
                itemCount: comments.length,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(10),
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
                                pageTitle: "게시글 수정",
                                editType: "post_update",
                                id: widget.postId,
                                category: widget.category,
                                title: widget.title,
                                content: widget.content,
                                images: widget.images,
                                isCategory: true,
                              ),
                            );
                          },
                          child: Text(
                            "수정",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            print("게시글 삭제");
                          },
                          child: Text(
                            "삭제",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
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
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        leading: const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/77985708?v=4",
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          widget.user,
                        ),
                        subtitle: Text(
                          widget.date,
                        ),
                        trailing: Column(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.thumbsUp,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 1),
                            Text(
                              "120",
                              style: Theme.of(context).textTheme.bodyLarge,
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
