import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/widgets/vol_post_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_state_dropDown_button.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
//import 'package:swag_cross_app/features/page_test/widgets/categori_buttons.dart';
//import 'package:swag_cross_app/features/page_test/widgets/state_dropDown_button.dart';

import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> volCategories = [
  "카테고리1",
  "카테고리2",
  "카테고리3",
];

class VolSearchScreen extends StatefulWidget {
  const VolSearchScreen({Key? key}) : super(key: key);

  @override
  State<VolSearchScreen> createState() => _VolSearchScreenState();
}

class _VolSearchScreenState extends State<VolSearchScreen> {
  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 스크롤 제어를 위한 컨트롤러
  final ScrollController _scrollController = ScrollController();
  // 포커스 제어를 위한 컨트롤러
  final FocusNode _focusNode = FocusNode();

  late List<VolunteerModel> _volList;

  int pageNum = 1;
  bool _isFocused = false;
  bool _isSearched = false;
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;

  String? _searchText;

  String selectedDropdown3 = '';
  String selectedDropdown4 = '';

  @override
  void initState() {
    super.initState();

    _initLoad();

    _focusNode.addListener(_onChangeFocused);

    _scrollController.addListener(_scrollEnd);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  void _onChangeFocused() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  Future<void> _initLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final url = Uri.parse("http://59.4.3.198:80/together/readVMS1365Api");
      final data = {"pageNum": "$pageNum"};

      final response = await http.post(url, body: data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print("봉사 리스트 : 성공");

        setState(() {
          _volList = jsonResponse
              .map((data) => VolunteerModel.fromJson(data))
              .toList();
          pageNum++;
        });
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception("API를 불러오는데 실패하였습니다.");
      }
    } catch (e) {
      throw Exception("통신 실패! : $e");
    } finally {
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
  }

  // 리스트 새로고침
  Future<void> _refreshVolList() async {
    setState(() {
      _isFirstLoadRunning = true;
      pageNum = 1;
    });

    try {
      final url = Uri.parse("http://59.4.3.198:80/together/readVMS1365Api");
      final data = {"pageNum": "$pageNum"};

      final response = await http.post(url, body: data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print(jsonResponse);
        print("봉사 리스트 : 성공");

        setState(() {
          _volList = jsonResponse
              .map((data) => VolunteerModel.fromJson(data))
              .toList();
          pageNum++;
        });
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception("API를 불러오는데 실패하였습니다.");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
  }

  void _searchVolList() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
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
        _isFocused = false;
        _isSearched = true;
        _searchText = _searchController.text;
        _focusNode.unfocus();
      });
    } else {
      print("${response.statusCode} : ${response.body}");
      throw Exception("통신 실패!");
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _scrollEnd() async {
    // 스크롤이 맨 아래로 내려가면 실행됨
    if (_scrollController.position.extentAfter < 350 &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      if (_isSearched) {
        // 검색 결과가 있는 경우 추가 데이터를 가져옵니다.
        final url =
            Uri.parse("http://59.4.3.198:80/together/read1365selectApi");
        final data = {"pageNum": "$pageNum", "keyword": _searchController.text};

        final response = await http.post(url, body: data);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          final jsonResponse = jsonDecode(response.body) as List<dynamic>;
          print("봉사 검색 : 성공");

          // 응답 데이터를 VolunteerModel 리스트로 파싱하고 _volList에 추가
          setState(() {
            _volList.addAll(jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList());
            pageNum++;
          });
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
          // print(jsonResponse);
          print("봉사 리스트 : 성공");

          setState(() {
            _volList.addAll(jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList());
            pageNum++;
          });
        } else {
          print('Response status: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception("API를 불러오는데 실패하였습니다.");
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _onVolBoxTap(VolunteerModel volData) {
    if (!context.read<UserProvider>().isLogined) {
      final loginType = context.read<UserProvider>().isLogined;

      if (loginType.toString() != "naver" && loginType.toString() != "kakao") {
        swagPlatformDialog(
          context: context,
          title: "로그인 알림",
          message: "해당 봉사가 등록되어 있는 1365 혹은 vms 페이지로 이동하시겠습니까?",
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("아니오"),
            ),
            TextButton(
              onPressed: () {
                if (volData.listApiType == "1365") {
                  final url_1365 = Uri.parse(
                      'https://www.1365.go.kr/vols/1572247904127/partcptn/timeCptn.do?type=show&progrmRegistNo=${volData.seq}');
                  launchUrl(
                    url_1365,
                    mode: LaunchMode.externalApplication,
                  );
                } else if (volData.listApiType == "vms") {
                  final urlVms = Uri.parse(
                      'https://www.vms.or.kr/partspace/recruitView.do?seq=${volData.seq}');
                  launchUrl(
                    urlVms,
                    mode: LaunchMode.externalApplication,
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("예"),
            ),
          ],
        );
      }
    } else {
      try {
        if (volData.listApiType == "1365") {
          final url_1365 = Uri.parse(
              'https://www.1365.go.kr/vols/1572247904127/partcptn/timeCptn.do?type=show&progrmRegistNo=${volData.seq}');
          launchUrl(
            url_1365,
            mode: LaunchMode.externalApplication,
          );
        } else if (volData.listApiType == "vms") {
          final urlVms = Uri.parse(
              'https://www.vms.or.kr/partspace/recruitView.do?seq=${volData.seq}');
          launchUrl(
            urlVms,
            mode: LaunchMode.externalApplication,
          );
        }
        Navigator.pop(context);
      } catch (e) {
        print("URL 열기 에러: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Container(
          color: Colors.white,
          child: SWAGTextField(
            hintText: "검색어를 입력하세요.",
            maxLine: 1,
            controller: _searchController,
            onSubmitted: _searchVolList,
            buttonText: "검색",
            focusNode: _focusNode,
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
                _isFirstLoadRunning
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    : _volList.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text('통신에 실패하였습니다!'),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator.adaptive(
                              onRefresh: _refreshVolList,
                              child: ListView.builder(
                                cacheExtent: 100,
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _volList.length,
                                itemBuilder: (context, index) {
                                  final item = _volList[index];
                                  return GestureDetector(
                                    onTap: () => _onVolBoxTap(item),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: VolPostCard(
                                        volData: item,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
              ],
            ),
          ),
          // if (_isFocused)
          // 슬라이드 화면 뒤쪽의 검은 화면 구현
          if (_isFocused)
            AnimatedOpacity(
              opacity: _isFocused ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: ModalBarrier(
                // color: _barrierAnimation,
                color: Colors.black12,
                // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
                dismissible: true,
                // 자신을 클릭하면 실행되는 함수
                onDismiss: () => _focusNode.unfocus(),
              ),
            ),
        ],
      ),
    );
  }
}

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