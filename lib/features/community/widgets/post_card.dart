import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.postData,
  });

  final PostCardModel postData;

  @override
  State<PostCard> createState() => _PostCard();
}

class _PostCard extends State<PostCard> {
  late bool _checkGood;
  final int imgHeight = 100;

  @override
  void initState() {
    super.initState();

    _checkGood = false;
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
        postData: widget.postData,
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
          padding: const EdgeInsets.only(top: 6),
          clipBehavior: Clip.hardEdge,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.black38,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.size12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.postData.postTitle.isNotEmpty)
                          Text(
                            widget.postData.postTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        Gaps.v4,
                        if (widget.postData.postContent.isNotEmpty)
                          Text(
                            widget.postData.postContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                      ],
                    ),
                  ),
                  Gaps.v20,
                  // if (widget.images != null)
                  //   if (widget.images!.isNotEmpty)
                  //     SWAGCommunityImages(images: widget.images!),
                ],
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                ),
                // leading: CircleAvatar(
                //   radius: 20,
                //   backgroundColor: Colors.blue,
                //   child: Text(
                //     widget.user * 3,
                //     style: const TextStyle(color: Colors.white),
                //   ),
                // ),
                title: Text(
                  widget.postData.userNickname,
                  maxLines: 1,
                ),
                titleTextStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                subtitle: Text(
                  TimeParse.getTimeAgo(widget.postData.postCreationDate),
                  maxLines: 1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: isLogined ? _onGoodTap : () {},
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
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: Sizes.size20,
              //     right: Sizes.size20,
              //     bottom: Sizes.size10,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       IconButton(
              //         onPressed: _onGoodTap,
              //         icon: FaIcon(
              //           isLogined
              //               ? _checkGood
              //                   ? FontAwesomeIcons.solidThumbsUp
              //                   : FontAwesomeIcons.thumbsUp
              //               : FontAwesomeIcons.thumbsUp,
              //           color: isLogined
              //               ? _checkGood
              //                   ? Colors.blue.shade600
              //                   : Colors.black
              //               : Colors.black,
              //         ),
              //       ),
              //       Gaps.h6,
              //       IconButton(
              //         onPressed: () => _goDetailScreen(1),
              //         icon: const FaIcon(
              //           FontAwesomeIcons.comment,
              //           color: Colors.black,
              //           size: 30,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}