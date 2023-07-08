import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/sizes.dart';

class SWAGCustomIndicator extends StatelessWidget {
  const SWAGCustomIndicator({
    super.key,
    required this.currentNoticeIndex,
    required this.noticeItemLength,
  });

  final int currentNoticeIndex;
  final int noticeItemLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < noticeItemLength; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
              child: CircleAvatar(
                backgroundColor: currentNoticeIndex == i
                    ? Colors.blue.shade400
                    : Colors.grey.shade300,
                radius: Sizes.size7,
              ),
            ),
        ],
      ),
    );
  }
}
