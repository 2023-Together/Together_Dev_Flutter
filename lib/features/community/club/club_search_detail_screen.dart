import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';

class ClubSearchDetailScreenArgs {
  final int postId;
  final String postTitle;
  final String postContent;
  final String clubName;
  final String postDate;
  final String clubMaster;

  ClubSearchDetailScreenArgs({
    required this.postId,
    required this.postTitle,
    required this.postContent,
    required this.clubName,
    required this.postDate,
    required this.clubMaster,
  });
}

class ClubSearchDetailScreen extends StatelessWidget {
  static const routeName = "detail";
  static const routeURL = "detail";

  const ClubSearchDetailScreen({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.postContent,
    required this.clubName,
    required this.postDate,
    required this.clubMaster,
  });

  final int postId;
  final String postTitle;
  final String postContent;
  final String clubName;
  final String postDate;
  final String clubMaster;

  void _onSubmit(BuildContext context) {
    swagPlatformDialog(
      context: context,
      title: "신청 알림",
      message: "정말로 $clubName에 신청하실건가요?",
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("아니오"),
        ),
        TextButton(
          onPressed: () => context.goNamed(
            MainNavigation.routeName,
            queryParams: {"initIndex": "3"},
          ),
          child: const Text("예"),
        ),
      ],
    );
  }

  Widget _title({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        color: Color.fromARGB(255, 53, 50, 50),
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("동아리 신청"),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ElevatedButton(
          onPressed: () => _onSubmit(context),
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: const Text("신청"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/club1.jpg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v10,
                  _title(title: postTitle),
                  Gaps.v10,
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(
                          postContent,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v16,
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        const TextSpan(text: "동아리 이름 : "),
                        TextSpan(
                          text: clubName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            const TextSpan(text: "동아리장 : "),
                            TextSpan(
                              text: clubMaster,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        postDate,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Gaps.v10,
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: const [
                        TextSpan(text: "동아리 인원(명) : "),
                        TextSpan(
                          text: "53",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
