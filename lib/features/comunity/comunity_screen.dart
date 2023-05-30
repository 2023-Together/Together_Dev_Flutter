import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/page_test/widgets/club_comunity_item_box.dart';
import 'package:swag_cross_app/features/page_test/widgets/custom_indicator.dart';
import 'package:swag_cross_app/features/page_test/widgets/notice_test_item.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/storages/secure_storage_login.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({super.key});

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController scrollController = ScrollController();
  // 공지사항 스크롤 제어를 위한 컨트롤러
  final CarouselController _carouselController = CarouselController();

  bool _isLogined = false;
  bool _showJumpUpButton = false;
  int _currentNoticeIndex = 0;

  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        _onScroll();
        _scrollEnd();
      },
    );

    // 로그인 타입을 가져와서 로그인 상태를 적용한다.
    checkLoginType();

    // 이미 리스트안에 광고가 삽입되어 있으면 더이상 삽입하지 않음
    comunityList = checkAds(initComunityList);
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
    if (scrollController.offset > 260) {
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
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      setState(() {
        comunityList = [...comunityList] + checkAds(initComunityList);
      });
    }
  }

  void _alertIconTap() {
    context.pushNamed(AlertScreen.routeName);
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void _onLoginTap() {
    context.pushNamed(SignInMain.routeName);
  }

  // 스크롤 위치를 맨위로 이동시킵니다.
  void _scrollToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
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

  void onLogoutTap() {
    SecureStorageLogin.setLogout();
    context.pushReplacementNamed(
      MainNavigation.routeName,
      queryParams: {"initIndex": "2"},
    );
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.blue.shade100,
      floatingActionButton: Column(
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
          FloatingActionButton(
            heroTag: "comunity_edit",
            onPressed: () {},
            backgroundColor: Colors.blue.shade300,
            child: const FaIcon(
              FontAwesomeIcons.penToSquare,
              color: Colors.black,
            ),
          ),
        ],
      ),
      // CustomScrollView : 스크롤 가능한 구역
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // 스타일1
            // stops: [0.09, 0.6],
            // colors: [Colors.white, Color(0xFF4AA8D8)],
            // 스타일2
            stops: const [0.05, 0.5],
            colors: [Colors.white, Colors.lightGreen.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshComunityList,
          child: CustomScrollView(
            controller: scrollController,
            // CustomScrollView 안에 들어갈 element들
            // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
            slivers: [
              // SliverAppBar : slivers 안에 쓰는 AppBar와 비슷한 기능
              SliverAppBar(
                automaticallyImplyLeading: false,
                // pinned: true,
                floating: true,
                snap: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                ),
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
                      children: _isLogined
                          ? [
                              GestureDetector(
                                onTap: onLogoutTap,
                                child: const Icon(
                                  Icons.search,
                                  size: 38,
                                  color: Colors.black54,
                                ),
                              ),
                              Gaps.h2,
                              GestureDetector(
                                onTap: _alertIconTap,
                                child: const Icon(
                                  Icons.notifications_none,
                                  size: 38,
                                  color: Colors.black54,
                                ),
                              ),
                            ]
                          : [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.search,
                                  size: 38,
                                  color: Colors.black54,
                                ),
                              ),
                              Gaps.h10,
                              GestureDetector(
                                onTap: _onLoginTap,
                                child: const Icon(
                                  Icons.account_circle_outlined,
                                  size: 38,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                    ),
                  ),
                ],
              ),
              // SliverToBoxAdapter : sliver에서 일반 flutter 위젯을 사용할때 쓰는 위젯
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "공지",
                                style: TextStyle(
                                  fontSize: Sizes.size20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "더보기 >",
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: size.width,
                        //   height: 110,
                        //   child: ListView.separated(
                        //     // 가로로 스크롤
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 5,
                        //     itemBuilder: (context, index) => const NoticeBox(
                        //       title: "공지사항",
                        //       content: "공지사항의 내용입니다.",
                        //     ),
                        //     separatorBuilder: (context, index) => Gaps.h10,
                        //   ),
                        // ),
                        CarouselSlider.builder(
                          itemBuilder: (context, index, realIndex) =>
                              NoticeTestItem(
                            title: "공지사항 ${index + 1}",
                            content:
                                "이곳은 공지사항${index + 1} 입니다.\n자세히 읽어주세요.\n감사합니다.",
                          ),
                          itemCount: 5,
                          options: CarouselOptions(
                            aspectRatio: 10 / 4,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentNoticeIndex = index;
                              });
                            },
                            // 옵션 설정
                          ),
                          // 인디케이터 설정
                          carouselController: _carouselController,
                          // 페이지 변화 이벤트 등록
                        ),
                        CustomIndicator(
                          currentNoticeIndex: _currentNoticeIndex,
                          noticeItemLength: 5,
                        ),
                      ],
                    ),
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
                      return ClubComunityItemBox(
                        key: Key(item["title"]),
                        title: item["title"],
                        img: item["imgUrl"],
                        initCheckGood: item["checkGood"],
                        content: item["content"],
                        date: item["date"],
                        user: item["user"],
                        isLogined: _isLogined,
                        index: index,
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
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-1",
    "user": "유저1",
  },
  {
    "type": "default",
    "title": "제목2",
    "checkGood": false,
    "imgUrl": "",
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-2",
    "user": "유저2",
  },
  {
    "type": "default",
    "title": "제목3",
    "checkGood": false,
    "imgUrl": "assets/images/70836_50981_2758.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-3",
    "user": "유저3",
  },
  {
    "type": "default",
    "title": "제목4",
    "checkGood": true,
    "imgUrl": "",
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-4",
    "user": "유저4",
  },
  {
    "type": "default",
    "title": "제목5",
    "checkGood": false,
    "imgUrl": "assets/images/70836_50981_2758.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-5",
    "user": "유저5",
  },
  {
    "type": "default",
    "title": "제목6",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-6",
    "user": "유저6",
  },
  {
    "type": "default",
    "title": "제목7",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-7",
    "user": "유저7",
  },
  {
    "type": "default",
    "title": "제목8",
    "checkGood": true,
    "imgUrl": "",
    "content": "이곳은 내용만 있습니다.",
    "date": "2023-05-8",
    "user": "유저8",
  },
  {
    "type": "default",
    "id": 9,
    "title": "제목9",
    "checkGood": false,
    "imgUrl": "assets/images/70836_50981_2758.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-9",
    "user": "유저9",
  },
  {
    "type": "default",
    "id": 10,
    "title": "제목10",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용과 사진입니다.",
    "date": "2023-05-10",
    "user": "유저10",
  },
];
