import 'dart:async';
import 'dart:convert';

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
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:swag_cross_app/utils/ad_helper.dart';

import 'package:http/http.dart' as http;

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
  // final bool _showJumpUpButton = false;

  List<PostCardModel>? _postList;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_handleFocusChange);

    // 스크롤 이벤트 처리
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

  // 로그인 상태가 아닐때 아이콘 클릭 하면 실행
  void _onLoginTap() {
    context.pushNamed(SignInScreen.routeName);
  }

  // 리스트 새로고침
  Future<void> _refreshComunityList() async {
    _postGetDispatch();
    setState(() {});
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

  Future<List<PostCardModel>> _postGetDispatch() async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getAllPostForMain");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print(jsonResponse);

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      _postList =
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList();

      return await _insertAds(_postList!, 5);
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("동아리 데이터를 불러오는데 실패하였습니다.");
    }
  }

  // 리스트에 광고 삽입하는 함수
  Future<List<PostCardModel>> _insertAds(
      List<PostCardModel> originalList, int adInterval) async {
    List<PostCardModel> resultList = [];

    for (int i = 0; i < originalList.length; i++) {
      // 광고를 삽입할 위치인지 확인
      if (i > 0 && i % adInterval == 0) {
        // 광고를 삽입할 위치라면 광고 모델을 생성하여 리스트에 추가
        resultList.add(_createAdModel());
      }

      // 원본 리스트의 요소를 리스트에 추가
      resultList.add(originalList[i]);
    }

    return resultList;
  }

  // 가상의 광고 모델 생성 함수
  PostCardModel _createAdModel() {
    // 광고 모델을 생성하여 반환하는 로직 구현
    // 여기서는 가상의 광고 모델을 생성하여 반환하도록 가정
    // 필요에 따라 광고 모델을 별도로 정의하고 초기화해야 합니다.
    return PostCardModel(
      postId: 0,
      postBoardId: 0,
      postUserId: 0,
      userName: "",
      postTitle: "",
      postContent: "",
      postTag: [],
      postCreationDate: DateTime.now(),
      postLikeCount: 0,
      postCommentCount: 0,
      isAd: true,
    );
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
            FutureBuilder<List<PostCardModel>>(
              future: _postGetDispatch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 기다리는 동안 로딩 인디케이터 표시
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우 에러 메시지 표시
                  if (snapshot.error is TimeoutException) {
                    return const Center(
                      child: Text('통신 연결 실패!'),
                    );
                  } else {
                    return Center(
                      child: Text('오류 발생: ${snapshot.error}'),
                    );
                  }
                } else {
                  // 데이터를 성공적으로 가져왔을 때 ListView 표시
                  _postList = snapshot.data!;

                  return RefreshIndicator.adaptive(
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
                            childCount: _postList!.length,
                            (context, index) {
                              final item = _postList![index];
                              if (!item.isAd) {
                                return PostCard(
                                  postData: item,
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
                  );
                }
              },
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
