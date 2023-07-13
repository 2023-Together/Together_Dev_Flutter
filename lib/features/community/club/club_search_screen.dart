import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/club_request_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';

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

  bool _isFocused = false;
  bool _showJumpUpButton = false;
  bool _isOnlyRequest = false;
  List<Map<String, dynamic>> filteredList = clubSearchPostList
      .where((element) => element["isRequest"] == true)
      .toList();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    _scrollController.addListener(() {
      _onScroll();
      _scrollEnd();

      // 검색 창이 내려와있을대 스크롤 하면 검색창 다시 사라짐
      if (_animationController.isCompleted) {
        _toggleAnimations();
      }
    });
  }

  // 스크롤 할때마다 호출
  void _onScroll() {
    if (_scrollController.offset > 260) {
      // 이미 true인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
      // 리턴처리 필요
      if (_showJumpUpButton) return;
      setState(() {
        _showJumpUpButton = true;
      });
    } else {
      // 이미 false인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
      // 리턴처리 필요
      if (!_showJumpUpButton) return;
      setState(() {
        _showJumpUpButton = false;
      });
    }
  }

  // 스크롤이 맨아래로 내려가면 새로운 리스트 추가
  void _scrollEnd() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        clubSearchPostList = [...clubSearchPostList] + initClubSearchPostList;
        filteredList = clubSearchPostList
            .where((element) => element["isRequest"] == true)
            .toList();
      });
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
    setState(() {
      clubSearchPostList = initClubSearchPostList;
    });
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

    setState(() {});
  }

  void _toggleOnlyRequest() {
    _scrollToTop();
    setState(() {
      _isOnlyRequest = !_isOnlyRequest;
    });
  }

  // void _onChangeOption1(String option) {
  //   setState(() {
  //     _option1 = option;
  //   });
  // }

  // void _onChangeOption2(String option) {
  //   setState(() {
  //     _option2 = option;
  //   });
  // }

  // void _onChangeOption3(String option) {
  //   setState(() {
  //     _option3 = option;
  //   });
  // }

  // void onChangeOption1(String? value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            opacity: _showJumpUpButton
                ? !_isFocused
                    ? 1
                    : 0
                : 0,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              heroTag: "comunity",
              onPressed: _scrollToTop,
              backgroundColor: Colors.purpleAccent.shade100,
              child: const FaIcon(
                FontAwesomeIcons.arrowUp,
                color: Colors.black,
              ),
            ),
          ),
          Gaps.v6,
          FloatingActionButton(
            heroTag: "community_edit",
            onPressed: () {
              // 동아리 게시글 작성
              context.pushNamed(
                PostEditScreen.routeName,
                extra: PostEditScreenArgs(maxImages: 1),
              );
            },
            backgroundColor: Colors.blue.shade300,
            child: const FaIcon(
              FontAwesomeIcons.penToSquare,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
          RefreshIndicator.adaptive(
            onRefresh: _refreshClubList,
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemBuilder: (context, index) {
                if (_isOnlyRequest) {
                  final item = filteredList[index];
                  return ClubRequestCard(
                    postId: item["postId"],
                    postTitle: item["postTitle"],
                    postContent: item["postContent"],
                    clubName: item["clubName"],
                    clubMaster: item["clubMaster"],
                    postDate: item["postDate"],
                    isRequest: item["isRequest"],
                  );
                } else {
                  final item = clubSearchPostList[index];
                  return ClubRequestCard(
                    postId: item["postId"],
                    postTitle: item["postTitle"],
                    postContent: item["postContent"],
                    clubName: item["clubName"],
                    clubMaster: item["clubMaster"],
                    postDate: item["postDate"],
                    isRequest: item["isRequest"],
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Gaps.v14;
              },
              itemCount: _isOnlyRequest
                  ? filteredList.length
                  : clubSearchPostList.length,
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
                    print(_searchController.text);
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

List<Map<String, dynamic>> clubSearchPostList = [
  {
    "postId": 1,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-09",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 2,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-07",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 3,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-04-20",
    "clubMaster": "이재현",
    "isRequest": false,
  },
  {
    "postId": 4,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-06-25",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 5,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-01",
    "clubMaster": "이재현",
    "isRequest": false,
  },
  {
    "postId": 6,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-10",
    "clubMaster": "이재현",
    "isRequest": false,
  },
];

List<Map<String, dynamic>> initClubSearchPostList = [
  {
    "postId": 1,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-09",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 2,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-07",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 3,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-04-20",
    "clubMaster": "이재현",
    "isRequest": false,
  },
  {
    "postId": 4,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-06-25",
    "clubMaster": "이재현",
    "isRequest": true,
  },
  {
    "postId": 5,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-01",
    "clubMaster": "이재현",
    "isRequest": false,
  },
  {
    "postId": 6,
    "postTitle": "SWAG 동아리원 모집",
    "postContent": "동아리에서 동아리원을 모집합니다! 많은 관심 부탁드립니다. :)",
    "clubName": "SWAG 동아리",
    "postDate": "2023-07-10",
    "clubMaster": "이재현",
    "isRequest": false,
  },
];
