import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/search_page/widgets/vol_post_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_platform_dialog.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

import 'package:swag_cross_app/models/DBModels/volunteer_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  List<VolunteerModel>? _volList;
  List<VolunteerModel>? _filteredList;

  late VolunteerModel volData;

  int pageNum = 1;
  bool _isFocused = false;
  bool _isSearched = false;
  bool _isFiltered = false;
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;

  String? _searchText;

  String selectedStatus = '';
  String selectedTeenager = '';

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
      final url = Uri.parse("${HttpIp.userUrl}/together/readVMS1365Api");
      final data = {"pageNum": "$pageNum"};

      final response = await http.post(url, body: data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print("봉사 리스트 : 성공");
        // print(jsonResponse);
        setState(() {
          _volList = jsonResponse
              .map((data) => VolunteerModel.fromJson(data))
              .toList();

          _filteredList = _volList!.where((item) => item.status == 2).toList();

          pageNum++;
        });
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "목록 호출 실패!",
          message: "${response.statusCode.toString()} : ${response.body}",
        );
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _isFirstLoadRunning = false;
      });
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // 리스트 새로고침
  Future<void> _refreshVolList() async {
    setState(() {
      _isFirstLoadRunning = true;
      pageNum = 1;
    });

    try {
      final url = Uri.parse("${HttpIp.userUrl}/together/readVMS1365Api");
      final data = {"pageNum": "$pageNum"};

      final response = await http.post(url, body: data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        // print(jsonResponse);
        print("봉사 새로고침 : 성공");

        setState(() {
          _volList = jsonResponse
              .map((data) => VolunteerModel.fromJson(data))
              .toList();
          _filteredList = _volList!.where((item) => item.status == 2).toList();

          pageNum++;
          _searchText = null;
          _isSearched = false;
          _isFiltered = false;
        });
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "목록 호출 실패!",
          message: "${response.statusCode.toString()} : ${response.body}",
        );
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _isFirstLoadRunning = false;
      });
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

    try {
      final url = Uri.parse("${HttpIp.userUrl}/together/read1365selectApi");
      final data = {"pageNum": "$pageNum", "keyword": _searchController.text};
      pageNum = 0;

      final response = await http.post(url, body: data);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        print("봉사 검색 : 성공");

        setState(() {
          _volList = jsonResponse
              .map((data) => VolunteerModel.fromJson(data))
              .toList();

          _filteredList = _volList!.where((item) => item.status == 2).toList();

          pageNum++;
          _isFocused = false;
          _isSearched = true;
          _searchText = _searchController.text;
          _focusNode.unfocus();
        });
      } else {
        if (!mounted) return;
        HttpIp.errorPrint(
          context: context,
          title: "검색 실패!",
          message: "${response.statusCode.toString()} : ${response.body}",
        );
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _scrollEnd() async {
    if (_scrollController.position.extentAfter < 350 &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      if (!_isSearched) {
        try {
          final url = Uri.parse("${HttpIp.userUrl}/together/readVMS1365Api");
          final data = {"pageNum": "$pageNum"};

          final response = await http.post(url, body: data);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            final jsonResponse = jsonDecode(response.body) as List<dynamic>;
            // print(jsonResponse);
            print("봉사 리스트 : 성공");

            List<VolunteerModel> newVolList = jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList();
            _filteredList =
                _volList!.where((item) => item.status == 2).toList();

            setState(() {
              _volList!.addAll(newVolList);
              pageNum++;
            });
          } else {
            if (!mounted) return;
            HttpIp.errorPrint(
              context: context,
              title: "추가 호출 실패!",
              message: "${response.statusCode.toString()} : ${response.body}",
            );
          }
        } catch (e) {
          print(e.toString());
        }
      } else {
        try {
          final url = Uri.parse("${HttpIp.userUrl}/together/read1365selectApi");
          final data = {"pageNum": "$pageNum", "keyword": _searchText};

          final response = await http.post(url, body: data);

          if (response.statusCode >= 200 && response.statusCode < 300) {
            final jsonResponse = jsonDecode(response.body) as List<dynamic>;
            // print(jsonResponse);
            print("봉사 리스트 : 성공");

            List<VolunteerModel> newVolList = jsonResponse
                .map((data) => VolunteerModel.fromJson(data))
                .toList();
            _filteredList =
                _volList!.where((item) => item.status == 2).toList();

            setState(() {
              _volList!.addAll(newVolList);
              pageNum++;
            });
          } else {
            if (!mounted) return;
            HttpIp.errorPrint(
              context: context,
              title: "추가 호출 실패!",
              message: "${response.statusCode.toString()} : ${response.body}",
            );
          }
        } catch (e) {
          print(e.toString());
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

  void _toggleOnlyRequest() {
    setState(() {
      _isFiltered = !_isFiltered;
    });
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
                    backgroundColor: _isFiltered
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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
            ),
            child: Column(
              children: [
                _isFirstLoadRunning
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    : _volList == null
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton.filled(
                                    color: Colors.grey.shade300,
                                    iconSize:
                                        MediaQuery.of(context).size.width / 2,
                                    onPressed: _refreshVolList,
                                    icon: const Icon(Icons.refresh),
                                  ),
                                  const Text('봉사 정보를 불러오는데 실패하였습니다.'),
                                ],
                              ),
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
                                itemCount: _isFiltered
                                    ? _filteredList!.length
                                    : _volList!.length,
                                itemBuilder: (context, index) {
                                  final item = _isFiltered
                                      ? _filteredList![index]
                                      : _volList![index];
                                  return GestureDetector(
                                    onTap: () => _onVolBoxTap(item),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
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
  '모집 대기',
  '모집 중',
  '모집 완료',
];

final List<String> dropdownList4 = [
  '',
  '가능',
  '불가능',
];
