import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
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
                itemCount: 18,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 10 / 12,
                ),
                itemBuilder: (context, index) {
                  // final item = orgDatas[index];
                  return LayoutBuilder(
                    builder: (context, constraints) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: Sizes.size5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            Sizes.size6,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(3, 3), // 그림자의 위치 조정
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/yonam.jpg",
                            width: constraints.maxWidth,
                            fit: BoxFit.fill,
                          ),
                          Gaps.v4,
                          Row(
                            children: [
                              Gaps.h8,
                              Text(
                                "연암공과대학교${index + 1}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v3,
                          const Row(
                            children: [
                              Gaps.h8,
                              Text("주소 : "),
                              Text(
                                "진주시 가좌동",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Gaps.h8,
                              const Text("모집중인 봉사 : "),
                              Text(
                                "${index + 1}개",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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
