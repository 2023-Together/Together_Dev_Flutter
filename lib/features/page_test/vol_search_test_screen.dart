import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
//import 'package:swag_cross_app/features/page_test/widgets/categori_buttons.dart';
//import 'package:swag_cross_app/features/page_test/widgets/state_dropDown_button.dart';

final List<String> volCategories = [
  "카테고리1",
  "카테고리2",
  "카테고리3",
  // "카테고리4",
  // "카테고리5",
  // "카테고리6",
  // "카테고리7",
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

class VolSearchTestScreen extends StatefulWidget {
  const VolSearchTestScreen({super.key});

  @override
  State<VolSearchTestScreen> createState() => _VolSearchTestScreenState();
}

class _VolSearchTestScreenState extends State<VolSearchTestScreen> {
  void _alertIconTap(BuildContext context) {
    context.pushNamed(AlertScreen.routeName);
  }

  String selectedDropdown1 = '지역별';
  String selectedDropdown2 = '분야별';
  String selectedDropdown3 = '기간별';

  List<String> dropdownList1 = ['지역별', '가좌동', '평거동', '충무공동'];
  List<String> dropdownList2 = ['분야별','의료봉사', '문화체험', '행사보조'];
  List<String> dropdownList3 = ['기간별','1', '2', '3'];
  

  // String option1 = "지역별";
  // String option2 = "분야별";
  // String option3 = "기간별";

  // void onChangeOption1(String? value) {
  //   if (value == null) {
  //     option1 = "지역별";
  //   } else {
  //     option1 = value;
  //   }
  //   setState(() {});
  // }

  // void onChangeOption2(String? value) {
  //   if (value == null) {
  //     option1 = "지역별";
  //   } else {
  //     option1 = value;
  //   }
  //   setState(() {});
  // }

  // void onChangeOption3(String? value) {
  //   if (value == null) {
  //     option1 = "지역별";
  //   } else {
  //     option1 = value;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("봉사 검색"),
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
            // SizedBox(
            //   height: 35,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: volCategories.length,
            //     itemBuilder: (context, index) => CategoriButtons(
            //       title: volCategories[index],
            //     ),
            //     separatorBuilder: (context, index) => Gaps.h8,
            //   ),
            // ),
            Container(
              height: 50,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size11,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // 지역, 분야, 기간별 카테고리 선택 버튼
                    // StateDropDownButton(
                    //     initOption: option1,
                    //     onChangeOption: onChangeOption1,
                    // ),
                    // StateDropDownButton(
                    //     initOption: option2,
                    //     onChangeOption: onChangeOption2,
                    // ),
                    // StateDropDownButton(
                    //     initOption: option3,
                    //     onChangeOption: onChangeOption3,
                    // ),
                    DropdownButton(
                      value: selectedDropdown1,
                      items: dropdownList1.map((String item) {
                        return DropdownMenuItem<String> (
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedDropdown1 = value;
                        });
                      },
                    ),
                     DropdownButton(
                      value: selectedDropdown2,
                      items: dropdownList2.map((String item) {
                        return DropdownMenuItem<String> (
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedDropdown2 = value;
                        });
                      },
                    ),
                     DropdownButton(
                      value: selectedDropdown3,
                      items: dropdownList3.map((String item) {
                        return DropdownMenuItem<String> (
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedDropdown3 = value;
                        });
                      },
                    ),
                  ],
                ),
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
                    height: 80,
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
