// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:swag_cross_app/constants/gaps.dart';
// import 'package:swag_cross_app/constants/sizes.dart';
// import 'package:swag_cross_app/features/alert/alert_screen.dart';
// import 'package:swag_cross_app/features/community/widgets/post_card.dart';
// import 'package:swag_cross_app/features/community/posts/post_write_screen.dart';
// import 'package:swag_cross_app/features/widget_tools/swag_custom_indicator.dart';
// import 'package:swag_cross_app/features/widget_tools/swag_textfield.dart';
// import 'package:swag_cross_app/storages/secure_storage_login.dart';
// import 'package:swag_cross_app/utils/ad_helper.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class ClubComunityTestScreen extends StatefulWidget {
//   const ClubComunityTestScreen({super.key});

//   @override
//   State<ClubComunityTestScreen> createState() => _ClubComunityTestScreenState();
// }

// class _ClubComunityTestScreenState extends State<ClubComunityTestScreen>
//     with SingleTickerProviderStateMixin {
//   // 검색 애니메이션 컨트롤러 선언
//   late final AnimationController _animationController = AnimationController(
//     vsync: this,
//     duration: const Duration(milliseconds: 300),
//   );

//   late final Animation<Offset> _panelAnimation = Tween(
//     begin: const Offset(0, -1),
//     end: const Offset(0, 0.6),
//   ).animate(_animationController);

//   late final Animation<Color?> _barrierAnimation = ColorTween(
//     begin: Colors.transparent,
//     end: Colors.black38,
//   ).animate(_animationController);

//   // 스크롤 제어를 위한 컨트롤러를 선언합니다.
//   final ScrollController _scrollController = ScrollController();
//   // 공지사항 스크롤 제어를 위한 컨트롤러
//   final CarouselController _carouselController = CarouselController();
//   // 검색 제어를 위한 컨트롤러
//   final TextEditingController _searchController = TextEditingController();

//   bool _isLogined = false;
//   bool _showJumpUpButton = false;
//   int _currentNoticeIndex = 0;

//   double width = 0;
//   double height = 0;

//   bool _showBarrier = false;

//   @override
//   void initState() {
//     super.initState();

//     _scrollController.addListener(
//       () {
//         _onScroll();
//         _scrollEnd();
//       },
//     );

//     // 로그인 타입을 가져와서 로그인 상태를 적용한다.
//     checkLoginType();

//     // 이미 리스트안에 광고가 삽입되어 있으면 더이상 삽입하지 않음
//     comunityList = checkAds(initComunityList);
//   }

//   // 로그인 타입을 가져와서 로그인 상태를 적용하는 함수
//   void checkLoginType() async {
//     var loginType = await SecureStorageLogin.getLoginType();
//     print(loginType);
//     if (loginType == "naver" || loginType == "kakao") {
//       _isLogined = true;
//     } else {
//       _isLogined = false;
//     }
//     setState(() {});
//   }

//   // 이미 리스트안에 광고가 삽입되어 있으면 더이상 삽입하지 않는 함수
//   List<Map<String, dynamic>> checkAds(List<Map<String, dynamic>> list) {
//     if (!list.any((item) => item["type"] == "ad")) {
//       // 리스트 사이에 광고 넣기
//       for (int i = initComunityList.length; i >= 1; i -= 5) {
//         list.insert(i, {"type": "ad"});
//       }
//     }
//     return list;
//   }

//   // 스크롤 할때마다 호출
//   void _onScroll() {
//     if (_scrollController.offset > 260) {
//       // 이미 true인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
//       // 리턴처리 필요
//       if (_showJumpUpButton) return;
//       setState(() {
//         _showJumpUpButton = true;
//       });
//     } else {
//       // 이미 false인데도 매번 스크롤 할때마다 setState를 호출하면 작업이 너무 많아지기 때문에
//       // 리턴처리 필요
//       if (!_showJumpUpButton) return;
//       setState(() {
//         _showJumpUpButton = false;
//       });
//     }
//   }

//   void _scrollEnd() {
//     if (_scrollController.offset ==
//         _scrollController.position.maxScrollExtent) {
//       setState(() {
//         comunityList = [...comunityList] + checkAds(initComunityList);
//       });
//     }
//   }

//   void _alertIconTap() {
//     context.pushNamed(AlertScreen.routeName);
//   }

