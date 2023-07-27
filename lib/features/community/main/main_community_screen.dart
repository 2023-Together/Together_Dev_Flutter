import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';

class MainCommunityScreen extends StatefulWidget {
  const MainCommunityScreen({
    super.key,
  });

  @override
  State<MainCommunityScreen> createState() => _MainCommunityScreenState();
}

class _MainCommunityScreenState extends State<MainCommunityScreen>
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

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    // 스크롤 이벤트 처리
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

  // 리스트 체크
  // 광고가 없음 : 광고 삽입
  // 광고가 있음 : 그냥 리턴
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
    final showJumpButton = _scrollController.offset > 260;
    if (_showJumpUpButton != showJumpButton) {
      setState(() {
        _showJumpUpButton = showJumpButton;
      });
    }

    // if (_scrollController.offset > 260) {
    //   // 이미 true인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
    //   // 리턴처리 필요
    //   if (_showJumpUpButton) return;
    //   setState(() {
    //     _showJumpUpButton = true;
    //   });
    // } else {
    //   // 이미 false인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
    //   // 리턴처리 필요
    //   if (!_showJumpUpButton) return;
    //   setState(() {
    //     _showJumpUpButton = false;
    //   });
    // }
  }

  // 스크롤이 맨아래로 내려가면 새로운 리스트 추가
  void _scrollEnd() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        // 새로 추가한 리스트에 광고 넣기
        comunityList = [...comunityList] + checkAds(initComunityList);
      });
    }
  }

  void _alertIconTap() {
    context.pushNamed(AlertScreen.routeName);
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void _onLoginTap() {
    context.pushNamed(SignInScreen.routeName);
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
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: !_showJumpUpButton
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                )
              : null,
          centerTitle: false,
          title: const Text("Together(로고)"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size14,
                vertical: Sizes.size10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: isLogined
                    ? [
                        GestureDetector(
                          onTap: _toggleAnimations,
                          child: const Icon(Icons.search),
                        ),
                      ]
                    : [
                        GestureDetector(
                          onTap: _onLoginTap,
                          child: const Icon(
                            Icons.account_circle_outlined,
                          ),
                        ),
                        Gaps.h6,
                        GestureDetector(
                          onTap: _toggleAnimations,
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !_isFocused,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: _showJumpUpButton ? 1 : 0,
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
              if (isLogined)
                AnimatedOpacity(
                  opacity: isLogined ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: FloatingActionButton(
                    heroTag: "community_edit",
                    onPressed: () {
                      // 동아리 게시글 작성
                      context.pushNamed(
                        PostEditScreen.routeName,
                        extra: PostEditScreenArgs(
                          pageTitle: "게시글 등록",
                          editType: PostEditType.mainInsert,
                        ),
                      );
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
        ),
        // CustomScrollView : 스크롤 가능한 구역
        body: Stack(
          children: [
            RefreshIndicator.adaptive(
              onRefresh: _refreshComunityList,
              child: CustomScrollView(
                controller: _scrollController,
                // CustomScrollView 안에 들어갈 element들
                // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ListTile(
                        onTap: () {
                          context.pushNamed(
                            NoticeScreen.routeName,
                          );
                        },
                        shape: const BeveledRectangleBorder(
                          side: BorderSide(
                            width: 0.1,
                          ),
                        ),
                        title: const Text(
                          "공지사항",
                          maxLines: 1,
                        ),
                        subtitle: const Text(
                          "최근 등록일 : 5일전",
                          maxLines: 1,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: comunityList.length,
                      (context, index) {
                        final item = comunityList[index];
                        if (item["type"] != "ad") {
                          return PostCard(
                            key: Key(item["title"]),
                            postId: index,
                            category: item["category"],
                            title: item["title"],
                            // images: List<String>.from(item["imgUrl"]),
                            initCheckGood: item["checkGood"],
                            content: item["content"],
                            date: item["date"],
                            user: item["user"],
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
                    onSubmitted: () {
                      _searchController.text = "";
                      _focusNode.unfocus();
                      _toggleAnimations();
                    },
                    buttonText: "검색",
                    focusNode: _focusNode,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    "date": "2023-06-01",
    "user": "유저1",
    "category": "옵션 1",
  },
  {
    "type": "default",
    "title": "제목2",
    "checkGood": false,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-02",
    "user": "유저2",
    "category": "옵션 4",
  },
  {
    "type": "default",
    "title": "제목3",
    "checkGood": false,
    "imgUrl": [
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/70836_50981_2758.jpg",
      "assets/images/dog.jpg",
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-07-04",
    "user": "유저3",
    "category": "옵션 2",
  },
  {
    "type": "default",
    "title": "제목4",
    "checkGood": true,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-04",
    "user": "유저4",
    "category": "옵션 5",
  },
  {
    "type": "default",
    "title": "제목5",
    "checkGood": false,
    "imgUrl": [
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-02-17",
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
    "date": "2023-05-06",
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
    "date": "2023-05-07",
    "user": "유저7",
    "category": "옵션 2",
  },
  {
    "type": "default",
    "title": "제목8",
    "checkGood": true,
    "imgUrl": [],
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-08",
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
      "assets/images/dog.jpg",
    ],
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-09",
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
