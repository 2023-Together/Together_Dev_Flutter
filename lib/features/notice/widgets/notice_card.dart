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
    required this.images,
    required this.isLogined,
  });

  final int id;
  final String title;
  final String content;
  final String date;
  final List<String> images;
  final bool isLogined;

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      collapsedShape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        widget.date,
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Icon(
        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        size: 30,
        color: Colors.black54,
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.content,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Gaps.v20,
        // const Divider(thickness: 2),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          children: [
            for (var img in widget.images)
              Image.asset(
                img,
                fit: BoxFit.cover,
              ),
          ],
        ),
        Gaps.v10,
        if (widget.isLogined)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade300,
                  ),
                  onPressed: () => context.pushNamed(
                    NoticeEditScreen.routeName,
                    extra: NoticeEditScreenArgs(
                      id: widget.id,
                      title: widget.title,
                      content: widget.content,
                      images: widget.images,
                    ),
                  ),
                  child: const Text("수정"),
                ),
                Gaps.h10,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade300,
                  ),
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
