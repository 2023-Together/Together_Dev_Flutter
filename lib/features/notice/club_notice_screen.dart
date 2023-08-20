import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/notice/widgets/notice_card.dart';
import 'package:swag_cross_app/features/notice/notice_edit_screen.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;

class ClubNoticeScreen extends StatefulWidget {
  static const routeName = "club_notice";
  static const routeURL = "club_notice";

  const ClubNoticeScreen({
    super.key,
  });

  @override
  State<ClubNoticeScreen> createState() => _ClubNoticeScreenState();
}

class _ClubNoticeScreenState extends State<ClubNoticeScreen> {
  List<PostCardModel>? _noticeList;

  Future<List<PostCardModel>> _noticeGetDispatch() async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getAllPostForMain");
    final response = await http.get(url);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("메인 커뮤니티 : 성공");

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      _noticeList =
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList();

      return _noticeList!;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("게시물 데이터를 불러오는데 실패하였습니다.");
    }
  }

  Future<void> _onRefreshNoticeList() async {
    _noticeList = await _noticeGetDispatch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    final userData = context.watch<UserProvider>().userData;
    return Scaffold(
      // 키보드를 열었을때 사이즈가 조정되는 현상을 해결
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("동아리 공지사항"),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: isLogined ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          heroTag: "community_edit",
          onPressed: () {
            // 동아리 게시글 작성
            context.pushNamed(NoticeEditScreen.routeName);
          },
          backgroundColor: Colors.blue.shade300,
          child: const FaIcon(
            FontAwesomeIcons.penToSquare,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _noticeList != null
            ? Future.value(
                _noticeList!) // _postList가 이미 가져온 상태라면 Future.value 사용
            : _noticeGetDispatch(),
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
            _noticeList = snapshot.data!;

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              itemBuilder: (context, index) {
                final item = _noticeList![index];
                return NoticeCard(
                  noticeData: item,
                  userId: userData!.userId,
                );
              },
              separatorBuilder: (context, index) => Gaps.v6,
              itemCount: _noticeList!.length,
            );
          }
        },
      ),
    );
  }
}

List<Map<String, dynamic>> noticeList = [
  {
    "id": 1,
    "title": "제목1",
    "content": "내용1",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 2,
    "title": "제목2",
    "content": "내용2",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 3,
    "title": "제목3",
    "content": "내용3",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 4,
    "title": "제목4",
    "content": "내용4",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 5,
    "title": "제목5",
    "content": "내용5",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 6,
    "title": "제목6",
    "content": "내용6",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 7,
    "title": "제목7",
    "content": "내용7",
    "date": "2023-07-10 16:43",
  },
  {
    "id": 8,
    "title": "제목8",
    "content": "내용8",
    "date": "2023-07-10 16:43",
  },
];
