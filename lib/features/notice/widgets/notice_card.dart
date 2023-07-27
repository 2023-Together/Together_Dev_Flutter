import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';

class NoticeCard extends StatefulWidget {
  const NoticeCard({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.images,
    required this.isLogined,
    this.isFAQ = false,
  });

  final int id;
  final String title;
  final String content;
  final String date;
  final List<String>? images;
  final bool isLogined;
  final bool isFAQ;

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // onExpansionChanged: (value) {
      //   setState(() {
      //     _isExpanded = value;
      //   });
      // },
      title: Text(
        widget.title,
      ),
      subtitle: widget.isFAQ
          ? null
          : Text(
              widget.date,
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
            widget.content,
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
        if (widget.isLogined && !widget.isFAQ)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => context.pushNamed(
                    NoticeEditScreen.routeName,
                    extra: NoticeEditScreenArgs(
                      id: widget.id,
                      pageName: "공지사항 수정",
                      title: widget.title,
                      content: widget.content,
                      images: widget.images,
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
