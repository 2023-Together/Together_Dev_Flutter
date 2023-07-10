import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class NoticeItem extends StatelessWidget {
  const NoticeItem({
    super.key,
    required this.noticeId,
    required this.noticeTitle,
    required this.noticeContent,
    required this.noticeDate,
    required this.noticeImage,
    required this.isLogined,
  });

  final int noticeId;
  final String noticeTitle;
  final String noticeContent;
  final String noticeDate;
  final List<String> noticeImage;
  final bool isLogined;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
        horizontal: Sizes.size20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size16,
        horizontal: Sizes.size16,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.size10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  noticeTitle,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "3일전",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              noticeContent,
            ),
          ),
        ],
      ),
    );
  }
}
