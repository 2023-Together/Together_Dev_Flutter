import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class NoticeCard extends StatefulWidget {
  const NoticeCard({
    super.key,
    required this.noticeData,
    this.isFAQ = false,
  });

  final PostCardModel noticeData;
  final bool isFAQ;

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
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
        if (isLogined && !widget.isFAQ)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => context.pushNamed(
                    NoticeEditScreen.routeName,
                    extra: NoticeEditScreenArgs(
                      noticeData: widget.noticeData,
                      pageName: "공지사항 수정",
                    ),
                  ),
                  child: const Text("수정"),
                ),
                Gaps.h10,
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("삭제"),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
