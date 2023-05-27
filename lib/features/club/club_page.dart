import 'package:flutter/material.dart';
import 'package:swag_cross_app/features/club/widgets/post_card_widget.dart';

class ClubPage extends StatefulWidget {
  static const routeName = "club";
  static const routeURL = "/club";

  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  List<Map<String, dynamic>> clubPosts = [
    {
      "id": 1,
      "clubName": "고사모",
      "title": "고양이를 사랑하는 모임",
      "clubBanner": null,
      "viewCount": 543,
      "commentCount": 40,
    },
    {
      "id": 2,
      "clubName": "강사모",
      "title": "강아지를 사랑하는 모임",
      "clubBanner": null,
      "viewCount": 243,
      "commentCount": 20,
    },
    {
      "id": 3,
      "clubName": "고사모",
      "title": "고양이를 사랑하는 모임",
      "clubBanner": null,
      "viewCount": 313,
      "commentCount": 32,
    },
  ];

  AppBar _appBar() {
    return AppBar(
      centerTitle: false,
      title: const Text(
        "동아리",
        style: TextStyle(
          fontSize: 32,
        ),
      ),
      actions: [
        const Icon(
          Icons.search,
          size: 36,
        ),
        const SizedBox(width: 10),
        GestureDetector(
          child: Row(
            children: const [
              Text(
                "전국",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 36,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: _appBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var post = clubPosts[index];
            return PostCard(
              id: post['id'],
              clubName: post['clubName'],
              clubBanner: post['clubBanner'],
              title: post['title'],
              viewCount: post['viewCount'],
              commentCount: post['commentCount'],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: clubPosts.length),
    );
  }
}
