// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/club/club_setting_screen.dart';
import 'package:swag_cross_app/features/community/posts/post_edit_screen.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';
import 'package:swag_cross_app/providers/club_post_provider.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';

class ClubCommunityScreenArgs {
  final ClubDataModel clubData;

  ClubCommunityScreenArgs({required this.clubData});
}

class ClubCommunityScreen extends StatefulWidget {
  final ClubDataModel clubData;

  const ClubCommunityScreen({
    super.key,
    required this.clubData,
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
  // final CarouselController _carouselController = CarouselController();
  // 검색 제어를 위한 컨트롤러
  final TextEditingController _searchController = TextEditingController();
  // 포커스 검사
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;
  bool _isSearched = false;
  bool _isFirstLoadRunning = false;
  final bool _isLoadMoreRunning = false;

  String? _searchText;

  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();

    _postGetDispatch();

    _focusNode.addListener(_handleFocusChange);

    _scrollController.addListener(
      () {
        // 검색 창이 내려와있을대 스크롤 하면 검색창 다시 사라짐
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
  }

  void _clubSettingTap() {
    context.pushNamed(
      ClubSettingScreen.routeName,
      extra: ClubSettingScreenArgs(clubData: widget.clubData),
    );
  }

  Future<void> _postGetDispatch() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    final userData = context.read<UserProvider>().userData;
    context.read<ClubPostProvider>().clubPostGetDispatch(
        userId: userData!.userId, clubId: widget.clubData.clubId);
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // 게시물 검색
  Future<void> _searchPostList() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    final userData = context.read<UserProvider>().userData;
    context.read<ClubPostProvider>().clubPostSearchDispatch(
          userId: userData!.userId,
          clubId: widget.clubData.clubId,
          keyword: _searchController.text,
        );
    if (context.read<ClubPostProvider>().clubPostList!.isNotEmpty) {
      setState(() {
        _isSearched = true;
        _searchText = _searchController.text;
        _focusNode.unfocus();
        _toggleAnimations();
      });
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // 리스트 새로고침
  Future<void> _refreshPostList() async {
    _postGetDispatch();
    _searchText = null;
    setState(() {});
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
    final clubPostList = context.watch<ClubPostProvider>().clubPostList;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text(widget.clubData.clubName),
        leadingWidth: 35,
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
                  onTap: _clubSettingTap,
                  child: const Icon(Icons.settings_outlined),
                  // child: const FaIcon(FontAwesomeIcons.penToSquare),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedOpacity(
            opacity: _animationController.isCompleted || isLogined ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: FloatingActionButton(
              heroTag: "club_community_edit",
              onPressed: () async {
                // 동아리 게시글 작성
                context.pushNamed(
                  PostEditScreen.routeName,
                  extra: PostEditScreenArgs(
                    pageTitle: "동아리 게시글 등록",
                    editType: PostEditType.clubInsert,
                    clubId: widget.clubData.clubId,
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
      body: Stack(
        children: [
          _isFirstLoadRunning
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : clubPostList!.isEmpty
                  ? const Center(
                      child: Text('게시물이 존재하지 않거나 통신에 실패했습니다!'),
                    )
                  : RefreshIndicator.adaptive(
                      onRefresh: _refreshPostList,
                      child: ListView.builder(
                        itemCount: clubPostList.length,
                        itemBuilder: (context, index) {
                          final item = clubPostList[index];
                          if (!item.isAd) {
                            return PostCard(
                              postData: item,
                              index: index,
                              isClub: true,
                              clubId: widget.clubData.clubId,
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
    );
  }
}
