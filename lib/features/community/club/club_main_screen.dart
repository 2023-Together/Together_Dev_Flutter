import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/community/club/club_comunity_screen.dart';
import 'package:swag_cross_app/features/community/club/club_search_screen.dart';

class ClubMainScreen extends StatefulWidget {
  const ClubMainScreen({super.key});

  @override
  State<ClubMainScreen> createState() => _ClubMainScreenState();
}

class _ClubMainScreenState extends State<ClubMainScreen> {
  void _onMoveClubSearchScreen(BuildContext context) {
    context.pushNamed(ClubSearchScreen.routeName);
  }

  void _onMoveClubCommunityScreen(BuildContext context) {
    context.pushNamed(
      ClubCommunityScreen.routeName,
      extra: ClubCommunityScreenArgs(clubId: 1),
    );
  }

  // 리스트 새로고침
  Future _refreshClubList() async {
    setState(() {
      clubList = clubList;
    });
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
      body: clubList.isEmpty
          ? const Center(
              child: Text(
                "사용자가 소속되어 있는 동아리가 존재하지 않습니다!\n 상단의 '+'버튼을 눌러 동아리에 신청해주세요!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            )
          : RefreshIndicator.adaptive(
              onRefresh: _refreshClubList,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 6,
                ),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => _onMoveClubCommunityScreen(context),
                  title: Text(
                    clubList[index]["clubName"],
                  ),
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: Text(
                    clubList[index]["clubContent"] * 4,
                  ),
                  subtitleTextStyle: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // 원하는 모양의 border radius 설정
                    side: const BorderSide(
                        color: Colors.black, width: 0.5), // border의 색상과 너비 설정
                  ),
                ),
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: clubList.length,
              ),
            ),
    );
  }
}

// List<Map<String, dynamic>> clubList = [];

List<Map<String, dynamic>> clubList = [
  {
    "clubName": "의료 동아리",
    "clubPeopleLength": 16,
    "clubManagerName": "동아리장1",
    "clubContent": "이 동아리는 의료에 관한 활동을 하는 동아리입니다.",
  },
  {
    "clubName": "행사 동아리",
    "clubPeopleLength": 30,
    "clubManagerName": "동아리장2",
    "clubContent": "이 동아리는 행사에 관한 활동을 하는 동아리입니다.",
  },
];
