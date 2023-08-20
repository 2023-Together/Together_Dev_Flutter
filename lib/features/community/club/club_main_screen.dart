import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/community/club/club_make_screen.dart';
import 'package:swag_cross_app/features/search_page/view/club_search_screen.dart';
import 'package:swag_cross_app/models/DBModels/club_data_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ClubMainScreen extends StatefulWidget {
  const ClubMainScreen({super.key});

  @override
  State<ClubMainScreen> createState() => _ClubMainScreenState();
}

class _ClubMainScreenState extends State<ClubMainScreen> {
  List<ClubDataModel>? _clubList;

  @override
  void initState() {
    super.initState();
  }

  Future<List<ClubDataModel>> _clubGetDispatch() async {
    final userData = context.read<UserProvider>().userData;
    final url =
        Uri.parse("http://58.150.133.91:80/together/club/getAffiliatedClub");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "userId": userData?.userId,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("동아리 리스트 : 성공");

      final clubList =
          jsonResponse.map((data) => ClubDataModel.fromJson(data)).toList();

      return clubList;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("게시물 데이터를 불러오는데 실패하였습니다.");
    }
  }

  void _onMoveClubSearchScreen(BuildContext context) {
    context.pushNamed(ClubSearchScreen.routeName);
  }

  void _onMoveClubCommunityScreen(
      BuildContext context, ClubDataModel clubData) {
    context.pushNamed(
      ClubCommunityScreen.routeName,
      extra: ClubCommunityScreenArgs(clubData: clubData),
    );
  }

  // 리스트 새로고침
  Future _refreshClubList() async {
    _clubList = await _clubGetDispatch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text("내 동아리"),
        actions: [
          IconButton(
            onPressed: () => _onMoveClubSearchScreen(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(ClubMakeScreen.routeName),
        backgroundColor: Colors.blue.shade300,
        child: const FaIcon(
          FontAwesomeIcons.penToSquare,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<List<ClubDataModel>>(
        future: _clubList != null
            ? Future.value(_clubList!) // _postList가 이미 가져온 상태라면 Future.value 사용
            : _clubGetDispatch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터를 기다리는 동안 로딩 인디케이터 표시
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // 에러가 발생한 경우 에러 메시지 표시
            return Center(
              child: Text('오류 발생: ${snapshot.error}'),
            );
          } else {
            // 데이터를 성공적으로 가져왔을 때 ListView 표시
            _clubList = snapshot.data!;

            return _clubList!.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          color: Colors.grey.shade300,
                          iconSize: MediaQuery.of(context).size.width / 2,
                          onPressed: _refreshClubList,
                          icon: const Icon(Icons.refresh),
                        ),
                        Gaps.v20,
                        Text(
                          "사용자가 소속되어 있는 동아리가 존재하지 않습니다!\n 상단의 '+'버튼을 눌러 동아리에 가입해주세요!",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator.adaptive(
                    onRefresh: _refreshClubList,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      itemBuilder: (context, index) {
                        final item = _clubList![index];
                        return ListTile(
                          onTap: () =>
                              _onMoveClubCommunityScreen(context, item),
                          title: Text(
                            item.clubName,
                          ),
                          subtitle: Text(
                            item.clubDescription ?? "",
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // 원하는 모양의 border radius 설정
                            side: const BorderSide(
                                color: Colors.black,
                                width: 0.5), // border의 색상과 너비 설정
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: _clubList!.length,
                    ),
                  );
          }
        },
      ),
    );
  }
}

// List<Map<String, dynamic>> clubList = [];

// List<Map<String, dynamic>> clubList = [
//   {
//     "clubName": "의료 동아리",
//     "clubPeopleLength": 16,
//     "clubManagerName": "동아리장1",
//     "clubContent": "이 동아리는 의료에 관한 활동을 하는 동아리입니다.",
//   },
//   {
//     "clubName": "행사 동아리",
//     "clubPeopleLength": 30,
//     "clubManagerName": "동아리장2",
//     "clubContent": "이 동아리는 행사에 관한 활동을 하는 동아리입니다.",
//   },
// ];