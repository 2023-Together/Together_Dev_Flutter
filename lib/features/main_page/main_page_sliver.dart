import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_button.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_comunity_box.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_notice_box.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';

class MainPageSliver extends StatefulWidget {
  const MainPageSliver({super.key});

  @override
  State<MainPageSliver> createState() => _MainPageSliverState();
}

class _MainPageSliverState extends State<MainPageSliver> {
  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController scrollController = ScrollController();

  bool _isLogined = false;
  bool _showJumpUpButton = false;

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

  void _onScroll() {
    if (scrollController.offset > 310) {
      // 이미 true인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
      // 리턴처리 필요
      if (_showJumpUpButton) return;
      setState(() {
        _showJumpUpButton = true;
      });
    } else {
      // 이미 false인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
      // 리턴처리 필요
      if (_showJumpUpButton == false) return;
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlertScreen(),
      ),
    );
  }

  // 네비게이션 페이지로 이동하는 함수
  void _onNavigationPageMoveTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigation(initSelectedIndex: index),
      ),
    );
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void _onLoginTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInMain(),
      ),
    );
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

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: _showJumpUpButton ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: Colors.purpleAccent.shade100,
          child: const FaIcon(
            FontAwesomeIcons.arrowUp,
            color: Colors.black,
          ),
        ),
      ),
      // CustomScrollView : 스크롤 가능한 구역
      body: RefreshIndicator(
        onRefresh: _refreshComunityList,
        child: CustomScrollView(
          controller: scrollController,
          // CustomScrollView 안에 들어갈 element들
          // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
          slivers: [
            // SliverAppBar : slivers 안에 쓰는 AppBar와 비슷한 기능
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                    vertical: Sizes.size10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _isLogined
                        ? [
                            GestureDetector(
                              onTap: _alertIconTap,
                              child: const FaIcon(
                                FontAwesomeIcons.bell,
                                size: 40,
                                color: Colors.black54,
                              ),
                            ),
                            Gaps.h10,
                            GestureDetector(
                              onTap: () => _onNavigationPageMoveTap(4),
                              child: const CircleAvatar(
                                radius: Sizes.size20,
                                foregroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/77985708?v=4",
                                ),
                                child: Text("재현"),
                              ),
                            ),
                          ]
                        : [
                            GestureDetector(
                              onTap: _onLoginTap,
                              child: const FaIcon(
                                FontAwesomeIcons.circleUser,
                                size: 40,
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
                  horizontal: Sizes.size32,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size5,
                            vertical: Sizes.size5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            border: Border.all(
                              width: 1.5,
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MainNoticeBox(title: "공지사항1"),
                              MainNoticeBox(title: "공지사항2"),
                              MainNoticeBox(title: "공지사항3"),
                            ],
                          )),
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _onNavigationPageMoveTap(0),
                            child: const MainButton(text: "봉사 찾기"),
                          ),
                          GestureDetector(
                            onTap: () => _onNavigationPageMoveTap(2),
                            child: const MainButton(text: "커뮤니티"),
                          ),
                        ],
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
                    return MainComunityBox(
                      key: Key(item["title"]),
                      title: item["title"],
                      img: item["imgUrl"],
                      initCheckGood: item["checkGood"],
                      content: item["content"],
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
                            size: AdSize.banner,
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
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목2",
    "checkGood": false,
    "imgUrl": "",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목3",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목4",
    "checkGood": true,
    "imgUrl": "",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목5",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목6",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목7",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "title": "제목8",
    "checkGood": true,
    "imgUrl": "",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "id": 9,
    "title": "제목9",
    "checkGood": false,
    "imgUrl": "",
    "content": "이것은 내용입니다.",
  },
  {
    "type": "default",
    "id": 10,
    "title": "제목10",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
    "content": "이것은 내용입니다.",
  },
];