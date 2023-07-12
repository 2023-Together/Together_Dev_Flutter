import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/notice/club_notice_screen.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/storages/secure_storage_login.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ClubCommunityScreenArgs {
  final int clubId;

  ClubCommunityScreenArgs({required this.clubId});
}

class ClubCommunityScreen extends StatefulWidget {
  final int clubId;

  const ClubCommunityScreen({
    super.key,
    required this.clubId,
  });

  static const routeName = "club_community";
  static const routeURL = "/club_community";

  @override
  State<ClubCommunityScreen> createState() => _ClubCommunityScreenState();
}

class _ClubCommunityScreenState extends State<ClubCommunityScreen>
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

  // 배리어 애니메이션
  // late final Animation<Color?> _barrierAnimation = ColorTween(
  //   begin: Colors.transparent,
  //   end: Colors.black12,
  // ).animate(_animationController);

  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController _scrollController = ScrollController();
  // 공지사항 슬라이드 제어를 위한 컨트롤러
  final CarouselController _carouselController = CarouselController();
  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

  bool _isLogined = false;
  bool _showJumpUpButton = false;
  final int _currentNoticeIndex = 0;

  double width = 0;
  double height = 0;

  String _option1 = "";
  final List<String> _optionList1 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  String _option2 = "";
  final List<String> _optionList2 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  String _option3 = "";
  final List<String> _optionList3 = ["", "옵션 1", "옵션 2", "옵션 3", "옵션 4"];

  // 카테고리의 공통 스타일
  final double _optionsFontSize = 16;
  final _optionsPadding =
      const EdgeInsets.symmetric(vertical: 6, horizontal: 8);

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    _scrollController.addListener(
      () {
        _onScroll();
        _scrollEnd();

        // 검색 창이 내려와있을대 스크롤 하면 검색창 다시 사라짐
        if (_animationController.isCompleted) {
          _toggleAnimations();
        }
      },
    );

    // 로그인 타입을 가져와서 로그인 상태를 적용한다.
    checkLoginType();

    // 이미 리스트안에 광고가 삽입되어 있으면 더이상 삽입하지 않음
    comunityList = checkAds(initComunityList);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
  void checkLoginType() async {
    var loginType = await SecureStorageLogin.getLoginType();
    print(loginType);
    if (loginType == "naver" || loginType == "kakao") {
      _isLogined = true;
    } else {
      _isLogined = false;
    }
    setState(() {});
  }

  // 이미 리스트안에 광고가 삽입되어 있으면 더이상 삽입하지 않는 함수
  List<Map<String, dynamic>> checkAds(List<Map<String, dynamic>> list) {
    if (!list.any((item) => item["type"] == "ad")) {
      // 리스트 사이에 광고 넣기
      for (int i = initComunityList.length; i >= 1; i -= 5) {
        list.insert(i, {"type": "ad"});
      }
    }
    return list;
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

  void _scrollEnd() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        comunityList = [...comunityList] + checkAds(initComunityList);
      });
    }
  }

  void _alertIconTap() {
    context.pushNamed(AlertScreen.routeName);
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
  Future _refreshComunityList() async {
    setState(() {
      comunityList = checkAds(initComunityList);
    });
  }

  // 광고 로딩 실패일때 실행
  void failedAdsLoading(Ad ad, LoadAdError error) {
    ad.dispose();
    print("광고 로딩에 실패! 사유 : ${error.message}, ${error.code}");
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

  void _onChangeOption1(String option) {
    setState(() {
      _option1 = option;
    });
  }

  void _onChangeOption2(String option) {
    setState(() {
      _option2 = option;
    });
  }

  void _onChangeOption3(String option) {
    setState(() {
      _option3 = option;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shape: !_showJumpUpButton
            ? const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.0),
                ),
              )
            : null,
        centerTitle: false,
        title: const Text("SWAG 동아리(10명)"),
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
                  // child: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                ),
                Gaps.h2,
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.edit_note_rounded),
                  // child: const FaIcon(FontAwesomeIcons.penToSquare),
                ),
              ],
            ),
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: Container(
        //     height: 50,
        //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        //     child: ListView(
        //       scrollDirection: Axis.horizontal,
        //       children: [
        //         SWAGStateDropDownButton(
        //           initOption: _option1,
        //           onChangeOption: _onChangeOption1,
        //           title: "카테고리1",
        //           options: _optionList1,
        //           fontSize: _optionsFontSize,
        //           padding: _optionsPadding,
        //         ),
        //         Gaps.h8,
        //         SWAGStateDropDownButton(
        //           initOption: _option2,
        //           onChangeOption: _onChangeOption2,
        //           title: "카테고리2",
        //           options: _optionList2,
        //           fontSize: _optionsFontSize,
        //           padding: _optionsPadding,
        //         ),
        //         Gaps.h8,
        //         SWAGStateDropDownButton(
        //           initOption: _option3,
        //           onChangeOption: _onChangeOption3,
        //           title: "카테고리3",
        //           options: _optionList3,
        //           fontSize: _optionsFontSize,
        //           padding: _optionsPadding,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            opacity: _showJumpUpButton
                ? _animationController.isDismissed
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
          AnimatedOpacity(
            opacity: _animationController.isCompleted ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              heroTag: "club_community_edit",
              onPressed: () {
                // 동아리 게시글 작성
                context.pushNamed(PostEditScreen.routeName);
              },
              backgroundColor: Colors.blue.shade300,
              child: const FaIcon(
                FontAwesomeIcons.penToSquare,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      // CustomScrollView : 스크롤 가능한 구역
      body: Stack(
        children: [
          // 메인 화면
          RefreshIndicator.adaptive(
            onRefresh: _refreshComunityList,
            child: CustomScrollView(
              controller: _scrollController,
              // CustomScrollView 안에 들어갈 element들
              // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
              slivers: [
                // SliverToBoxAdapter : sliver에서 일반 flutter 위젯을 사용할때 쓰는 위젯
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size4,
                            horizontal: Sizes.size20,
                          ),
                          child: Image.asset(
                            "assets/images/volImg.jpg",
                            width: size.width,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gaps.v8,
                        ListTile(
                          onTap: () => context.pushNamed(
                            ClubNoticeScreen.routeName,
                            extra: ClubNoticeScreenArgs(isLogined: _isLogined),
                          ),
                          shape: const BeveledRectangleBorder(
                            side: BorderSide(
                              width: 0.1,
                            ),
                          ),
                          title: const Text(
                            "동아리 공지사항",
                            maxLines: 1,
                          ),
                          subtitle: const Text(
                            "마지막 등록일 : 5일전",
                            maxLines: 1,
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SliverFixedExtentList : item들의 리스트를 만들어 냄
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: comunityList.length,
                    (context, index) {
                      final item = comunityList[index];
                      if (item["type"] != "ad") {
                        return PostCard(
                          key: Key(item["title"]),
                          category: item["category"],
                          postId: index,
                          title: item["title"],
                          images: List<String>.from(item["imgUrl"]),
                          initCheckGood: item["checkGood"],
                          content: item["content"],
                          date: item["date"],
                          user: item["user"],
                          isLogined: _isLogined,
                        );
                      } else {
                        return StatefulBuilder(
                          builder: (context, setState) => Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: AdWidget(
                              ad: BannerAd(
                                listener: BannerAdListener(
                                  onAdFailedToLoad: failedAdsLoading,
                                  onAdLoaded: (_) {},
                                ),
                                size: AdSize.fullBanner,
                                adUnitId: AdHelper.bannerAdUnitId,
                                request: const AdRequest(),
                              )..load(),
                            ),
                          ),
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
                  isLogined: true,
                  onSubmitted: () {
                    _searchController.text = "";
                    _focusNode.unfocus();
                    _toggleAnimations();
                  },
                  onChanged: (String value) {
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

List<Map<String, dynamic>> comunityList = [];

List<Map<String, dynamic>> initComunityList = [
  {
    "type": "default",
    "title": "제목1",
    "checkGood": true,
    "imgUrl": [
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-1",
    "user": "유저1",
    "category": "옵션 1",
  },
  {
    "type": "default",
    "title": "제목2",
    "checkGood": false,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-2",
    "user": "유저2",
    "category": "옵션 4",
  },
  {
    "type": "default",
    "title": "제목3",
    "checkGood": false,
    "imgUrl": [
      "assets/images/70836_50981_2758.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-3",
    "user": "유저3",
    "category": "옵션 2",
  },
  {
    "type": "default",
    "title": "제목4",
    "checkGood": true,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-4",
    "user": "유저4",
    "category": "옵션 5",
  },
  {
    "type": "default",
    "title": "제목5",
    "checkGood": false,
    "imgUrl": [
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-5",
    "user": "유저5",
    "category": "옵션 3",
  },
  {
    "type": "default",
    "title": "제목6",
    "checkGood": false,
    "imgUrl": [
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-6",
    "user": "유저6",
    "category": "옵션 5",
  },
  {
    "type": "default",
    "title": "제목7",
    "checkGood": true,
    "imgUrl": [
      "assets/images/70836_50981_2758.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-7",
    "user": "유저7",
    "category": "옵션 2",
  },
  {
    "type": "default",
    "title": "제목8",
    "checkGood": true,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-8",
    "user": "유저8",
    "category": "옵션 1",
  },
  {
    "type": "default",
    "id": 9,
    "title": "제목9",
    "checkGood": false,
    "imgUrl": [
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/70836_50981_2758.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-9",
    "user": "유저9",
    "category": "옵션 2",
  },
  {
    "type": "default",
    "id": 10,
    "title": "제목10",
    "checkGood": false,
    "imgUrl": [
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-10",
    "user": "유저10",
    "category": "옵션 4",
  },
];

List<Map<String, dynamic>> noticeList = [
  {
    "id": 1,
    "title": "제목1",
    "content": "내용1",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 2,
    "title": "제목2",
    "content": "내용2",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 3,
    "title": "제목3",
    "content": "내용3",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 4,
    "title": "제목4",
    "content": "내용4",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 5,
    "title": "제목5",
    "content": "내용5",
    "date": "2023-07-10 16:43",
  },
];
