import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';

final List<String> volCategories = [
  "카테고리1",
  "카테고리2",
  "카테고리3",
  "카테고리4",
  "카테고리5",
  "카테고리6",
  "카테고리7",
];

final List<Map<String, dynamic>> volDatas = [
  {
    "title": "봉사1",
    "contnet": "내용1",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사2",
    "contnet": "내용2",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사3",
    "contnet": "내용3",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사4",
    "contnet": "내용4",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사5",
    "contnet": "내용5",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사6",
    "contnet": "내용6",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사7",
    "contnet": "내용7",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사8",
    "contnet": "내용8",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사9",
    "contnet": "내용9",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
  {
    "title": "봉사10",
    "contnet": "내용10",
    "startTime": "2023.05.31 09:00",
    "address": "진주시 가좌동",
    "orgName": "연암공과대학교",
  },
];

class VolSearchTestScreen extends StatelessWidget {
  const VolSearchTestScreen({super.key});

  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    size: 38,
                    color: Colors.black54,
                  ),
                ),
                Gaps.h6,
                GestureDetector(
                  onTap: () => _alertIconTap(context),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 38,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size10,
        ),
        child: Column(
          children: [
            Gaps.v6,
            SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: volCategories.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size8,
                    horizontal: Sizes.size6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        Sizes.size20,
                      ),
                    ),
                  ),
                  child: Text(volCategories[index]),
                ),
                separatorBuilder: (context, index) => Gaps.h8,
              ),
            ),
            Gaps.v6,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: volDatas.length,
                itemBuilder: (context, index) {
                  final item = volDatas[index];
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      leading: Image.asset(
                        "assets/images/70836_50981_2758.jpg",
                        width: 80,
                      ),
                      title: Text(
                        item["title"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item["contnet"],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item["address"]),
                          Gaps.v4,
                          Text(item["orgName"]),
                          Gaps.v4,
                          Text(item["startTime"]),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gaps.v10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
