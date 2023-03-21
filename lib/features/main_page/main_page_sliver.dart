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

List<Map<String, dynamic>> comunityList = [
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

class _MainPageSliverState extends State<MainPageSliver> {
  // 광고 테스트 아이디 생성
  final String iOSTestUnitId = "ca-app-pub-8792702490232026/5244633336";
  final String androidTestUnitId = "ca-app-pub-8792702490232026/3602332882";

  List<Widget> itemList = [];

  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController scrollController = ScrollController();

  bool _isLogined = false;
  bool _showJumpUpButton = false;

  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);

    var loginType = SecureStorageLogin.getLoginType();
    if (loginType != "none") {
      _isLogined = true;
    }
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

  void _alertIconTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlertScreen(),
      ),
    );
  }

  // 봉사 찾기 누르면 작동
  void _onVolSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 0),
      ),
    );
  }

  // 커뮤니티 누르면 작동
  void _onCommunityTap() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 2),
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

  // 로그인 상태일때 아이콘 클릭 하면 실행
  void _onProfileTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MainNavigation(initSelectedIndex: 4),
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

  // 페이지 새로고침
  Future _refreshComunityList() async {
    setState(() {
      comunityList = [...comunityList];
    });
  }

  // 광고 로딩 실패일때 실행
  void failedAdsLoading(Ad ad, LoadAdError error) {
    ad.dispose();
    print("광고 로딩에 실패! 사유 : ${error.message}, ${error.code}");
  }

  @override
  void didChangeDependencies() {
    // 리스트 사이에 광고 넣기
    for (int i = comunityList.length; i >= 1; i -= 5) {
      comunityList.insert(i, {"type": "ad"});
    }
    super.didChangeDependencies();
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
                              onTap: _onProfileTap,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
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
                            onTap: _onVolSearchTap,
                            child: const MainButton(text: "봉사 찾기"),
                          ),
                          GestureDetector(
                            onTap: _onCommunityTap,
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
