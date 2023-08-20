import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swag_cross_app/constants/gaps.dart';
import 'package:swag_cross_app/features/customer_service/faq/faq_edit_screen.dart';
import 'package:swag_cross_app/models/post_card_model.dart';
import 'package:swag_cross_app/providers/user_provider.dart';

import 'package:http/http.dart' as http;
import 'package:swag_cross_app/utils/time_parse.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({
    super.key,
  });

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<PostCardModel>? _faqList;

  @override
  void initState() {
    super.initState();

    _onFaqGetDispatch();
  }

  Future<List<PostCardModel>> _onFaqGetDispatch() async {
    final url =
        Uri.parse("http://58.150.133.91:80/together/post/getPostByBoardId");
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "boardId": "2",
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as List<dynamic>;
      print("FAQ 리스트 : 성공");
      print(jsonResponse);

      // 응답 데이터를 ClubSearchModel 리스트로 파싱
      final faqList =
          jsonResponse.map((data) => PostCardModel.fromJson(data)).toList();

      return faqList;
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception("FAQ 데이터를 불러오는데 실패하였습니다.");
    }
  }

  Future<void> _onRefreshFaqList() async {
    _faqList = await _onFaqGetDispatch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLogined = context.watch<UserProvider>().isLogined;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder(
        future: _faqList != null
            ? Future.value(_faqList!) // _postList가 이미 가져온 상태라면 Future.value 사용
            : _onFaqGetDispatch(),
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
            _faqList = snapshot.data!;

            return RefreshIndicator.adaptive(
              onRefresh: _onRefreshFaqList,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                itemBuilder: (context, index) {
                  final item = _faqList![index];
                  return ExpansionTile(
                    title: Text(
                      item.postTitle,
                    ),
                    subtitle: Text(
                      TimeParse.getTimeAgo(item.postCreationDate),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    // trailing: Icon(
                    //   _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    //   size: 30,
                    // ),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          item.postContent,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Gaps.v20,
                      if (isLogined)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => context.pushNamed(
                                  FaqEditScreen.routeName,
                                  extra: FaqEditScreenArgs(
                                    postData: item,
                                    pageName: "자주묻는 질문 수정",
                                  ),
                                ),
                                child: const Text("수정"),
                              ),
                              Gaps.h10,
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("삭제"),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gaps.v6,
                itemCount: _faqList!.length,
              ),
            );
          }
        },
      ),
    );
  }
}

// List<Map<String, dynamic>> faqList = [
//   {
//     "id": 1,
//     "title": "제목1",
//     "content": "내용1",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 2,
//     "title": "제목2",
//     "content": "내용2",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 3,
//     "title": "제목3",
//     "content": "내용3",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 4,
//     "title": "제목4",
//     "content": "내용4",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 5,
//     "title": "제목5",
//     "content": "내용5",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 6,
//     "title": "제목6",
//     "content": "내용6",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 7,
//     "title": "제목7",
//     "content": "내용7",
//     "date": "2023-07-10 16:43",
//   },
//   {
//     "id": 8,
//     "title": "제목8",
//     "content": "내용8",
//     "date": "2023-07-10 16:43",
//   },
// ];
