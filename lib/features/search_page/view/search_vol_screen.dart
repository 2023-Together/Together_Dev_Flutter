import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/widgets/vol_post_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
//import 'package:swag_cross_app/features/page_test/widgets/categori_buttons.dart';
//import 'package:swag_cross_app/features/page_test/widgets/state_dropDown_button.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';

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
    "title": "체육관 보조 자원봉사자 모집",
    "contnet": "주말 체육관 보조 자원봉사자 모집합니다.",
    "startTime": "2023.07.01 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 상평동",
    "host": "진주 생활체육관",
    "actPlace": "진주 생활 체육관1",
    "teenager": "청소년",
    "listApiType": "1365"
  },
  {
    "title": "도서관 자원봉사자 모집",
    "contnet": "도서관 자원봉사자 모집합니다.",
    "startTime": "2023.07.01 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "경상대학교 중앙도서관",
    "actPlace": "진주 생활 체육관1",
    "listApiType": "vms"
  },
  {
    "title": "자원봉사자 모집",
    "contnet": "성실히 일할 자원봉사자 구합니다!",
    "startTime": "2023.07.01 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1",
    "teenager": "청소년",
    "listApiType": "1365"
  },
  {
    "title": "전시회 보조 자원봉사자 모집",
    "contnet": "전시회 보조 자원봉사자 모집합니다!",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1",
    "listApiType": "vms"
  },
  {
    "title": "봉사5",
    "contnet": "내용5",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
  {
    "title": "봉사6",
    "contnet": "내용6",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
  {
    "title": "봉사7",
    "contnet": "내용7",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
  {
    "title": "봉사8",
    "contnet": "내용8",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
  {
    "title": "봉사9",
    "contnet": "내용9",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
  {
    "title": "봉사10",
    "contnet": "내용10",
    "startTime": "2023.05.31 09:00",
    "endTime": "2023.07.30 18:00",
    "locationStr": "진주시 가좌동",
    "host": "연암공과대학교",
    "actPlace": "진주 생활 체육관1"
  },
];

class VolSearchScreen extends StatefulWidget {
  const VolSearchScreen({super.key});

  @override
  State<VolSearchScreen> createState() => _VolSearchScreenState();
}

class _VolSearchScreenState extends State<VolSearchScreen>
    with SingleTickerProviderStateMixin {
  // 검색어
  String searchText = '';

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

  List<VolunteerModel>? _volList;

  String selectedDropdown1 = '';
  String selectedDropdown2 = '';
  String selectedDropdown3 = '';
  String selectedDropdown4 = '';

  List<String> dropdownList1 = [
    '',
    '가좌동',
    '강남동',
    '계동',
    '귀곡동',
    '금곡면',
    '금산면',
    '남성동',
    '내동면',
    '대곡면',
    '대안동',
    '대평면',
    '동성동',
    '망경동',
    '명석면',
    '문산읍',
    '미천면',
    '본성동',
    '봉곡동',
    '봉래동',
    '사봉면',
    '상대동',
    '상봉동',
    '상평동',
    '수곡면',
    '수정동',
    '신안동',
    '옥봉동',
    '유곡동',
    '이반성면',
    '장대동',
    '장재동',
    '정촌면',
    '주약동',
    '중안동',
    '중앙동',
    '지수면',
    '진성면',
    '집현면',
    '초전동',
    '충무공동',
    '칠암동',
    '판문동',
    '평거동',
    '평안동',
    '하대동',
    '하촌동',
    '호탄동',
  ];
  List<String> dropdownList2 = [
    '',
    '의료봉사',
    '문화행사',
    '행사보조',
    '생활편의지원',
    '주거환경',
    '상담',
    '의료',
    '농어촌 봉사',
    '환경보호',
    '안전,예방',
    '행정보조',
    '공익,인권',
    '재해,재난',
    '국제협력, 해외봉사',
    '멘토링',
    '기타',
  ];
  List<String> dropdownList3 = [
    '',
    '모집 중',
    '모집 완료',
  ];
  List<String> dropdownList4 = [
    '',
    '가능',
    '불가능',
  ];

  @override
  void initState() {
    super.initState();
    _postGetApiDispatch();
    // _apiGetDispatch();
    _focusNode.addListener(_handleFocusChange);
    // 검색 창이 내려와있을 때 스크롤 하면 검색창 다시 사라짐
    if (_animationController.isCompleted) {
      _toggleAnimations();
    }
    
  }

  // 애니메이션 동작
  Future<void> _toggleAnimations() async {
    // 이미 애니메이션이 실행되었다면
    if (_animationController.isCompleted) {
      // 애니메이션을 원래상태로 되돌림
      // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
      await _animationController.reverse();
      _focusNode.unfocus();
    } else {
      // 애니메이션을 실행
      await _animationController.forward();
    }

    setState(() {});
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  // // 1365, vms API를 가져오는 통신
  // void _apiGetDispatch() async {
  //   final url = Uri.parse("http://218.157.74.17:80/together/readVMS1365Api");
  //   final response = await http.get(url);

  //   // 응답 처리
  //   if (response.statusCode == 200) {
  //     print("Response body: ${response.body}");
  //   } else {
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }

  // }

  Future<void> _postGetApiDispatch() async {
    final url = Uri.parse("http://59.4.3.198:80/together/readVMS1365Api");
    final response = await http.post(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);
      print("성공");

      _volList = jsonResponse.map((data) => VolunteerModel.fromJson(data)).toList();
      // 응답 데이터를 ClubSearchModel 리스트로 파싱


      print(_volList!.length);
      print(_volList!);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("API를 불러오는데 실패하였습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // backgroundColor: Colors.purple.shade300,
        title: const Text(
          "봉사 검색",
          // style: TextStyle(
          //   color: Colors.white,
          //   fontWeight: FontWeight.normal,
          // ),
        ),
        automaticallyImplyLeading: false,
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
            ),
            child: Column(
              children: [
                Gaps.v6,
                Container(
                  height: 50,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size14,
                    vertical: Sizes.size4,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SWAGStateDropDownButton(
                        initOption: selectedDropdown1,
                        onChangeOption: (dynamic value) {
                          setState(() {
                            selectedDropdown1 = value;
                          });
                        },
                        title: "지역별",
                        options: dropdownList1,
                      ),
                      Gaps.h8,
                      SWAGStateDropDownButton(
                        initOption: selectedDropdown2,
                        onChangeOption: (dynamic value) {
                          setState(() {
                            selectedDropdown2 = value;
                          });
                        },
                        title: "분야별",
                        options: dropdownList2,
                      ),
                      Gaps.h8,
                      SWAGStateDropDownButton(
                        initOption: selectedDropdown3,
                        onChangeOption: (dynamic value) {
                          setState(() {
                            selectedDropdown3 = value;
                          });
                        },
                        title: "모집 여부",
                        options: dropdownList3,
                      ),
                      Gaps.h8,
                      SWAGStateDropDownButton(
                        initOption: selectedDropdown3,
                        onChangeOption: (dynamic value) {
                          setState(() {
                            selectedDropdown3 = value;
                          });
                        },
                        title: "청소년 가능 여부",
                        options: dropdownList4,
                      ),
                    ],
                  ),
                ),
                Gaps.v6,
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: volDatas.length,
                    itemBuilder: (context, index) {
                      final item = volDatas[index];
                      // 검색 기능, 검색어가 있을 경우 (title)
                      // if (searchText.isNotEmpty &&
                      //     !volDatas[index]["title"]
                      //         .toString()
                      //         .toLowerCase()
                      //         .contains(searchText.toLowerCase())) {
                      //   return SizedBox.shrink();
                      // }

                      // 검색 기능 - 검색어가 있을 경우 (title, host, locationStr)
                      if (searchText.isNotEmpty &&
                          !volDatas[index]["title"]
                              .toString()
                              .toLowerCase()
                              .contains(searchText.toLowerCase()) &&
                          !volDatas[index]["host"]
                              .toString()
                              .toLowerCase()
                              .contains(searchText.toLowerCase()) &&
                          !volDatas[index]["locationStr"]
                              .toString()
                              .toLowerCase()
                              .contains(searchText.toLowerCase())) {
                        return const SizedBox.shrink();
                      }

                      // 검색어가 없을 경우, 모든 항목 표시
                      else {
                        return
                            Container(
                              height: 140,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: VolPostCard(
                                id: item["item"] ?? "",
                                title: item["title"] ?? "",
                                contnet: item["contnet"] ?? "",
                                host: item["host"] ?? "",
                                locationStr: item["locationStr"] ?? "",
                                actPlace: item["actPlace"] ?? "",
                                teenager: item["teenager"] ?? "",
                                listApiType: item["listApiType"] ?? "",
                              ),
                            );

                        //     FutureBuilder(
                        //   future: _postGetApiDispatch(),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return const Center(
                        //         child: CircularProgressIndicator(),
                        //       );
                        //     } else if (snapshot.hasError) {
                        //       if (snapshot.error is TimeoutException) {
                        //         return const Center(
                        //           child: Text("통신 연결 실패"),
                        //         );
                        //       } else {
                        //         return const Center(
                        //           child: Text(
                        //             "알 수 없는 오류 발생",
                        //           ),
                        //         );
                        //       }
                        //     } else if (snapshot.hasData) {
                        //       // 데이터가 있을 경우의 처리

                        //       return VolPostCard(
                        //         id: item["item"] ?? "",
                        //         title: item["title"] ?? "",
                        //         contnet: item["contnet"] ?? "",
                        //         host: item["host"] ?? "",
                        //         locationStr: item["locationStr"] ?? "",
                        //         actPlace: item["actPlace"] ?? "",
                        //         teenager: item["teenager"] ?? "",
                        //         listApiType: item["listApiType"] ?? "",
                        //       );
                        //     } else {
                        //       // 이외의 경우에 대한 처리ㄴㄴ
                        //       return const Center(
                        //         child: Text("데이터 없음"),
                        //       );
                        //     }
                        //   },
                        // );
                      }
                      // return Container(
                      //   height: 140,
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //   ),
                      //   child: VolPostCard(
                      //     id: item["item"] ?? "",
                      //     title: item["title"] ?? "",
                      //     contnet: item["contnet"] ?? "",
                      //     host: item["host"] ?? "",
                      //     locationStr: item["locationStr"] ?? "",
                      //     startTime: item["startTime"] ?? "",
                      //     endTime: item["endTime"] ?? "",
                      //   ),
                      // );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                  ),
                ),
              ],
            ),
          ),
          if (_isFocused)
            // 슬라이드 화면 뒤쪽의 검은 화면 구현
            ModalBarrier(
              // color: _barrierAnimation,
              color: Colors.transparent,
              // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
              dismissible: true,
              // 자신을 클릭하면 실행되는 함수
              onDismiss: () => _focusNode.unfocus(),
            ),
          // 검색 화면
          FadeTransition(
            opacity: _panelOpacityAnimation,
            child: SlideTransition(
              position: _panelSlideAnimation,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(6),
                child: SWAGTextField(
                  hintText: "검색어를 입력하세요.",
                  maxLine: 1,
                  controller: _searchController,
                  onSubmitted: () {
                    _searchController.text = "";
                    _focusNode.unfocus();
                    _toggleAnimations();
                  },
                  onChanged: (String? value) {
                    setState(() {
                      searchText = value ?? '';
                    });
                  },
                  buttonText: "검색",
                  focusNode: _focusNode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
