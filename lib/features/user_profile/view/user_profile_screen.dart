import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/user_profile/widgets/persistent_tab_bar.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_setup.dart';
import 'package:swag_cross_app/features/user_profile/widgets/user_profile_card.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/providers/user_provider.dart';

// final List<Map<String, dynamic>> userDatas = [
//   {
//     "userId": "1",
//     "userEmail": "thdusrkd01@naver.com",
//     "userPw": "000000",
//     "userName": "강소연",
//     "userNickName": "망고012",
//     "userDef": "hello!",
//     "userGender": "여자",
//     "userType": "봉사자",
//     // "userProfileImage": "",
//     "userBirthDate": "2001-09-28",
//     "userPhoneNumber": "010-0000-0000",
//   },
// ];

// class UserProfileScreenArgs {
//   final int userId1;

//   UserProfileScreenArgs({required this.userId1});
// }

class UserProfileScreen extends StatefulWidget {
  // final int userId1;

  static const routeName = "user_profile";
  static const routeURL = "/user_profile";

  const UserProfileScreen({
    super.key,
    // required this.userId1,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _userSetupTap() {
    context.pushNamed(UserInformSetup.routeName);
  }

  List<PostCardModel>? _postListWithoutAds;

  // 스크롤 제어를 위한 컨트롤러를 선언합니다.

  Future<List<PostCardModel>> _postGetDispatch() async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getAllPostForMain");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("내 정보 : 성공");

      // 응답 데이터를 PostCardModel 리스트로 파싱하여 반환
      return jsonResponse
          .map<PostCardModel>((data) => PostCardModel.fromJson(data))
          .toList();
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("게시물 데이터를 불러오는데 실패하였습니다.");
    }
  }

  // 리스트 새로고침
  // Future _refreshComunityList() async {
  //   _postGetDispatch();
  //   setState(() {});
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>().userData;

    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
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
                        userData: userData,
                      ),
                      // Gaps.v10,
                      // Row(
                      //   children: [
                      //     const Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [Text("봉사 신청"), Text("2건")],
                      //       ),
                      //     ),
                      //     Container(height: 50, width: 2, color: Colors.grey),
                      //     const Expanded(
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [Text("봉사 완료"), Text("6건")],
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: FutureBuilder<List<PostCardModel>>(
                    // future: _postGetDispatch(),
                    future: _postListWithoutAds != null
                        ? Future.value(
                            _postListWithoutAds!) // _postList가 이미 가져온 상태라면 Future.value 사용
                        : _postGetDispatch(), // _postList가 null이라면 데이터를 가져오기 위해 호출
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('오류 발생: ${snapshot.error}'),
                        );
                      } else {
                        _postListWithoutAds =
                            snapshot.data!.where((item) => !item.isAd).toList();

                        return ListView.builder(
                          itemCount: _postListWithoutAds!.length,
                          itemBuilder: (context, index) => PostCard(
                            postData: _postListWithoutAds![index],
                          ),
                        );
                      }
                    },
                  ),
                ),
                const Center(
                  child: Text("동아리에 올린 게시글"),
                ),
                // const Center(
                //   child: Text("좋아요한 게시글"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
