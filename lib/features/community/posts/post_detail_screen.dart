import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_comment_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_intro_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_persistent_tab_bar.dart';

// postId 전송

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

class PostDetailScreen extends StatelessWidget {
  static const routeName = "post_detail";
  static const routeURL = "/post_detail";
  PostDetailScreen({
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

  List<String> imgs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: tabBarSelected,
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
                                editType: PostEditType.postUpdate,
                                id: postId,
                                category: category,
                                title: title,
                                content: content,
                                images: images,
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
                        // leading: const CircleAvatar(
                        //   radius: 24,
                        //   backgroundImage: NetworkImage(
                        //     "https://avatars.githubusercontent.com/u/77985708?v=4",
                        //   ),
                        //   backgroundColor: Colors.transparent,
                        // ),
                        title: Text(
                          user,
                        ),
                        subtitle: Text(
                          date,
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
                delegate: ClubPersistentTabBar(commentLength: comments.length),
                pinned: true,
              ),
            ],
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                PostDetailIntroScreen(
                  title: title,
                  content: content,
                  images: images,
                ),
                const PostDetailCommentscreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
