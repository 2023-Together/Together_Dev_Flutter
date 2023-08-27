import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/models/comment_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

import 'package:http/http.dart' as http;

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.commentData,
    required this.refreshCommentList,
  });

  final CommentModel commentData;
  final Function refreshCommentList;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isExpanded = false;
  bool _isTextOverflowed = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTextOverflow();
    });
  }

  void _checkTextOverflow() {
    TextSpan text = TextSpan(
      text: widget.commentData.commentContent,
      style: Theme.of(context).textTheme.bodyMedium,
    );
    TextPainter textPainter = TextPainter(
      text: text,
      maxLines: 4,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);

    setState(() {
      _isTextOverflowed = textPainter.didExceedMaxLines;
    });
  }

  Future<void> _onDeleteComment() async {
    final userData = context.read<UserProvider>().userData;
    final url = Uri.parse(
        "${HttpIp.communityUrl}/together/post/deleteCommentByCommentId");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "commentId": widget.commentData.commentId,
      "commentUserId": userData!.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("댓글 삭제 : 성공");
      widget.refreshCommentList();
    } else {
      print("${response.statusCode} : ${response.body}");
      print("댓글 삭제 : 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    final userData = context.watch<UserProvider>().userData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Sizes.size16,
            right: Sizes.size16,
            bottom: Sizes.size6,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: widget.commentData.userNickname,
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text:
                                    ' ㆍ ${TimeParse.getTimeAgo(widget.commentData.commentCreationDate)}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        if (isLogined &&
                            widget.commentData.commentUserId ==
                                userData!.userId)
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: _onDeleteComment,
                                child: Text(
                                  "삭제",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Text(
                      widget.commentData.commentContent,
                      maxLines: _isExpanded ? null : 4,
                      overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (_isTextOverflowed)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? "간략히 보기" : "더 보기",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}