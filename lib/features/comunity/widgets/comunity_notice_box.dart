import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  void onNoticeBoxTap(BuildContext context) {
    context.pushNamed(
      CustomerServiceScreen.routeName,
      queryParams: {"index": "1"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onNoticeBoxTap(context),
      child: Container(
        width: 105,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size6,
        ),
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(Sizes.size16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v8,
              Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
