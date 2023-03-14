import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/alert/alert_screen.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_button.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_comunity_box.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_main.dart';
import 'package:swag_cross_app/features/storages/secure_storage_login.dart';
import 'package:swag_cross_app/features/main_page/widgets/main_notice_box.dart';

class MainPageSliver extends StatefulWidget {
  const MainPageSliver({super.key});

  @override
  State<MainPageSliver> createState() => _MainPageSliverState();
}

class _MainPageSliverState extends State<MainPageSliver>
    with SingleTickerProviderStateMixin {
  // 변수를 만들때 바로 초기화 해주어도 되지만 무조건 late를 붙여야 작동된다.
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final Animation<Offset> _alertAnimation = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController scrollController = ScrollController();

  bool _isLogined = false;
  bool _showAlert = false;
  bool _showJumpUpButton = false;
  final bool _checkGood = false;

  double width = 0;
  double height = 0;

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

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_onScroll);

    var loginType = SecureStorageLogin.getLoginType();
    if (loginType != "none") {
      _isLogined = true;
    }
  }

  void _toggleAlertAnimations() async {
    // 이미 애니메이션이 실행되었다면
    if (_animationController.isCompleted) {
      // 애니메이션을 원래상태로 되돌림
      // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
      await _animationController.reverse();
      _showAlert = false;
    } else {
      // 애니메이션을 실행
      _animationController.forward();
      _showAlert = true;
    }
    setState(() {});
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

  // 로그인 테스트1
  void _onTest1Tap() async {
    print(await SecureStorageLogin.getLoginType());
    _isLogined = true;
    setState(() {});
  }

  // 로그인 테스트2
  void _onTest2Tap() async {
    print(await SecureStorageLogin.getLoginType());
    SecureStorageLogin.saveLoginType("none");
    print(await SecureStorageLogin.getLoginType());
    _isLogined = false;
    setState(() {});
    // SecureStorageLogin.loginCheckIsNone(context, mounted);
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void onLoginTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignInMain(),
      ),
    );
  }

  // 로그인 상태일때 아이콘 클릭 하면 실행
  void onProfileTap() {
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

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
              // 줄일수 있는 최소 높이
              // collapsedHeight: 55,
              // 최대 높이
              // expandedHeight: 55,
              // 늘리고 줄였을때의 애니매이션을 적용하려면 floating, stretch을 true로 설정해야함
              // floating : 맨위가 아니라 중간에서 위로 스크롤해도 appBar가 나타남
              // floating: true,
              // snap : 아주 조금만 스크롤을 내려도 appBar 내려옴(floating과 같이 사용해야함)
              // snap: true,
              // stretch : stretchModes를 사용할 수 있는지 허가 여부 설정
              // stretch: true,
              // pinned : 최소 높이로 작아지면 고정됨(중요)
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
                              onTap: onProfileTap,
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
                              onTap: onLoginTap,
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
                (context, index) => MainComunityBox(
                  key: Key(comunityList[index]["title"]),
                  title: comunityList[index]["title"],
                  img: AssetImage(
                    comunityList[index]["imgUrl"],
                  ),
                  initCheckGood: comunityList[index]["checkGood"],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> comunityList = [
  {
    "title": "제목1",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목2",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목3",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목4",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목5",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목6",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목7",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "title": "제목8",
    "checkGood": true,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "id": 9,
    "title": "제목9",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
  {
    "id": 10,
    "title": "제목10",
    "checkGood": false,
    "imgUrl": "assets/images/dog.jpg",
  },
];
