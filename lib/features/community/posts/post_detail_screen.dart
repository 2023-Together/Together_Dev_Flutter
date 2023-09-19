// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/http_ip.dart';

import 'package:swag_cross_app/features/community/posts/post_detail_comment_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_detail_intro_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_persistent_tab_bar.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/club_post_provider.dart';
import 'package:swag_cross_app/providers/main_post_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

// postId 전송

class PostDetailScreenArgs {
  final PostCardModel postData;
  final int tabBarSelected;
  final int index;
  final bool isClub;
  final int? clubId;

  PostDetailScreenArgs({
    required this.postData,
    required this.tabBarSelected,
    required this.index,
    required this.isClub,
    this.clubId,
  });
}

class PostDetailScreen extends StatefulWidget {
  static const routeName = "post_detail";
  static const routeURL = "/post_detail";
  const PostDetailScreen({
    super.key,
    required this.postData,
    required this.tabBarSelected,
    required this.index,
    required this.isClub,
    this.clubId,
  });

  final PostCardModel postData;
  final int tabBarSelected;
  final int index;
  final bool isClub;
  final int? clubId;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<String> imgs = [];
  late int likeCount;
  late bool isLiked;

  @override
  void initState() {
    super.initState();

    likeCount = widget.postData.postLikeCount;
    isLiked = widget.postData.postLikeId;
  }

  void _deletePostTap() async {
    final userData = context.read<UserProvider>().userData;
    final url = Uri.parse("${HttpIp.communityUrl}/together/post/deletePost");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "postId": widget.postData.postId,
      "postUserId": userData!.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("게시물 삭제 : 성공");
      if (!mounted) return;
      if (!widget.isClub) {
        await context
            .read<MainPostProvider>()
            .refreshMainPostDispatch(userId: userData.userId);
        context.pop();
        context.pop();
      } else {
        await context.read<ClubPostProvider>().refreshClubPostDispatch(
            clubId: widget.clubId!, userId: userData.userId);
        context.pop();
      }
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "게시물 삭제 실패!",
        message: "${response.statusCode.toString()} : ${response.body}",
      );
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode == 200 ? "좋아요 삭제 : 성공" : "좋아요 추가 : 성공");

      if (!widget.isClub) {
        context.read<MainPostProvider>().onChangePostLike(index: widget.index);
      } else {
        context.read<ClubPostProvider>().onChangePostLike(index: widget.index);
      }

      setState(() {
        isLiked = response.statusCode == 201;
        likeCount += isLiked ? 1 : -1;
      });
    } else {
      if (!mounted) return;
      HttpIp.errorPrint(
        context: context,
        title: "좋아요 변경 실패!",
        message: "${response.statusCode.toString()} : ${response.body}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
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
                actions: isLogined
                    ? widget.postData.postUserId == userData!.userId
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
                                          editType: widget.isClub
                                              ? PostEditType.clubUpdate
                                              : PostEditType.mainUpdate,
                                          postData: widget.postData,
                                          clubId: widget.clubId,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "수정",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: _deletePostTap,
                                    child: Text(
                                      "삭제",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ];
                              },
                              child: const Icon(Icons.more_vert),
                            ),
                          ]
                        : null
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
                            widget.postData.postCreationDate,
                          ),
                        ),
                        trailing: InkWell(
                          onTap: _onTapLikeDispatch,
                          child: Column(
                            children: [
                              FaIcon(
                                isLiked
                                    ? FontAwesomeIcons.solidThumbsUp
                                    : FontAwesomeIcons.thumbsUp,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Text(
                                likeCount.toString(),
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