//   // 스크롤 위치를 맨위로 이동시킵니다.
//   void _scrollToTop() {
//     _scrollController.animateTo(
//       _scrollController.position.minScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   // 리스트 새로고침
//   Future _refreshComunityList() async {
//     setState(() {
//       comunityList = checkAds(initComunityList);
//     });
//   }

//   // 광고 로딩 실패일때 실행
//   void failedAdsLoading(Ad ad, LoadAdError error) {
//     ad.dispose();
//     print("광고 로딩에 실패! 사유 : ${error.message}, ${error.code}");
//   }

//   // 애니메이션 동작
//   void _toggleAnimations() async {
//     // 이미 애니메이션이 실행되었다면
//     if (_animationController.isCompleted) {
//       // 애니메이션을 원래상태로 되돌림
//       // 슬라이드가 다올라갈때까지 배리어를 없애면 안됨
//       await _animationController.reverse();
//       _showBarrier = false;
//     } else {
//       // 애니메이션을 실행
//       _animationController.forward();
//       _showBarrier = true;
//     }
//     FocusScope.of(context).unfocus();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _animationController.dispose();
//     _searchController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       // backgroundColor: Colors.blue.shade100,
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Gaps.v6,
//           FloatingActionButton(
//             heroTag: "club_community_edit",
//             onPressed: () {
//               // 동아리 게시글 작성
//               context.pushNamed(PostWriteScreen.routeName);
//             },
//             backgroundColor: Colors.blue.shade300,
//             child: const FaIcon(
//               FontAwesomeIcons.penToSquare,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       // CustomScrollView : 스크롤 가능한 구역
//       body: Stack(
//         children: [
//           // 메인 화면
//           RefreshIndicator(
//             onRefresh: _refreshComunityList,
//             child: CustomScrollView(
//               controller: _scrollController,
//               // CustomScrollView 안에 들어갈 element들
//               // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
//               slivers: [
//                 // SliverAppBar : slivers 안에 쓰는 AppBar와 비슷한 기능
//                 SliverAppBar(
//                   automaticallyImplyLeading: true,
//                   // pinned: true,
//                   floating: true,
//                   snap: true,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.vertical(
//                       bottom: Radius.circular(20.0),
//                     ),
//                   ),
//                   centerTitle: false,
//                   title: const Text("SWAG 동아리(10명)"),
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: Sizes.size14,
//                         vertical: Sizes.size10,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           GestureDetector(
//                             onTap: _toggleAnimations,
//                             child: const Icon(Icons.search),
//                             // child: const FaIcon(FontAwesomeIcons.magnifyingGlass),
//                           ),
//                           Gaps.h2,
//                           GestureDetector(
//                             onTap: () {},
//                             child: const Icon(Icons.edit_note_rounded),
//                             // child: const FaIcon(FontAwesomeIcons.penToSquare),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SliverToBoxAdapter : sliver에서 일반 flutter 위젯을 사용할때 쓰는 위젯
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: Sizes.size10,
//                       horizontal: Sizes.size20,
//                     ),
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             "assets/images/volImg.jpg",
//                             width: size.width,
//                             height: 160,
//                             fit: BoxFit.cover,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: Sizes.size10,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "공지",
//                                   style: TextStyle(
//                                     fontSize: Sizes.size20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   "더보기 >",
//                                   style: TextStyle(
//                                     fontSize: Sizes.size16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.grey.shade500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           CarouselSlider.builder(
//                             itemBuilder: (context, index, realIndex) =>
//                                 NoticeTestItem(
//                               title: "공지사항 ${index + 1}",
//                               content:
//                                   "이곳은 공지사항${index + 1} 입니다.\n자세히 읽어주세요.\n감사합니다.",
//                             ),
//                             itemCount: 5,
//                             options: CarouselOptions(
//                               aspectRatio: 10 / 4,
//                               enlargeCenterPage: true,
//                               onPageChanged: (index, reason) {
//                                 setState(() {
//                                   _currentNoticeIndex = index;
//                                 });
//                               },
//                               // 옵션 설정
//                             ),
//                             // 인디케이터 설정
//                             carouselController: _carouselController,
//                             // 페이지 변화 이벤트 등록
//                           ),
//                           SWAGCustomIndicator(
//                             currentNoticeIndex: _currentNoticeIndex,
//                             noticeItemLength: 5,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // SliverFixedExtentList : item들의 리스트를 만들어 냄
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     childCount: comunityList.length,
//                     (context, index) {
//                       final item = comunityList[index];
//                       if (item["type"] != "ad") {
//                         return PostCard(
//                           key: Key(item["title"]),
//                           title: item["title"],
//                           images: List<String>.from(item["imgUrl"]),
//                           initCheckGood: item["checkGood"],
//                           content: item["content"],
//                           date: item["date"],
//                           user: item["user"],
//                           isLogined: _isLogined,
//                           index: index,
//                         );
//                       } else {
//                         return StatefulBuilder(
//                           builder: (context, setState) => Container(
//                             height: 50,
//                             alignment: Alignment.center,
//                             child: AdWidget(
//                               ad: BannerAd(
//                                 listener: BannerAdListener(
//                                   onAdFailedToLoad: failedAdsLoading,
//                                   onAdLoaded: (_) {},
//                                 ),
//                                 size: AdSize.fullBanner,
//                                 adUnitId: AdHelper.bannerAdUnitId,
//                                 request: const AdRequest(),
//                               )..load(),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_showBarrier)
//             // 슬라이드 화면 뒤쪽의 검은 화면 구현
//             AnimatedModalBarrier(
//               color: _barrierAnimation,
//               // 자신을 클릭하면 onDismiss를 실행하는지에 대한 여부
//               dismissible: true,
//               // 자신을 클릭하면 실행되는 함수
//               onDismiss: _toggleAnimations,
//             ),
//           // 검색 화면
//           SlideTransition(
//             position: _panelAnimation,
//             child: Container(
//               color: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
//               child: SWAGTextField(
//                 hintText: "검색할 제목을 입력해 주세요..",
//                 maxLine: 1,
//                 controller: _searchController,
//                 onSubmitted: () {
//                   print(_searchController.text);
//                 },
//                 buttonText: "검색",
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> comunityList = [];

