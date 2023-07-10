import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/customer_service/customer_service_screen.dart';

class NoticeDetailScreenArgs {
  final int noticeId;
  final String noticeTitle;
  final String noticeContent;
  final String noticeDate;
  final List<String> noticeImage;
  final bool isLogined;
  final bool isPageWhere;

  const NoticeDetailScreenArgs({
    required this.noticeId,
    required this.noticeTitle,
    required this.noticeContent,
    required this.noticeDate,
    required this.noticeImage,
    required this.isLogined,
    this.isPageWhere = false,
  });
}

class NoticeDetailScreen extends StatelessWidget {
  static const routeName = "notice_detail";
  static const routeURL = "notice_detail";

  const NoticeDetailScreen({
    super.key,
    required this.noticeId,
    required this.noticeTitle,
    required this.noticeContent,
    required this.noticeDate,
    required this.noticeImage,
    required this.isLogined,
    this.isPageWhere = false,
  });
  final int noticeId;
  final String noticeTitle;
  final String noticeContent;
  final String noticeDate;
  final List<String> noticeImage;
  final bool isLogined;
  final bool isPageWhere;

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 53, 50, 50),
        fontSize: 16,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.25,
        actions: [
          if (isPageWhere)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.purple.shade300,
                  ),
                ),
                onPressed: () => context.replaceNamed(
                    CustomerServiceScreen.routeName,
                    extra: CustomerServiceScreenArgs(
                        initSelectedIndex: 0, isLogined: isLogined)),
                child: const Text("목록"),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v10,
              Text(
                noticeTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              Gaps.v10,
              Text(
                noticeDate,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
              ),
              Gaps.v10,
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Gaps.v10,
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 100, // 최소 높이
                ),
                child: Text(
                  noticeContent,
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
                  for (var img in noticeImage)
                    Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
