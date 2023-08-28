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

class OrgSearchScreen extends StatefulWidget {
  const OrgSearchScreen({super.key});

  @override
  State<OrgSearchScreen> createState() => _OrgSearchScreenState();
}

class _OrgSearchScreenState extends State<OrgSearchScreen>
    with SingleTickerProviderStateMixin {
  // 검색 애니메이션 컨트롤러 선언
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<Offset> _panelSlideAnimation = Tween(
    begin: const Offset(0, -1),
    end: const Offset(0, 0),
  ).animate(_animationController);

  late final Animation<double> _panelOpacityAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_animationController);

  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

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

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  // 애니메이션 동작
  void _toggleAnimations() {
    // 이미 애니메이션이 실행되었다면
    if (_animationController.isCompleted) {
      // 애니메이션을 원래상태로 되돌림
      // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
      _animationController.reverse();
      _focusNode.unfocus();
    } else {
      // 애니메이션을 실행
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    // 검색 창이 내려와있을 때 스크롤 하면 검색창 다시 사라짐
    if (_animationController.isCompleted) {
      _toggleAnimations();
    }
  }

  // @override
  // void dispose() {
  //    _animationController.dispose();
  //   _searchController.dispose();
  //   _focusNode.dispose();

  //   super.dispose();
  // }

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
                  onTap: _toggleAnimations,
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
            ),
          ],
        ),
      ),
    );
  }
}
