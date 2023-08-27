import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/constants/http_ip.dart';
import 'package:swag_cross_app/constants/sizes.dart';
import 'package:swag_cross_app/features/community/widgets/post_card.dart';
import 'package:swag_cross_app/features/user_profile/widgets/persistent_tab_bar.dart';
import 'package:swag_cross_app/features/user_profile/view/user_inform_setup.dart';
import 'package:swag_cross_app/features/user_profile/widgets/user_profile_card.dart';
import 'package:swag_cross_app/models/DBModels/user_model.dart';
import 'package:swag_cross_app/models/post_card_model.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/providers/user_provider.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = "user_profile";
  static const routeURL = "/user_profile";

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late TextEditingController _defController;

  late UserModel? _userData;

  Future<List<PostCardModel>>? _mainPostFuture;
  Future<List<PostCardModel>>? _clubPostFuture;

  @override
  void initState() {
    super.initState();

    _userData = context.read<UserProvider>().userData!;

    _defController = TextEditingController(text: _userData!.userDef ?? "");

    _mainPostFuture = _userPostMainDispatch();
    _clubPostFuture = _userPostClubDispatch();
  }

  Future<List<PostCardModel>> _userPostMainDispatch() async {
    final userData = context.read<UserProvider>().userData;

    final url =
        Uri.parse("${HttpIp.communityUrl}/together/post/getPostsByUserId");
    final headers = {'Content-Type': 'application/json'}; // 헤더에 Content-Type 추가

    final data = {
      "userId": userData!.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("내 게시물 불러오기 : 성공");

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

  // 동아리 게시글 통신
  Future<List<PostCardModel>> _userPostClubDispatch() async {
    final userData = context.read<UserProvider>().userData;

    final url = Uri.parse(
        "${HttpIp.communityUrl}/together/post/getClubPostCreatedByUser");
    final headers = {'Content-Type': 'application/json'}; // 헤더에 Content-Type 추가
    final data = {
      "userId": userData!.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("동아리 정보 : 성공");

      // 응답 데이터를 PostCardModel 리스트로 파싱하여 변환
      return jsonResponse
          .map<PostCardModel>((data) => PostCardModel.fromJson(data))
          .toList();
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("동아리 게시물 데이터를 불러오는데 실패하였습니다.");
    }
  }

  void _onUpdateDef() async {
    final userData = context.read<UserProvider>().userData;
    final url = Uri.parse("${HttpIp.userUrl}/together/updateUserDef");
    final headers = {'Content-Type': 'application/json'}; // 헤더에 Content-Type 추가
    final data = {
      "userId": userData!.userId.toString(),
      "userDef": _defController.text,
    };

    final response = await http.post(url, body: data); // 헤더와 JSON 문자열 전송

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("설명 수정 : 성공");
      context.read<UserProvider>().updateUserDef(_defController.text);
    } else {
      print("수정 에러!");
      print(response.statusCode);
      print(response.body);
    }
  }

  void _userSetupTap() {
    context.pushNamed(UserInformSetup.routeName);
  }

  // 리스트 새로고침
  Future _onRefreshMainPostList() async {
    _mainPostFuture = _userPostMainDispatch();

    setState(() {});
  }

  // 리스트 새로고침
  Future _onRefreshClubPostList() async {
    _clubPostFuture = _userPostClubDispatch();

    setState(() {});
  }

  @override
  void dispose() {
    _defController.dispose();

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
                      Gaps.v10,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gaps.h20,
                          Text(
                            "상태 메세지",
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.all(
                            Sizes.size12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Sizes.size8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _userData!.userDef ?? "",
                                maxLines: 5,
                                overflow: TextOverflow
                                    .ellipsis, // 변경: 3줄을 초과할 경우 ...으로 표시
                                style: const TextStyle(
                                  fontSize: Sizes.size16,
                                ),
                              ),
                              Gaps.h5,
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("상태 메세지 수정"),
                                        content: TextField(
                                          controller: _defController,
                                          maxLines: 5,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("취소"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _onUpdateDef();
                                              context.pop();
                                              setState(() {});
                                            },
                                            child: const Text("저장"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Gaps.v20,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Gaps.h10,
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
                  floating: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                // 커뮤니티 게시글
                FutureBuilder<List<PostCardModel>>(
                  future: _mainPostFuture, // _postList가 null이라면 데이터를 가져오기 위해 호출
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
                      final mainPostList = snapshot.data!;

                      if (mainPostList.isEmpty) {
                        return const Center(
                          child: Text("작성한 게시글이 없습니다."),
                        );
                      }

                      return RefreshIndicator.adaptive(
                        onRefresh: _onRefreshMainPostList,
                        child: ListView.builder(
                          itemCount: mainPostList.length,
                          itemBuilder: (context, index) => PostCard(
                            postData: mainPostList[index],
                            index: index,
                          ),
                        ),
                      );
                    }
                  },
                ),

                // 동아리 게시글
                FutureBuilder<List<PostCardModel>>(
                  future: _clubPostFuture, // _postList가 null이라면 데이터를 가져오기 위해 호출
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
                      final clubPostList = snapshot.data!;

                      if (clubPostList.isEmpty) {
                        return const Center(
                          child: Text("작성한 게시글이 없습니다."),
                        );
                      }

                      return RefreshIndicator.adaptive(
                        onRefresh: _onRefreshClubPostList,
                        child: ListView.builder(
                          itemCount: clubPostList.length,
                          itemBuilder: (context, index) => PostCard(
                            postData: clubPostList[index],
                            index: index,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
