import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_community_images.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.postId,
    required this.category,
    required this.title,
    required this.images,
    required this.initCheckGood,
    required this.content,
    required this.date,
    required this.user,
    required this.isLogined,
  });

  final int postId;
  final String category;
  final String title;
  final String content;
  final List<String> images;
  final bool initCheckGood;
  final String date;
  final String user;
  final bool isLogined;

  @override
  State<PostCard> createState() => _PostCard();
}

class _PostCard extends State<PostCard> {
  late bool _checkGood;
  final int imgHeight = 100;

  @override
  void initState() {
    super.initState();

    _checkGood = widget.initCheckGood;
  }

  void _onGoodTap() {
    if (_checkGood) {
      _checkGood = !_checkGood;
    } else {
      _checkGood = !_checkGood;
    }
    setState(() {});
  }

  // 댓글로 이동
  void _goDetailScreen(int page) {
    context.pushNamed(
      PostDetailScreen.routeName,
      extra: PostDetailScreenArgs(
        postId: widget.postId,
        category: widget.category,
        title: widget.title,
        content: widget.content,
        images: widget.images,
        date: widget.date,
        user: widget.user,
        tabBarSelected: page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: () => _goDetailScreen(0),
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.black12,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                ),
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/77985708?v=4",
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  widget.user,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: const Text(
                  "2개월전",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // trailing: PopupMenuButton<String>(
                //   offset: const Offset(0, 25),
                //   itemBuilder: (context) {
                //     return [
                //       PopupMenuItem(
                //         onTap: () {
                //           print("게시글 수정");
                //           context.pushNamed(
                //             PostUpdateScreen.routeName,
                //             extra: PostUpdateScreenArgs(
                //               title: widget.title,
                //               content: widget.content,
                //               images: widget.images,
                //             ),
                //           );
                //         },
                //         child: const Text("수정"),
                //       ),
                //       PopupMenuItem(
                //         onTap: () {
                //           print("게시글 삭제");
                //         },
                //         child: const Text("삭제"),
                //       ),
                //     ];
                //   },
                //   child: const Icon(Icons.more_vert),
                // ),
              ),
              Column(
                children: [
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.only(
                      left: Sizes.size12,
                      right: Sizes.size12,
                      bottom: Sizes.size20,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  if (widget.images.isNotEmpty)
                    SWAGCommunityImages(images: widget.images),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _onGoodTap,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: FaIcon(
                          widget.isLogined
                              ? _checkGood
                                  ? FontAwesomeIcons.solidThumbsUp
                                  : FontAwesomeIcons.thumbsUp
                              : FontAwesomeIcons.thumbsUp,
                          color: widget.isLogined
                              ? _checkGood
                                  ? Colors.blue.shade600
                                  : Colors.black
                              : Colors.black,
                        ),
                      ),
                    ),
                    Gaps.h6,
                    GestureDetector(
                      onTap: () => _goDetailScreen(1),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const FaIcon(
                          FontAwesomeIcons.comment,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
