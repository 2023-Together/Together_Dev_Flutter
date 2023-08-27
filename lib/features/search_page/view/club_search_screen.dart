import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/widgets/club_request_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/models/club_search_model.dart';

class ClubSearchScreen extends StatefulWidget {
  // 필드

  // 생성자
  const ClubSearchScreen({super.key});

  static const routeName = "club_search";
  static const routeURL = "/club_search";

  @override
  State<ClubSearchScreen> createState() => _ClubSearchScreenState();
}

class _ClubSearchScreenState extends State<ClubSearchScreen>
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

  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController _scrollController = ScrollController();
  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  List<ClubSearchModel>? _clubList;
  List<ClubSearchModel>? _filteredList;

  bool _isFocused = false;
  bool _isOnlyRequest = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    _scrollController.addListener(() {
      // 검색 창이 내려와있을대 스크롤 하면 검색창 다시 사라짐
      if (_animationController.isCompleted) {
        _toggleAnimations();
      }
    });
  }

  // 동아리 리스트를 가져오는 통신
  Future<List<ClubSearchModel>> _clubGetDispatch() async {
    final url = Uri.parse("${HttpIp.communityUrl}/together/club/getAllClub");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("동아리 리스트 : 성공");

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      _clubList =
          jsonResponse.map((data) => ClubSearchModel.fromJson(data)).toList();

      return _clubList!;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("동아리 데이터를 불러오는데 실패하였습니다.");
    }
  }

  Future<void> _searchClubList() async {
    final url =
        Uri.parse("${HttpIp.communityUrl}/together/club/getClubForKeyword");
    final headers = {'Content-Type': 'application/json'};
    final data = {"keyword": _searchController.text};

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse.length);
      print("동아리 검색 : 성공");

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      _clubList =
          jsonResponse.map((data) => ClubSearchModel.fromJson(data)).toList();

      _searchController.text = "";
      _focusNode.unfocus();
      _toggleAnimations();
      setState(() {});
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
  }

  // 스크롤 위치를 맨위로 이동시킵니다.
  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // 리스트 새로고침
  Future _refreshClubList() async {
    _clubList = await _clubGetDispatch();
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
      // _toggleBarrier();
      _focusNode.unfocus();
    } else {
      // 애니메이션을 실행
      _animationController.forward();
    }
  }

  void _toggleOnlyRequest() {
    _scrollToTop();
    setState(() {
      _isOnlyRequest = !_isOnlyRequest;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  // void onChangeOption1(String? value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("동아리"),
        elevation: 1,
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ElevatedButton(
                  onPressed: _toggleOnlyRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isOnlyRequest
                        ? Colors.purple.shade300
                        : Colors.grey.shade400,
                  ),
                  child: const Text(
                    "신청 가능",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<ClubSearchModel>>(
            future: _clubList != null
                ? Future.value(_clubList!)
                : _clubGetDispatch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터를 기다리는 동안 로딩 인디케이터 표시
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // 에러가 발생한 경우 에러 메시지 표시
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              } else {
                // 데이터를 성공적으로 가져왔을 때 ListView 표시
                _clubList = snapshot.data!;
                _filteredList = _clubList!
                    .where((element) => element.clubRecruiting == 1)
                    .toList();

                return RefreshIndicator.adaptive(
                  onRefresh: _refreshClubList,
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemBuilder: (context, index) {
                      if (_isOnlyRequest) {
                        return ClubRequestCard(
                          clubData: _filteredList![index],
                        );
                      } else {
                        return ClubRequestCard(
                          clubData: _clubList![index],
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.v14;
                    },
                    itemCount: _isOnlyRequest
                        ? _filteredList!.length
                        : _clubList!.length,
                  ),
                );
              }
            },
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
                  onSubmitted: _searchClubList,
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

List<Map<String, dynamic>> clubSearchPostList = [
  {
    "clubId": 1,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 22,
    "isRequest": true,
  },
  {
    "clubId": 2,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 64,
    "isRequest": true,
  },
  {
    "clubId": 3,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 21,
    "isRequest": false,
  },
  {
    "clubId": 4,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 18,
    "isRequest": true,
  },
  {
    "clubId": 5,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 8,
    "isRequest": false,
  },
  {
    "clubId": 6,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 37,
    "isRequest": false,
  },
];

List<Map<String, dynamic>> initClubSearchPostList = [
  {
    "clubId": 1,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 22,
    "isRequest": true,
  },
  {
    "clubId": 2,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 64,
    "isRequest": true,
  },
  {
    "clubId": 3,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 21,
    "isRequest": false,
  },
  {
    "clubId": 4,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 18,
    "isRequest": true,
  },
  {
    "clubId": 5,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 8,
    "isRequest": false,
  },
  {
    "clubId": 6,
    "clubDef": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "clubMaster": "이재현",
    "clubNum": 37,
    "isRequest": false,
  },
];
