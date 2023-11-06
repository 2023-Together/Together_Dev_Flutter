// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_community_images.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/club_post_provider.dart';
import 'package:swag_cross_app/providers/main_post_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
    required this.postData,
    required this.index,
    this.isClub = false,
    this.clubId,
  }) : super(key: key);

  final PostCardModel postData;
  final int index;
  final bool isClub;
  final int? clubId;

  @override
  State<PostCard> createState() => _PostCard();
}

class _PostCard extends State<PostCard> {
  final int imgHeight = 100;
  late final List<String> imageAssets;

  @override
  void initState() {
    super.initState();

    if (widget.index % 5 == 0) {
      imageAssets = [
        "assets/images/봉사1",
        "assets/images/봉사3",
        "assets/images/봉사5"
      ];
    } else if (widget.index % 4 == 0) {
      imageAssets = [
        "assets/images/봉사2",
        "assets/images/봉사4",
      ];
    } else if (widget.index % 3 == 0) {
      imageAssets = [
        "assets/images/봉사3",
      ];
    } else if (widget.index % 2 == 0) {
      imageAssets = [
        "assets/images/봉사4",
        "assets/images/봉사3",
      ];
    } else if (widget.index % 2 == 1) {
      imageAssets = [
        "assets/images/봉사5",
        "assets/images/봉사1",
        "assets/images/봉사3"
      ];
    }
  }

  Future<void> _onTapLikeDispatch() async {
    final userData = context.read<UserProvider>().userData;
    final url = Uri.parse("${HttpIp.communityUrl}/together/post/postLike");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "likeUserId": userData!.userId,
      "likePostId": widget.postData.postId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (!mounted) return;
    if (!widget.isClub) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("좋아요 변경 : 성공");
        context.read<MainPostProvider>().onChangePostLike(index: widget.index);
      } else {
        print("${response.statusCode} : ${response.body}");
        throw Exception("통신 실패!");
      }
    } else {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("좋아요 변경 : 성공");
        context.read<ClubPostProvider>().onChangePostLike(index: widget.index);
      } else {
        print("${response.statusCode} : ${response.body}");
        throw Exception("통신 실패!");
      }
    }
  }

  // 댓글로 이동
  void _goDetailScreen(int page) {
    context.pushNamed(
      PostDetailScreen.routeName,
      extra: PostDetailScreenArgs(
        postData: widget.postData,
        tabBarSelected: page,
        index: widget.index,
        isClub: widget.isClub,
        clubId: widget.clubId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      onPressed: isLogined ? _onTapLikeDispatch : () {},
                      icon: FaIcon(
                        isLogined
                            ? widget.postData.postLikeId
                                ? FontAwesomeIcons.solidThumbsUp
                                : FontAwesomeIcons.thumbsUp
                            : FontAwesomeIcons.thumbsUp,
                        color: isLogined
                            ? widget.postData.postLikeId
                                ? Colors.blue.shade600
                                : null
                            : null,
                      ),
                    ),
                    Gaps.h6,
                    IconButton(
                      onPressed: () => _goDetailScreen(1),
                      icon: const FaIcon(
                        FontAwesomeIcons.comment,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SWAGCommunityImages(images: imageAssets),
            ],
          ),
        ),
      ),
    );
  }
}