// List<Map<String, dynamic>> initComunityList = [
//   {
//     "type": "default",
//     "title": "제목1",
//     "checkGood": true,
//     "imgUrl": [
//       "assets/images/dog.jpg",
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/dog.jpg",
//       "assets/images/dog.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-1",
//     "user": "유저1",
//   },
//   {
//     "type": "default",
//     "title": "제목2",
//     "checkGood": false,
//     "imgUrl": [],
//     "content": "이곳은 내용만 있습니다.",
//     "date": "2023-05-2",
//     "user": "유저2",
//   },
//   {
//     "type": "default",
//     "title": "제목3",
//     "checkGood": false,
//     "imgUrl": [
//       "assets/images/70836_50981_2758.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-3",
//     "user": "유저3",
//   },
//   {
//     "type": "default",
//     "title": "제목4",
//     "checkGood": true,
//     "imgUrl": [],
//     "content": "이곳은 내용만 있습니다.",
//     "date": "2023-05-4",
//     "user": "유저4",
//   },
//   {
//     "type": "default",
//     "title": "제목5",
//     "checkGood": false,
//     "imgUrl": [
//       "assets/images/dog.jpg",
//       "assets/images/70836_50981_2758.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-5",
//     "user": "유저5",
//   },
//   {
//     "type": "default",
//     "title": "제목6",
//     "checkGood": false,
//     "imgUrl": [
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/dog.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-6",
//     "user": "유저6",
//   },
//   {
//     "type": "default",
//     "title": "제목7",
//     "checkGood": true,
//     "imgUrl": [
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/dog.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-7",
//     "user": "유저7",
//   },
//   {
//     "type": "default",
//     "title": "제목8",
//     "checkGood": true,
//     "imgUrl": [],
//     "content": "이곳은 내용만 있습니다.",
//     "date": "2023-05-8",
//     "user": "유저8",
//   },
//   {
//     "type": "default",
//     "id": 9,
//     "title": "제목9",
//     "checkGood": false,
//     "imgUrl": [
//       "assets/images/dog.jpg",
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/70836_50981_2758.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-9",
//     "user": "유저9",
//   },
//   {
//     "type": "default",
//     "id": 10,
//     "title": "제목10",
//     "checkGood": false,
//     "imgUrl": [
//       "assets/images/70836_50981_2758.jpg",
//       "assets/images/dog.jpg",
//       "assets/images/70836_50981_2758.jpg",
//     ],
//     "content": "이것은 내용과 사진입니다.",
//     "date": "2023-05-10",
//     "user": "유저10",
//   },
// ];