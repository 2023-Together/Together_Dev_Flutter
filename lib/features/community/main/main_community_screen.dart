import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/notice/notice_screen.dart';
import 'package:swag_cross_app/features/sign_in_up/sign_in_screen.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/providers/main_post_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:swag_cross_app/utils/ad_helper.dart';
import 'package:swag_cross_app/utils/time_parse.dart';

class MainCommunityScreen extends StatefulWidget {
  const MainCommunityScreen({Key? key}) : super(key: key);

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
  bool _isFirstLoadRunning = true;
  final bool _isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();

    _postGetDispatch();

    _focusNode.addListener(_handleFocusChange);

    _scrollController.addListener(
      () {
        // _scrollEnd();
        // 검색 창이 내려와있을때 스크롤 하면 검색창 다시 사라짐
        if (_animationController.isCompleted) {
          _toggleAnimations();
        }
      },
    );
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void _onLoginTap() {
    context.pushNamed(SignInScreen.routeName);
  }

  // 리스트 새로고침
  Future<void> _refreshPostList() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    final userData = context.read<UserProvider>().userData;
    await context
        .read<MainPostProvider>()
        .refreshMainPostDispatch(userId: userData?.userId);
    setState(() {
      _isFirstLoadRunning = false;
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

  // 게시물 로딩
  Future<void> _postGetDispatch() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final userData = context.read<UserProvider>().userData;
      await context
          .read<MainPostProvider>()
          .mainPostGetDispatch(userId: userData?.userId);
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

  // 게시물 검색
  Future<void> _searchPostList() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    final userData = context.read<UserProvider>().userData;
    await context.read<MainPostProvider>().mainPostSearchDispatch(
          userId: userData?.userId,
          keyword: _searchController.text,
        );
    if (context.read<MainPostProvider>().postList!.isNotEmpty) {
      setState(() {
        _focusNode.unfocus();
        _toggleAnimations();
      });
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // Future<void> _scrollEnd() async {
  //   // 스크롤이 맨 아래로 내려가면 실행됨
  //   if (_scrollController.position.extentAfter < 100 &&
  //       !_isLoadMoreRunning &&
  //       !_isFirstLoadRunning) {
  //     setState(() {
  //       _isLoadMoreRunning = true;
  //     });

  //     final userData = context.read<UserProvider>().userData;
  //     context
  //         .read<MainPostProvider>()
  //         .scrollEndAddPostDispatch(userId: userData?.userId);

  //     setState(() {
  //       _isLoadMoreRunning = false;
  //     });
  //   }
  // }

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
    final mainPostList = context.watch<MainPostProvider>().postList;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          child: AnimatedOpacity(
            opacity: _animationController.isCompleted || isLogined ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              heroTag: "community_edit",
              onPressed: () {
                // 커뮤니티 게시글 작성
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
        ),
        // CustomScrollView : 스크롤 가능한 구역
        body: Stack(
          children: [
            _isFirstLoadRunning
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : mainPostList!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton.filled(
                              color: Colors.grey.shade300,
                              iconSize: MediaQuery.of(context).size.width / 2,
                              onPressed: _refreshPostList,
                              icon: const Icon(Icons.refresh),
                            ),
                            const Text('게시물 정보를 불러오는데 실패하였습니다.'),
                          ],
                        ),
                      )
                    : RefreshIndicator.adaptive(
                        onRefresh: _refreshPostList,
                        child: CustomScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          // CustomScrollView 안에 들어갈 element들
                          // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
                          slivers: [
                            SliverToBoxAdapter(
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
                                subtitle: Text(
                                  "최근 등록일 : ${TimeParse.getTimeAgo(context.watch<MainPostProvider>().noticeLastDate!)}",
                                  maxLines: 1,
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                ),
                              ),
                            ),
                            SliverList.builder(
                              itemCount: mainPostList.length,
                              itemBuilder: (context, index) {
                                final item = mainPostList[index];
                                if (!item.isAd) {
                                  return PostCard(
                                    postData: item,
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
                                            onAdClosed: (ad) => ad.dispose(),
                                          ),
                                          size: AdSize.fullBanner,
                                          adUnitId: AdHelper.bannerAdUnitIdTest,
                                          request: const AdRequest(),
                                        )..load(),
                                      ),
                                    ),
                                  );
                                }
                              },
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
                    onSubmitted: _searchPostList,
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
