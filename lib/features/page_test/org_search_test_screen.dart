import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';

final List<String> volAddress = [
  "지역1",
  "지역2",
  "지역3",
  "지역4",
  "지역5",
  "지역6",
  "지역7",
  "지역8",
];

final List<Map<String, dynamic>> orgDatas = [
  {
    "name": "기관1",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관2",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관3",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관4",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관5",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관6",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관7",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관8",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관9",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관10",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관11",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관12",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관13",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관14",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관15",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관16",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관17",
    "address": "연암공과대학교",
    "volCount": "6",
  },
  {
    "name": "기관18",
    "address": "연암공과대학교",
    "volCount": "6",
  },
];

class OrgSearchTestScreen extends StatelessWidget {
  const OrgSearchTestScreen({super.key});

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
                itemCount: volAddress.length,
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
                  child: Text(volAddress[index]),
                ),
                separatorBuilder: (context, index) => Gaps.h8,
              ),
            ),
            Gaps.v6,
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 18,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 10 / 11,
                ),
                itemBuilder: (context, index) {
                  final item = orgDatas[index];
                  return LayoutBuilder(
                    builder: (context, constraints) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/yonam.jpg",
                            width: constraints.maxWidth,
                          ),
                          Text('이름 : 연암공과대학교${index + 1}'),
                          // Gaps.v2,
                          const Text("주소 : 진주시 가좌동"),
                          // Gaps.v2,
                          Text("모집중인 봉사 : ${index + 1}개"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
