import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/widgets/org_post_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';

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
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "2",
  },
  {
    "host": "경상대학교 중앙도서관",
    "locationStr": "경상남도 진주시 가좌동 900",
    "location": "진주시 가좌동",
    "pNum": "055-772-0522",
    "bossName": "홍길동",
    "volCount": "2",
  },
  {
    "host": "진주 생활체육관",
    "locationStr": "경상남도 진주시 공단로 59",
    "location": "진주시 상평동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "1",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "2",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
  {
    "host": "연암공과대학교",
    "locationStr": "경상남도 진주시 진주대로629번길 35",
    "location": "진주시 가좌동",
    "pNum": "055-751-2001",
    "bossName": "홍길동",
    "volCount": "6",
  },
];

class OrgSearchTestScreen extends StatefulWidget {
  const OrgSearchTestScreen({super.key});

  @override
  State<OrgSearchTestScreen> createState() => _OrgSearchTestScreenState();
}

class _OrgSearchTestScreenState extends State<OrgSearchTestScreen> {

  
  String option1 = "";
  String option2 = "";
  String option3 = "";

  void onChangeOption1(String? value) {
    if (value == null) {
      return;
    } else {
      option1 = value;
    }
    setState(() {});
  }

  void onChangeOption2(String? value) {
    if (value == null) {
      return;
    } else {
      option2 = value;
    }
    setState(() {});
  }

  void onChangeOption3(String? value) {
    if (value == null) {
      return;
    } else {
      option3 = value;
    }
    setState(() {});
  }

  void onOptionReset() {
    option1 = "";
    option2 = "";
    option3 = "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("$option1, $option2, $option3");
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.2,
        title: const Text("기관 찾기"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size5,
        ),
        child: Column(
          children: [
            Gaps.v6,
            Container(
              height: 45,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SWAGStateDropDownButton(
                    title: "주소",
                    initOption: option1,
                    options: const ["", "경기도", "진주", "서울", "부산"],
                    onChangeOption: onChangeOption1,
                  ),
                  Gaps.h14,
                  SWAGStateDropDownButton(
                    title: "분야",
                    initOption: option2,
                    options: const ["", "의료", "행사", "사회"],
                    onChangeOption: onChangeOption2,
                  ),
                  Gaps.h14,
                  SWAGStateDropDownButton(
                    title: "인증여부",
                    initOption: option3,
                    options: const ["", "O", "X"],
                    onChangeOption: onChangeOption3,
                  ),
                  TextButton(
                    onPressed: onOptionReset,
                    child: const Text("초기화"),
                  ),
                ],
              ),
            ),
            Gaps.v6,
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: orgDatas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 10 / 12,
                ),
                itemBuilder: (context, index) {
                  final item = orgDatas[index];
                  return OrgPostCard(
                    id: item["id"] ?? "",
                    host: item["host"] ?? "",
                    locationStr: item["locationStr"] ?? "",
                    volCount: item["volCount"] ?? "",
                    location: item["location"] ?? "",
                    pNum: item["pNum"] ?? "",
                    bossName: item["bossName"] ?? "",
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
