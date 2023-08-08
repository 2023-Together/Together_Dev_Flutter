import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_comment_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_intro_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_persistent_tab_bar.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

// postId 전송

class PostDetailScreenArgs {
  final PostCardModel postData;
  final int tabBarSelected;

  PostDetailScreenArgs({
    required this.postData,
    required this.tabBarSelected,
  });
}

class PostDetailScreen extends StatefulWidget {
  static const routeName = "post_detail";
  static const routeURL = "/post_detail";
  const PostDetailScreen({
    super.key,
    required this.postData,
    required this.tabBarSelected,
  });

  final PostCardModel postData;
  final int tabBarSelected;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<String> imgs = [];

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>().userData;

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
                actions: widget.postData.postUserId == userData!.userId
                    ? [
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
                                      editType: PostEditType.postUpdate,
                                      postData: widget.postData,
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
                      ]
                    : null,
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
                        // leading: const CircleAvatar(
                        //   radius: 24,
                        //   backgroundImage: NetworkImage(
                        //     "https://avatars.githubusercontent.com/u/77985708?v=4",
                        //   ),
                        //   backgroundColor: Colors.transparent,
                        // ),
                        title: Text(
                          widget.postData.userNickname,
                        ),
                        subtitle: Text(
                          TimeParse.getTimeAgo(
                              widget.postData.postCreationDate),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            // 버튼을 눌렀을 때 수행할 작업
                          },
                          child: Column(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.thumbsUp,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text(
                                "120",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: ClubPersistentTabBar(commentLength: comments.length),
                pinned: true,
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                PostDetailIntroScreen(
                  title: widget.postData.postTitle,
                  content: widget.postData.postContent,
                ),
                PostDetailCommentscreen(
                  postData: widget.postData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
