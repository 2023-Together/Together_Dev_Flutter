// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class NoticeCard extends StatefulWidget {
  const NoticeCard({
    Key? key,
    required this.noticeData,
    this.isFAQ = false,
  }) : super(key: key);

  final PostCardModel noticeData;
  final bool isFAQ;

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  final bool _isExpanded = false;

  void _onDeleteNotice() async {
    final userData = context.read<UserProvider>().userData;
    final url = Uri.parse("${HttpIp.communityUrl}/together/post/deletePost");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "postId": widget.noticeData.postId,
      "postUserId": userData!.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("게시물 삭제 : 성공");
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  void _onUpdateNotice() {
    context.pushNamed(
      NoticeEditScreen.routeName,
      extra: NoticeEditScreenArgs(
        noticeData: widget.noticeData,
        editType: NoticeEditType.noticeUpdate,
        pageName: "공지사항 수정",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    final userData = context.watch<UserProvider>().userData;
    return ExpansionTile(
      // onExpansionChanged: (value) {
      //   setState(() {
      //     _isExpanded = value;
      //   });
      // },
      title: Text(
        widget.noticeData.postTitle,
      ),
      subtitle: widget.isFAQ
          ? null
          : Text(
              TimeParse.getTimeAgo(widget.noticeData.postCreationDate),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
      // trailing: Icon(
      //   _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
      //   size: 30,
      // ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.noticeData.postContent,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        // Gaps.v20,
        // if (widget.images != null)
        //   GridView(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 4,
        //       mainAxisSpacing: 4,
        //     ),
        //     children: [
        //       for (var img in widget.images!)
        //         Image.asset(
        //           img,
        //           fit: BoxFit.cover,
        //         ),
        //     ],
        //   ),
        Gaps.v10,
        if (isLogined && userData != null)
          if (!widget.isFAQ && userData.userId == 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _onUpdateNotice,
                    child: const Text("수정"),
                  ),
                  Gaps.h10,
                  ElevatedButton(
                    onPressed: _onDeleteNotice,
                    child: const Text("삭제"),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}