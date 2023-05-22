import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';

class MainNoticeBox extends StatelessWidget {
  const MainNoticeBox({
    super.key,
    required this.title,
  });

  final String title;

  void onNoticeBoxTap(BuildContext context) {
    context.pushNamed(NoticeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNoticeBoxTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size6,
          vertical: Sizes.size2,
        ),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(Sizes.size20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
