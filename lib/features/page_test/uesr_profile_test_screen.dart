import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/main_navigation/mian_navigation.dart';
import 'package:swag_cross_app/features/page_test/widgets/persistent_tab_bar.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_setup.dart';
import 'package:swag_cross_app/features/user_profile/view/user_profile_card.dart';
import 'package:swag_cross_app/providers/UserProvider.dart';
import 'package:swag_cross_app/storages/login_storage.dart';

import 'package:http/http.dart' as http;

final List<Map<String, dynamic>> userDatas = [
  {
    "userDid": "1",
    "userId": "thdusrkd01@naver.com",
    "userPw": "000000",
    "userName": "강소연",
    "userDef": "hello!",
    "userType": "봉사자",
    "birth": "2001-09-28"
  },
];

class UserProfileTestScreen extends StatefulWidget {
  static const routeName = "user_profile";
  static const routeURL = "/user_profile";

  const UserProfileTestScreen({super.key});

  @override
  State<UserProfileTestScreen> createState() => _UserProfileTestScreenState();
}

class _UserProfileTestScreenState extends State<UserProfileTestScreen> {
  void onLogoutAllTap(BuildContext context) {
    LoginStorage.resetLoginData();
    context.read<UserProvider>().logout();
    context.pushReplacementNamed(MainNavigation.routeName);
  }

  void onLogoutTap(BuildContext context) {
    context.read<UserProvider>().logout();
    context.pushReplacementNamed(MainNavigation.routeName);
  }

  void _userSetupTap() {
    context.pushNamed(UserInformSetup.routeName);
  }

  void httpTest() async {
    try {
      final url =
          Uri.parse('http://58.150.133.91:8080/together/club/getAllClub');
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // 응답 처리
      if (response.statusCode == 200) {
        // 성공적인 응답 처리
      } else {
        // 응답 오류 처리
      }
    } catch (e) {
      // 예외 처리
      print('예외 발생: $e');
      // 예외에 따른 추가 처리 수행
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // CustomScrollView : 스크롤 가능한 구역
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          // NestedScrollView : SliverAppBar와 TabBar를 같이 쓰는 경우 처럼 여러개의 스크롤 함께쓸때 유용한 위젯
          child: NestedScrollView(
            // CustomScrollView 안에 들어갈 element들
            // 원하는걸 아무거나 넣을수는 없고 지정된 아이템만 넣을수 있음
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: const Text("내정보"),
                  // actions: [
                  //   IconButton(
                  //     onPressed: () {},
                  //     icon: const FaIcon(
                  //       FontAwesomeIcons.gear,
                  //       size: Sizes.size20,
                  //     ),
                  //   ),
                  // ],
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
                            onTap: _userSetupTap,
                            // () => onLogoutTap(context),
                            child: const Icon(Icons.settings_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      UserProfileCard(
                        userDid: userDatas[0]['userDid'],
                        userId: userDatas[0]['userId'],
                        userPw: userDatas[0]['userPw'],
                        userName: userDatas[0]['userName'],
                        userDef: userDatas[0]['userDef'],
                        userType: userDatas[0]['userType'],
                        birth: userDatas[0]['birth'],
                      ),
                      Gaps.v10,
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("봉사 신청"), Text("2건")],
                            ),
                          ),
                          Container(height: 50, width: 2, color: Colors.grey),
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("봉사 완료"), Text("6건")],
                            ),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gaps.h20,
                          Text(
                            "내가 올린 게시글",
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                    ],
                  ),
                ),
                // SliverPersistentHeader는 SliverToBoxAdapter안에서 선언할수 없음
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // 나와있는 키보드에서 스크롤하면 키보드를 없애는 기능
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  // controller는 아니지만 비슷한 도우미
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // 한 줄당 몇개를 넣을건지 지정
                    crossAxisCount: 3,
                    // 좌우 간격
                    crossAxisSpacing: Sizes.size2,
                    // 위아래 간격
                    mainAxisSpacing: Sizes.size2,
                    // 한 블럭당 비율 지정 (가로 / 세로)
                    childAspectRatio: 9 / 12,
                  ),
                  // FadeInImage : 실제 사진이 로드 되기 전까지 지정한 이미지를 보여줌
                  itemBuilder: (context, index) => LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 12,
                            child: index % 2 == 0
                                ? index % 3 == 0
                                    ? const FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            AssetImage("assets/images/dog.jpg"),
                                        image:
                                            AssetImage("assets/images/dog.jpg"),
                                      )
                                    : FadeInImage.assetNetwork(
                                        // 부모 요소에 맞춰서 크기 조절
                                        fit: BoxFit.cover,
                                        // 로딩 되기전에 보여줄 이미지 지정
                                        placeholder: "assets/images/dog.jpg",
                                        // 로딩 이미지 지정
                                        image:
                                            "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                      )
                                : const FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        AssetImage("assets/images/dog.jpg"),
                                    image: AssetImage(
                                        "assets/images/70836_50981_2758.jpg"),
                                  ),
                          ),
                          const Positioned(
                            bottom: Sizes.size10,
                            left: Sizes.size10,
                            child: Column(
                              children: [
                                Text(
                                  "제목",
                                  style: TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text("동아리에 올린 게시글"),
                ),
                const Center(
                  child: Text("좋아요한 게시글"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}