import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_community_images.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.postId,
    required this.category,
    this.title,
    this.images,
    required this.initCheckGood,
    this.content,
    required this.date,
    required this.user,
  });

  final int postId;
  final String category;
  final String? title;
  final String? content;
  final List<String>? images;
  final bool initCheckGood;
  final String date;
  final String user;

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
    final isLogined = context.watch<UserProvider>().isLogined;
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
                  maxLines: 1,
                ),
                subtitle: const Text(
                  "2개월전",
                  maxLines: 1,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        Gaps.v4,
                        if (widget.content != null)
                          Text(
                            widget.content!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  if (widget.images != null)
                    if (widget.images!.isNotEmpty)
                      SWAGCommunityImages(images: widget.images!),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.size20,
                  right: Sizes.size20,
                  bottom: Sizes.size10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _onGoodTap,
                      icon: FaIcon(
                        isLogined
                            ? _checkGood
                                ? FontAwesomeIcons.solidThumbsUp
                                : FontAwesomeIcons.thumbsUp
                            : FontAwesomeIcons.thumbsUp,
                        color: isLogined
                            ? _checkGood
                                ? Colors.blue.shade600
                                : Colors.black
                            : Colors.black,
                      ),
                    ),
                    Gaps.h6,
                    IconButton(
                      onPressed: () => _goDetailScreen(1),
                      icon: const FaIcon(
                        FontAwesomeIcons.comment,
                        color: Colors.black,
                        size: 30,
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
