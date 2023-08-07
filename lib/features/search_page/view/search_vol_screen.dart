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

import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';

import 'package:http/http.dart' as http;

final List<String> volCategories = [
  "카테고리1",
  "카테고리2",
  "카테고리3",
];

class VolSearchScreen extends StatefulWidget {
  const VolSearchScreen({super.key});

  @override
  State<VolSearchScreen> createState() => _VolSearchScreenState();
}

class _VolSearchScreenState extends State<VolSearchScreen> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 스크롤 제어를 위한 컨트롤러
  final ScrollController _scrollController = ScrollController();
  final double _previousScrollOffset = 0.0;

  List<VolunteerModel>? _volList;

  int pageNum = 1;
  final bool _isFocused = false;
  bool _isSearched = false;
  int totalItemsCount = 0;

  String selectedDropdown1 = '';
  String selectedDropdown2 = '';
  String selectedDropdown3 = '';
  String selectedDropdown4 = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollEnd);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  // 리스트 새로고침
  Future<void> _refreshVolList() async {
    pageNum = 1;
    if (_isSearched) {
      await _searchVolList();
    } else {
      final newVolList = await _postGetApiDispatch();
      _volList!.clear();
      setState(() {
        _volList!.addAll(newVolList);
      });
    }
  }

  Future<List<VolunteerModel>> _postGetApiDispatch() async {
    final url = Uri.parse("http://59.4.3.198:80/together/readVMS1365Api");
    final data = {"pageNum": "$pageNum"};

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);
      print("봉사 리스트 : 성공");

      List<VolunteerModel> newVolList =
          jsonResponse.map((data) => VolunteerModel.fromJson(data)).toList();
      print(pageNum++);

      return newVolList;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("API를 불러오는데 실패하였습니다.");
    }
  }

  Future<void> _searchVolList() async {
    final url = Uri.parse("http://59.4.3.198:80/together/read1365selectApi");
    final data = {"pageNum": "$pageNum", "keyword": _searchController.text};
    pageNum = 0;

    final response = await http.post(url, body: data);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("봉사 검색 : 성공");

      setState(() {
        _volList =
            jsonResponse.map((data) => VolunteerModel.fromJson(data)).toList();

        pageNum++;
        _isSearched = true;
      });
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  Future<void> _scrollEnd() async {
    // 스크롤이 맨 아래로 내려가면 실행됨
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Future.delayed(const Duration(milliseconds: 100)).then((_) async {
        if (_isSearched) {
          // 검색 결과가 있는 경우 추가 데이터를 가져옵니다.
          final url =
              Uri.parse("http://59.4.3.198:80/together/read1365selectApi");
          final data = {
            "pageNum": "$pageNum",
            "keyword": _searchController.text
          };

          final response = await http.post(url, body: data);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            final jsonResponse = jsonDecode(response.body) as List<dynamic>;
            print("봉사 검색 : 성공");

            // 응답 데이터를 VolunteerModel 리스트로 파싱하고 _volList에 추가
            _updateList(jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList());
          } else {
            print("${response.statusCode} : ${response.body}");
            throw Exception("통신 실패!");
          }
        } else {
          // 전체 리스트에서 추가 데이터를 가져옵니다.
          final url = Uri.parse("http://59.4.3.198:80/together/readVMS1365Api");
          final data = {"pageNum": "$pageNum"};

          final response = await http.post(url, body: data);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            final jsonResponse = jsonDecode(response.body) as List<dynamic>;
            print(jsonResponse);
            print("봉사 리스트 : 성공");

            _updateList(jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList());
          } else {
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            throw Exception("API를 불러오는데 실패하였습니다.");
          }
        }
      });
    }
  }

  void _updateList(List<VolunteerModel> newVolList) {
    final int index = _volList!.length;
    _volList!.addAll(newVolList);

    // 새로운 _volList의 개수로 totalItemsCount 업데이트
    totalItemsCount = _volList!.length;

    _listKey.currentState?.insertItem(index);
    pageNum++;
  }

  @override
  Widget build(BuildContext context) {
    print("pageNum : $pageNum");
    print("volNum : ${_volList?.length}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(6),
          child: SWAGTextField(
            hintText: "검색어를 입력하세요.",
            maxLine: 1,
            controller: _searchController,
            onSubmitted: _searchVolList,
            buttonText: "검색",
          ),
        ),
        automaticallyImplyLeading: false,
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
                    horizontal: Sizes.size6,
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
                  child: FutureBuilder<List<VolunteerModel>>(
                    future: _volList != null
                        ? Future.value(
                            _volList!) // _postList가 이미 가져온 상태라면 Future.value 사용
                        : _postGetApiDispatch(), // _postList가 null이라면 데이터를 가져오기 위해 호출
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // 데이터를 기다리는 동안 로딩 인디케이터 표시
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        // 에러가 발생한 경우 에러 메시지 표시
                        return Center(
                          child: Text('오류 발생: ${snapshot.error}'),
                        );
                      } else {
                        // 데이터를 성공적으로 가져왔을 때 ListView 표시
                        _volList = snapshot.data!;

                        return RefreshIndicator.adaptive(
                          onRefresh: _refreshVolList,
                          child: ListView.separated(
                            key: Key(
                                totalItemsCount.toString()), // 상태 유지를 위해 키 사용
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: _volList!.length,
                            itemBuilder: (context, index) {
                              final item = _volList![index];
                              return Container(
                                height: 140,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: VolPostCard(
                                  volData: item,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Gaps.v10,
                          ),
                          // child: CustomScrollView(
                          //   controller: _scrollController,
                          //   slivers: <Widget>[
                          //     SliverPadding(
                          //       padding: const EdgeInsets.symmetric(
                          //         horizontal: Sizes.size10,
                          //       ),
                          //       sliver: SliverList(
                          //         key: _listKey, // 이 부분을 추가하세요.
                          //         delegate: SliverChildBuilderDelegate(
                          //           (BuildContext context, int index) {
                          //             final item = _volList![index];
                          //             return Container(
                          //               height: 140,
                          //               decoration: const BoxDecoration(
                          //                 color: Colors.white,
                          //               ),
                          //               child: VolPostCard(
                          //                 volData: item,
                          //               ),
                          //             );
                          //           },
                          //           childCount: _volList!.length,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        );
                      }
                    },
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
              onDismiss: () => FocusScope.of(context).unfocus(),
            ),
        ],
      ),
    );
  }
}

final List<String> dropdownList1 = [
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
final List<String> dropdownList2 = [
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

final List<String> dropdownList3 = [
  '',
  '모집 중',
  '모집 완료',
];

final List<String> dropdownList4 = [
  '',
  '가능',
  '불가능',
];
